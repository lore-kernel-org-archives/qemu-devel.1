Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC47C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AAF20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtKMOxRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AAF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecxZ-0006dQ-VT
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iecwz-0006Bs-Jj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iecwy-0000dK-Cj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:41:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iecwy-0000dB-8l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575974463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O8+kODHnSimEUI+dp7bBf8R1U0zTXEAnrYbafEBSAbY=;
 b=DtKMOxRAZbzPou7G/JfJORqacrWSZMRtS3hz+sdjzopjkcobv6z9GDttkpMfluR52B01Qx
 ATn9AYrLQfh5Er2CVq5eO2mqnI72hNbx+ReP23wFZpjEGUM/RU66s7/VslfWBOJDjmBg4J
 YUd16vrProrK9n3D466MauXJgio5aAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-In-2ecyoMA2u9Ts3YdikXA-1; Tue, 10 Dec 2019 05:40:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1928F100CF69;
 Tue, 10 Dec 2019 10:40:57 +0000 (UTC)
Received: from [10.36.117.222] (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16D335D72A;
 Tue, 10 Dec 2019 10:40:51 +0000 (UTC)
Subject: Re: [for-5.0 PATCH v2 0/3] cpu: Clarify overloading of reset QOM
 methods
To: Greg Kurz <groug@kaod.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <8a22b669-c4b3-503b-330a-4000f615b397@redhat.com>
Date: Tue, 10 Dec 2019 11:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: In-2ecyoMA2u9Ts3YdikXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.12.19 18:55, Greg Kurz wrote:
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

Acked-by: David Hildenbrand <david@redhat.com>

For all patches (this sorts out something that was bugging me a while
ago :) )

--=20
Thanks,

David / dhildenb


