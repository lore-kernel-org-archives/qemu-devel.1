Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFFAC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59AC2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQUpiXbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59AC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPVb-0002gl-To
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOP9X-0001qq-2r
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOP9V-00067p-U9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:15:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOMzj-00071f-6R
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:56:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id t14so1452182wrw.12
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Gtxbdlm72vvTaIPyJNm/xnYijqhLcCiptWpyPLYeWKU=;
 b=LQUpiXbwSG8h2B4r90v+vQdsPccFoxvsImyR11qFQ7sfF0CdfaGSJDWhYZvkI6CBPK
 f6/YR4EWgK1eUdMK6ZwgtFsdkNyhmFEiA0yw0/W0MiwGSFVkse67MFQMC/UKMsrgl/j3
 c938otO6bsrmYLmt2RRWN/RqlbPhqzkQdpTMcD7J2ARlAfMIM7mXn9f0bRNtEYWtB8WQ
 ou1/tEmdewo0DDOcTyhEV3G34Bh+Aw5dIuKNW0VtqYTgFVKx0iHqpHXDTByGAfhac0bp
 heOF5PYmLJ2QH7bPczH0IaqoBaYkXc/bMxK7klxTocNndQgosSQWavQ5iIR9JsGDQlIh
 t9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Gtxbdlm72vvTaIPyJNm/xnYijqhLcCiptWpyPLYeWKU=;
 b=mPz+HO6jXXPw8eVfYSD6NsFymmrJw28kgk0u65koys3bNRZSzzNbO2aTV80sGTzUyI
 +wDD8oHt/+RXSBlt0NekuskpI7nXAUJ6zRgpAV7wpUDywl/s7bpykrgVk/QhCeAj9gzL
 VS9eYO0X4fMPlpgtwVCeIA6aJV3sOhfJ2DKeIjMxibWf4ytSWTD3JVMoUzr43PaANetb
 J1dpJwlce6hoHfntjCVOd/+yf05SpkzH9kwB8dKOWsfmUVEAAI0hDE5BwxZ/hFwRH9Xt
 xANEL4qKnagVYV6wHRNb5SZevyLLbPwcSLJxRUoq+eV9RL4kJPA6uP5P+CiBrCe7B+rJ
 A+Zw==
X-Gm-Message-State: AGi0PuawTzm9hinOUloIKWa+7keddgAQHvIAKl1KLZYldof+pCy52mvK
 WW2m8nayYngJ1KFryk46434grQ==
X-Google-Smtp-Source: APiQypIx2dDa3Zun8BVzrP44O8TzgjlTlMbjPWde3nQ8RlpWgEa+gXTLxG8w17f2SnwBotUpjoQTCw==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr25026947wrs.5.1586876217783;
 Tue, 14 Apr 2020 07:56:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 138sm19848083wmb.14.2020.04.14.07.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 07:56:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7BD331FF7E;
 Tue, 14 Apr 2020 15:56:55 +0100 (BST)
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <20200411182934.28678-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0? 2/3] scripts/kernel-doc: Add missing
 close-paren in c:function directives
In-reply-to: <20200411182934.28678-3-peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 15:56:55 +0100
Message-ID: <874ktm9kug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> When kernel-doc generates a 'c:function' directive for a function
> one of whose arguments is a function pointer, it fails to print
> the close-paren after the argument list of the function pointer
> argument, for instance:

for instance in the memory API documentation:

?

>   .. c:function:: void memory_region_init_resizeable_ram (MemoryRegion * =
mr, struct Object * owner, const char * name, uint64_t size, uint64_t max_s=
ize, void (*resized) (const char*, uint64_t length, void *host, Error ** er=
rp)
>
> which should have a ')' after the 'void *host' which is the
> last argument to 'resized'.
>
> Older versions of Sphinx don't try to parse the argumnet
> to c:function, but Sphinx 3.0 does do this and will complain:
>
>   /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory=
.h:834: WARNING: Error in declarator or parameters
>   Invalid C declaration: Expecting "," or ")" in parameters, got "EOF". [=
error at 208]
>     void memory_region_init_resizeable_ram (MemoryRegion * mr, struct Obj=
ect * owner, const char * name, uint64_t size, uint64_t max_size, void (*re=
sized) (const char*, uint64_t length, void *host, Error ** errp)
>     ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------------------------------------^
>
> Add the missing close-paren.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

