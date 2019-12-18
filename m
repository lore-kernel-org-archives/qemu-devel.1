Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CB72176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC4xWVRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CB72176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihTLr-00008l-4B
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 02:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihTKl-0007qJ-EV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihTKk-0005c3-9P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:01:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihTKi-0005aT-T4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576652480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9pn+4Vtcq0oZDI+xcjPNflyOFqfgk3yhBz96KpjnEek=;
 b=fC4xWVRxMIcP1uFtLJhhd36VRQU1fvQ25vGVy3LkZNG1YylfPmKRkf7UXyL26GkbVkssJ3
 gy3ZjE5S1cx21Qq3Wr/q14DNUvByY8g9NJrofph5ezfUemlLt75mKnVR+LiZMuMn50Wu/B
 erEQsA4q/AaHJ7fntQqneJh04vMzn5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Hh_R525kOpqx0rPYvmqCqw-1; Wed, 18 Dec 2019 02:01:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87001023120;
 Wed, 18 Dec 2019 07:01:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4097D8FC;
 Wed, 18 Dec 2019 07:01:13 +0000 (UTC)
Subject: Re: [PATCH 2/7] tcg: Remove softmmu code_gen_buffer fixed address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-3-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b50b200c-beee-6c8b-d8f9-994555427576@redhat.com>
Date: Wed, 18 Dec 2019 08:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218031920.6414-3-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Hh_R525kOpqx0rPYvmqCqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 04.19, Richard Henderson wrote:
> The commentary talks about "in concert with the addresses
> assigned in the relevant linker script", except there is no
> linker script for softmmu, nor has there been for some time.
> 
> (Do not confuse the user-only linker script editing that was
> removed in the previous patch, because user-only does not
> use this code_gen_buffer allocation method.)
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/translate-all.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 9f48da9472..88468a1c08 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1032,47 +1032,20 @@ static inline void *alloc_code_gen_buffer(void)
>  {
>      int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
>      int flags = MAP_PRIVATE | MAP_ANONYMOUS;
> -    uintptr_t start = 0;
>      size_t size = tcg_ctx->code_gen_buffer_size;
>      void *buf;
>  
> -    /* Constrain the position of the buffer based on the host cpu.
> -       Note that these addresses are chosen in concert with the
> -       addresses assigned in the relevant linker script file.  */
> -# if defined(__PIE__) || defined(__PIC__)
> -    /* Don't bother setting a preferred location if we're building
> -       a position-independent executable.  We're more likely to get
> -       an address near the main executable if we let the kernel
> -       choose the address.  */
> -# elif defined(__x86_64__) && defined(MAP_32BIT)
> -    /* Force the memory down into low memory with the executable.
> -       Leave the choice of exact location with the kernel.  */
> -    flags |= MAP_32BIT;
> -    /* Cannot expect to map more than 800MB in low memory.  */
> -    if (size > 800u * 1024 * 1024) {
> -        tcg_ctx->code_gen_buffer_size = size = 800u * 1024 * 1024;
> -    }
> -# elif defined(__sparc__)
> -    start = 0x40000000ul;
> -# elif defined(__s390x__)
> -    start = 0x90000000ul;
> -# elif defined(__mips__)
> -#  if _MIPS_SIM == _ABI64
> -    start = 0x128000000ul;
> -#  else
> -    start = 0x08000000ul;
> -#  endif
> -# endif
> -
> -    buf = mmap((void *)start, size, prot, flags, -1, 0);
> +    buf = mmap(NULL, size, prot, flags, -1, 0);
>      if (buf == MAP_FAILED) {
>          return NULL;
>      }
>  
>  #ifdef __mips__
>      if (cross_256mb(buf, size)) {
> -        /* Try again, with the original still mapped, to avoid re-acquiring
> -           that 256mb crossing.  This time don't specify an address.  */
> +        /*
> +         * Try again, with the original still mapped, to avoid re-acquiring
> +         * the same 256mb crossing.
> +         */
>          size_t size2;
>          void *buf2 = mmap(NULL, size, prot, flags, -1, 0);
>          switch ((int)(buf2 != MAP_FAILED)) {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


