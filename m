Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE541C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8C42173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zy99WEx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8C42173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4lZ-0005jv-Id
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 09:25:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT4kg-0005Gi-8v
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT4kf-000457-3u
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:24:22 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT4ke-00043D-G8
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:24:21 -0400
Received: by mail-oi1-x243.google.com with SMTP id y124so8427436oiy.3
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=diA0SsMrXBLmT2N9PQJnWiN+F96Sv2zyvk77RxAg9lE=;
	b=zy99WEx2+/9GvApYnZTAQxx016cZhxnw2pzq1UiQ7PVa5eq7Fnm8KbA1PeOtD0LRPJ
	GZ1PlQFNnDojY43c+YRkir/+X9ByK5/NEPAEb1/mjZs+Ny2xN48Pb2nAI4kPTyVCE5ob
	gycC9xcw4flFreIdOAQplzqkU/dEruo1kX+8TUkN+Fhm8RHvGYMrsK7lU3DBzROz5E17
	Okp5CS8S1oi3hFL0rza9mS3mD5k7unCBgDCrma9oYdkQ0O83UID0Es8gGwbpOZ2tohm5
	IIeyJDbKaJaH+Z/15TfTEWiaOD/XOI6CvgqRdCH8jF9IMNhqiStJ6eA6OMghN8LBRKH9
	G8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=diA0SsMrXBLmT2N9PQJnWiN+F96Sv2zyvk77RxAg9lE=;
	b=IPNSnUcKHpP6gwrX8A0L5g+BVwTaDJlcuSIUvdiRx/3+aTei52/bjfUDDyuA/4wdJ9
	loHKeAB7QsExxej+93m4fna6XzUOll1dBjCqEWNTz6d6tOecuwqdOozEsm+ulf/vhB0W
	7b5yFD1E+F/8hiMPhkkTi2g6qaQWkDTVLHu5Sezl+8B3Uldh1b6QWEl3RZ/iTTpTbDyR
	m+MSq6lydvCpw0VNRNzIwDXnRpUfNoI5hpzpDxsY0wwdyiBAvNYEPXeVTusLyPUjojRw
	kBnRHB07Um37khADAbbYBvdJSaRN7BEXKQ5F1CjeVDX8KKx62Ae1IUnSOGQeLZ7Qz88f
	1dpw==
X-Gm-Message-State: APjAAAUGisbkUHkhM9W4HcTV0ImFGLixZKNUSIv4Xn/03EwaQ/eTLNh/
	OfDAPC5s4DNM1ExgNPOW2rYJFxBqZU8D3yR2m/IE4w==
X-Google-Smtp-Source: APXvYqwBWMHWkScWCOM6MfrY6eCNvU3IhHajMVRcA4RElrCmHro97vli5n2XpA7cbvy6Hbcirn4cJxt6U8I9Q4EWLpI=
X-Received: by 2002:aca:5785:: with SMTP id l127mr3169297oib.48.1558445059425; 
	Tue, 21 May 2019 06:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190521092048.28492-1-cohuck@redhat.com>
In-Reply-To: <20190521092048.28492-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 14:24:07 +0100
Message-ID: <CAFEAcA_9QZRyx8_8qT208vsopquW5j-bkyZpmRCAhP-sqJ+0kg@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL v2 00/54] s390x update
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 10:20, Cornelia Huck <cohuck@redhat.com> wrote:
>
> [Note: I'm only sending the changed headers update to spare everybody another
> patch avalanche. The remainder of the patches is unchanged, save for the
> changed commit ids of the cpumodel patches on top of the headers update.]
>
> The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190521-2
>
> for you to fetch changes up to 4d727d1aa0e5cbf9f5f00968698dfa34c7b47b08:
>
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines (2019-05-21 10:40:03 +0200)
>
> ----------------------------------------------------------------
> s390x update:
> - have the bios tolerate bootmap signature entries
> - next chunk of vector instruction support in tcg
> - a headers update against Linux 5.2-rc1
> - add more facilities and gen15 machines to the cpu model

Hi -- looks like the update-linux-headers change isn't quite right:

--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -122,6 +122,9 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
         cp "$tmpdir/include/asm/unistd-common.h"
"$output/linux-headers/asm-arm/"
     fi
+    if [ $arch = arm64 ]; then
+        cp "$tmpdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm/"
+    fi
     if [ $arch = x86 ]; then
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"

...it's copying the file into asm-arm/ rather than asm-arm64/.
(I did a by-hand move of the file into the right directory and
that was sufficient for the compile to succeed.)

Also, can we keep the changes to scripts/ in a separate
commit, please? The idea of header-update commits is that they
should contain only the changes automatically generated
by the script, with no hand-written additions.

thanks
-- PMM

