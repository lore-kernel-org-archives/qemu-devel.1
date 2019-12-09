Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D443CC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB182077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoPflkVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB182077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNph-0003Rq-JH
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieNbU-0008DA-Q8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieNbT-0007sA-KP
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieNbT-0007rQ-GQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575915470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/8iD3Drs3CR5g4H++10+p08axZ4cAuwMRyK9QszuTo=;
 b=RoPflkVAcxOw1nbfGs3vrOVqeoyabcoje0J/qMZPMyoRcJebYcCDVgL5w0dRdZYPNZEMiM
 /IMJ6OokrxkqQfm/hNjptw78DXkCvT3TyjOXgTAvuG3vZejmLQ8GEh6myvUn5SBYi9amcT
 FCUmh5tooM0b8605Mfc5yIlLeKxksAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-os0a7UBSP9muapp6cjUptw-1; Mon, 09 Dec 2019 13:17:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B47D10054E3;
 Mon,  9 Dec 2019 18:17:48 +0000 (UTC)
Received: from gondolin (ovpn-116-43.ams2.redhat.com [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC2D817C;
 Mon,  9 Dec 2019 18:17:41 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:17:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH v2 1/3] cpu: Introduce CPUReset callback typedef
Message-ID: <20191209191738.4a33a67f.cohuck@redhat.com>
In-Reply-To: <157591411864.46967.18244018296239778673.stgit@bahia.lan>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
 <157591411864.46967.18244018296239778673.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: os0a7UBSP9muapp6cjUptw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Mon, 09 Dec 2019 18:55:18 +0100
Greg Kurz <groug@kaod.org> wrote:

> Use it in include/hw/core/cpu.h and convert all targets to use it as
> well with:
> 
> perl -pi \
>  -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
>  $(git ls-files 'target/*.h')
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/core/cpu.h       |    4 +++-
>  target/alpha/cpu-qom.h      |    2 +-
>  target/arm/cpu-qom.h        |    2 +-
>  target/cris/cpu-qom.h       |    2 +-
>  target/hppa/cpu-qom.h       |    2 +-
>  target/i386/cpu-qom.h       |    2 +-
>  target/lm32/cpu-qom.h       |    2 +-
>  target/m68k/cpu-qom.h       |    2 +-
>  target/microblaze/cpu-qom.h |    2 +-
>  target/mips/cpu-qom.h       |    2 +-
>  target/moxie/cpu.h          |    2 +-
>  target/nios2/cpu.h          |    2 +-
>  target/openrisc/cpu.h       |    2 +-
>  target/ppc/cpu-qom.h        |    2 +-
>  target/riscv/cpu.h          |    2 +-
>  target/s390x/cpu-qom.h      |    2 +-
>  target/sh4/cpu-qom.h        |    2 +-
>  target/sparc/cpu-qom.h      |    2 +-
>  target/tilegx/cpu.h         |    2 +-
>  target/tricore/cpu-qom.h    |    2 +-
>  target/xtensa/cpu-qom.h     |    2 +-
>  21 files changed, 23 insertions(+), 21 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


