Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F99EC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB632072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SikNJeqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB632072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieF0t-0000K3-5L
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieF0I-0008LR-Kh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieF0H-000666-LD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:06:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieF0H-00064Z-Gp
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPcHt4FruPmLpvlbJ/uG6tutOovqaMakF5ZEKAv2Q2s=;
 b=SikNJeqCKNbxpHZpAWbbWHJdCVZBKfuh6QpuAhq0msERNZSipfF//ac7Ll3rjny8BSQdpK
 mvwxkOQ1E8xX2aNyofKqvpTVM366sWo1sPfmuwV0O+NSaja5i345KtYTOFSzOkCkqyBkoC
 rJxyImq3DmMfs7oXCmLgK9P6ewXCDbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-xdOr8iS_MZCt0Cdxl-C4tA-1; Mon, 09 Dec 2019 04:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0D51005513;
 Mon,  9 Dec 2019 09:06:49 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4D9310016E8;
 Mon,  9 Dec 2019 09:06:42 +0000 (UTC)
Date: Mon, 9 Dec 2019 10:06:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 1/3] cpu: Introduce CPUReset callback typedef
Message-ID: <20191209100640.6fa2f2e1.cohuck@redhat.com>
In-Reply-To: <157565783446.3897844.13799667957070272380.stgit@bahia.lan>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565783446.3897844.13799667957070272380.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xdOr8iS_MZCt0Cdxl-C4tA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Fri, 06 Dec 2019 19:43:54 +0100
Greg Kurz <groug@kaod.org> wrote:

> Use it in include/hw/core/cpu.h and convert all targets to use it as
> well with:
> 
> perl -pi \
>  -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
>  $(git ls-files 'target/*.h')
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
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
> 

> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index b809ec8418e0..cc23edc92198 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -55,7 +55,7 @@ typedef struct S390CPUClass {
>      const char *desc;
>  
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      void (*load_normal)(CPUState *cpu);
>      void (*cpu_reset)(CPUState *cpu);
>      void (*initial_cpu_reset)(CPUState *cpu);

Looks sane, but unfortunately clashes with the s390x cpu reset rework
in the s390-next branch. At least this patch looks easy to rebase on
top of that, though.


