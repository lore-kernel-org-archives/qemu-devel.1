Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA76C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721D52080D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5/sGk33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721D52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO3W-0004Tu-Q4
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieNfR-0005p3-Un
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieNfQ-0001p4-J4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:21:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieNfQ-0001oc-ER
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575915716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b975lKa4XPNOOKxGBI3yMbmizCt3/iHsbMAmYc9JHiY=;
 b=W5/sGk33Gam+JfAKBOOF3scQxNGxX4ZW8cxFdooQbo3ZJ0EG0lJHH84um00JLGiGwVUCVY
 y5dsGvAGBiYYAieu2qUmQGk7qUi81wZds5jEx9z8kxeKJtN4BMfnjIhJnZbaz0qs0CiU1u
 MvoLXax7j/7MbDJKdKzUKa9a2kqwrSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-OP8F_OuhOlqjQaUtdxvNBg-1; Mon, 09 Dec 2019 13:21:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 060DC800D4E;
 Mon,  9 Dec 2019 18:21:53 +0000 (UTC)
Received: from gondolin (ovpn-116-43.ams2.redhat.com [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 500D25C1B2;
 Mon,  9 Dec 2019 18:21:46 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:21:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH v2 0/3] cpu: Clarify overloading of reset QOM
 methods
Message-ID: <20191209192143.3dda1b54.cohuck@redhat.com>
In-Reply-To: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OP8F_OuhOlqjQaUtdxvNBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 18:55:12 +0100
Greg Kurz <groug@kaod.org> wrote:

> Each cpu subclass overloads the reset method of its parent class with
> its own. But since it needs to call the parent method as well, it keeps
> a parent_reset pointer to do so. This causes the same not very explicit
> boiler plate to be duplicated all around the place:
>=20
>     pcc->parent_reset =3D cc->reset;
>     cc->reset =3D ppc_cpu_reset;
>=20
> A similar concern was addressed some time back by Philippe Mathieu-Daud=
=C3=A9
> in qdev, with the addition of device_class_set_parent_reset() and friends=
:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D46795cf2e2f6
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dbf853881690d
>=20
> Follow the same approach with cpus.
>=20
> Changes in v2:
> - added Reviewed-by and Acked-by tags
> - rebased on top of https://github.com/cohuck/qemu.git s390-next
>   SHA1 dd6252f035a2

My apologies for the churn. I'll try to flush my queue ASAP after 5.0
development opens.

>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (3):
>       cpu: Introduce CPUReset callback typedef
>       cpu: Introduce cpu_class_set_parent_reset()
>       cpu: Use cpu_class_set_parent_reset()
>=20
>=20
>  hw/core/cpu.c                   |    8 ++++++++
>  include/hw/core/cpu.h           |    8 +++++++-
>  target/alpha/cpu-qom.h          |    2 +-
>  target/arm/cpu-qom.h            |    2 +-
>  target/arm/cpu.c                |    3 +--
>  target/cris/cpu-qom.h           |    2 +-
>  target/cris/cpu.c               |    3 +--
>  target/hppa/cpu-qom.h           |    2 +-
>  target/i386/cpu-qom.h           |    2 +-
>  target/i386/cpu.c               |    3 +--
>  target/lm32/cpu-qom.h           |    2 +-
>  target/lm32/cpu.c               |    3 +--
>  target/m68k/cpu-qom.h           |    2 +-
>  target/m68k/cpu.c               |    3 +--
>  target/microblaze/cpu-qom.h     |    2 +-
>  target/microblaze/cpu.c         |    3 +--
>  target/mips/cpu-qom.h           |    2 +-
>  target/mips/cpu.c               |    3 +--
>  target/moxie/cpu.c              |    3 +--
>  target/moxie/cpu.h              |    2 +-
>  target/nios2/cpu.c              |    3 +--
>  target/nios2/cpu.h              |    2 +-
>  target/openrisc/cpu.c           |    3 +--
>  target/openrisc/cpu.h           |    2 +-
>  target/ppc/cpu-qom.h            |    2 +-
>  target/ppc/translate_init.inc.c |    3 +--
>  target/riscv/cpu.c              |    3 +--
>  target/riscv/cpu.h              |    2 +-
>  target/s390x/cpu-qom.h          |    2 +-
>  target/s390x/cpu.c              |    3 +--
>  target/sh4/cpu-qom.h            |    2 +-
>  target/sh4/cpu.c                |    3 +--
>  target/sparc/cpu-qom.h          |    2 +-
>  target/sparc/cpu.c              |    3 +--
>  target/tilegx/cpu.c             |    3 +--
>  target/tilegx/cpu.h             |    2 +-
>  target/tricore/cpu-qom.h        |    2 +-
>  target/tricore/cpu.c            |    3 +--
>  target/xtensa/cpu-qom.h         |    2 +-
>  target/xtensa/cpu.c             |    3 +--
>  40 files changed, 53 insertions(+), 57 deletions(-)
>=20


