Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE39C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D806420693
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Feqk6PbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D806420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34511 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKQye-00084A-3e
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 13:19:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hKQxd-0007gH-5w
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hKQxc-0005wK-9Z
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:18:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hKQxa-0005u4-39; Sat, 27 Apr 2019 13:17:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so3104660pgl.5;
	Sat, 27 Apr 2019 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ndmDw5GF7Gy0cUdTRq5wruYjRgnT9v9b/B51Ixp1Zyc=;
	b=Feqk6PbDdvWu7tWblpqH8vlMV049I/MJ0MmMhIjreNCCEBBrjzKgdIpm0uHi/TE7Ye
	ZQugqNK8WPqG5jzR49aN93ql87OuH0R2sMHXJxAuYQ10HRDlHXeTILYJGz+ah0CEAfep
	PINrlFmpTLX5dfxDVyHGp3lDwBauKSCK8Dax+DyIBlhCYgcaJrJns8aRcq0izSaExnCe
	FyFgXCeNOC3CwUvTf/koeGtBIORmdmDnk8+vfdvNfWkRog+HBOIFwk80R29K5cAg1MYh
	FD9J8tehf0knAHBhq6pYR6SAsAFSSpTn78ad2XavXp6zg83mkxamZkcXDuCYeaFgtMIw
	F4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=ndmDw5GF7Gy0cUdTRq5wruYjRgnT9v9b/B51Ixp1Zyc=;
	b=UKrd6aYzQuHbrWOu/HSD0hQm6qWA6PTRTH+uHM8DvFHurWTcN3VbsYNaHAN7bFf9q5
	ER9NTzE4gtRHiN2inVver9L/lnStJVijK88AFQZFAgJv+xXa13K17nXNEzmbrLocZR6G
	H6Aj0N7aifPaTT5I49e0SJ7wUvIJ28IDkjkDAh+cJjRHRy+shIzcghRvzzBptrSAMdHf
	OwbJyau3JgU7naCwAWnP7suf/i2IqbFUypeQit14evGSGXdv3i6GGVOABpyXQrBlqOy9
	So/lssc5nn7OTF6YDFheLg/Rudxg5BdArciMr8huQmnkF3R976R3yorCQ+ckw6Vvqwnm
	sujA==
X-Gm-Message-State: APjAAAUQKGoINNqgM4fM3N1YLADSL/Z9rr9bnr6CEL6QAEm5AvCAahzf
	MGQeTBnJYVCDB9RTsI87Kb4Xy2/v
X-Google-Smtp-Source: APXvYqxcjcyIlWa6jSBUEAMGWDm547oxfhM/jmSF/p4MYG4J4NMM/pSLo8GKYQkZs9mp7P1FtGs6Sw==
X-Received: by 2002:a63:da51:: with SMTP id l17mr8343072pgj.115.1556385475660; 
	Sat, 27 Apr 2019 10:17:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.googlemail.com with ESMTPSA id
	q78sm24626600pfi.76.2019.04.27.10.17.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 Apr 2019 10:17:54 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
References: <20190427154539.11336-1-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <82672e3e-b7e4-4b07-a31b-c600e1374607@twiddle.net>
Date: Sat, 27 Apr 2019 10:17:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427154539.11336-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] configure: Add -Wno-typedef-redefinition
 to CFLAGS (for Clang)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427171751.Pr4Lt5OvfsrgGKMlbTWdcCIsnr-ntxiEpq179bUVQXU@z>

On 4/27/19 8:45 AM, Thomas Huth wrote:
> Without the -Wno-typedef-redefinition option, clang complains if a typedef
> gets redefined in gnu99 mode (since this is officially a C11 feature). This
> used to also happen with older versions of GCC, but since we've bumped our
> minimum GCC version to 4.8, all versions of GCC that we support do not seem
> to issue this warning in gnu99 mode anymore. So this has become a common
> problem for people who only test their code with GCC - they do not notice
> the issue until they submit their patches and suddenly patchew or a
> maintainer complains.
> 
> Now that we do not urgently need to keep the code clean from typedef
> redefintions anymore with recent versions of GCC, we can ease the
> situation with clang, too, and simply shut these warnings off for good.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

