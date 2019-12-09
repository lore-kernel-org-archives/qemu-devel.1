Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14219C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CC3205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MROZJ344"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CC3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNv5-0002Tn-88
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieNeL-00046p-S5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieNeG-0001GG-UQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:20:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieNeG-0001G5-QX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575915644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8y1YJe0SC+pao6d1zphnCGK3i03zUFpxrgx6WtwVD0=;
 b=MROZJ344iu1Nq5k+Sm8u+ktpxslj7HRp33bmU60VgVJKlVCyEYY7AGatFFhMrogY1Dnmj9
 NERAujGHnoe09jA+6yoGa1v5p6I4pecH/zsM2wwUP1hwRAsYwiNDFHqi7cLzsXG6j1bFmD
 EFkGSgh85HUrdd0hx8bVaErKMXmzaMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-Hg_EuBGTOGqBjpGPbRcCyg-1; Mon, 09 Dec 2019 13:20:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E181800D7B;
 Mon,  9 Dec 2019 18:20:41 +0000 (UTC)
Received: from gondolin (ovpn-116-43.ams2.redhat.com [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A03E5D6B7;
 Mon,  9 Dec 2019 18:20:34 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:20:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH v2 3/3] cpu: Use cpu_class_set_parent_reset()
Message-ID: <20191209192014.6f203576.cohuck@redhat.com>
In-Reply-To: <157591413022.46967.2691055340406044579.stgit@bahia.lan>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
 <157591413022.46967.2691055340406044579.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Hg_EuBGTOGqBjpGPbRcCyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 09 Dec 2019 18:55:30 +0100
Greg Kurz <groug@kaod.org> wrote:

> Convert all targets to use cpu_class_set_parent_reset() with the following
> coccinelle script:
> 
> @@
> type CPUParentClass;
> CPUParentClass *pcc;
> CPUClass *cc;
> identifier parent_fn;
> identifier child_fn;
> @@
> +cpu_class_set_parent_reset(cc, child_fn, &pcc->parent_fn);
> -pcc->parent_fn = cc->reset;
> ...
> -cc->reset = child_fn;
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/arm/cpu.c                |    3 +--
>  target/cris/cpu.c               |    3 +--
>  target/i386/cpu.c               |    3 +--
>  target/lm32/cpu.c               |    3 +--
>  target/m68k/cpu.c               |    3 +--
>  target/microblaze/cpu.c         |    3 +--
>  target/mips/cpu.c               |    3 +--
>  target/moxie/cpu.c              |    3 +--
>  target/nios2/cpu.c              |    3 +--
>  target/openrisc/cpu.c           |    3 +--
>  target/ppc/translate_init.inc.c |    3 +--
>  target/riscv/cpu.c              |    3 +--
>  target/s390x/cpu.c              |    3 +--
>  target/sh4/cpu.c                |    3 +--
>  target/sparc/cpu.c              |    3 +--
>  target/tilegx/cpu.c             |    3 +--
>  target/tricore/cpu.c            |    3 +--
>  target/xtensa/cpu.c             |    3 +--
>  18 files changed, 18 insertions(+), 36 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


