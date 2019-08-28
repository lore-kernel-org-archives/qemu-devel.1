Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34216C41514
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AE522CF5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKUlMVsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AE522CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2y8T-0000uh-4u
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2y5t-0007z9-JP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2y5s-0002z1-DW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:34:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i2y5q-0002wg-P4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:34:36 -0400
Received: by mail-ot1-x341.google.com with SMTP id e12so2723586otp.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=yBiz3wJbIDASM2OERTQCRyvc2KI22k5CUBY5WAkJkus=;
 b=FKUlMVsh8HzzKyGwTri5FrGpom+dHmWrUn9oFKuzIbksWZfwOWzJkU1BeBClOJS8g6
 lmG6QbEIB7GnbuVE872OWedzkweZiltwRzDW7wh2wqIrXUwewMcVEZ5lhSubnnoCFQ6j
 dPm/vbNgODTsDZQwLU7W7Q7QlXkVnN1pbhx/FhgNAtIYJHaRjPA7gzDmoNz6dsm8gs4F
 U7toi1zyb27obKX5a+/VdkQVTPqLMohIOrS8TVLtypBYmpBJAdSeKSlCNii9f48Jkm5Q
 HkNDXFIpNZFmYw1wcXC/AmeP4efWewJdRIoaOEAIFh/itRgK+FmTtrK+VDUdUIMFXvgu
 ltZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=yBiz3wJbIDASM2OERTQCRyvc2KI22k5CUBY5WAkJkus=;
 b=TYmfoT57CUVIWOt06olczTadbhgpJbu+KE32MthkGUpo1GlD/EYd/caqklar/fmxbT
 +I/iTo733o5RGDvE0ThGTPt4CuUgo0h4fDa+pAD2qIQdnRgl/NyMnjk/gj2ZtIT0sZqb
 v51iOm4bE6BCMmXrzDNLLDxO/F4Kl1PlHd6TKcl2VGwVImXIhbamj7e3CmPtPRVDVjWp
 2zFsNmo0J4DN7DpQLVW4qge3gnpYVwvqXnZnzkR/6t8N9pSnPRIcOKJxfAOldfACqSZg
 mI3CQnP127xt2o5JP9YodyqcYIvuNlWsNha2NKcmaRWqZ8vNfHKObDuNQruIpAqcJ//1
 E3cA==
X-Gm-Message-State: APjAAAUddDuJzykfC+YABVaWbrL5p1BMZ0BJfA3YEmBeMhf+t9hKVKS1
 igD0z2pFwmXMIAqFNz1FQodx7YMN7sMIvLGgn7g=
X-Google-Smtp-Source: APXvYqy2Q3P6ISnr1tmAy+oPDngtKs5amyYIZ8SeS5v0KgVMJg7Rdmn32bJN9Epfq/c4+dLaKybZTrdHwnZK/YQyl7Y=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr3226364otg.306.1566999271396; 
 Wed, 28 Aug 2019 06:34:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 28 Aug 2019 06:34:29
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 28 Aug 2019 06:34:29
 -0700 (PDT)
In-Reply-To: <20190828120832.9208-2-alex.bennee@linaro.org>
References: <20190828120832.9208-1-alex.bennee@linaro.org>
 <20190828120832.9208-2-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 28 Aug 2019 15:34:29 +0200
Message-ID: <CAL1e-=htByDFYtzVFnjyxLB6QLBxT9MeKEh48HR97fp_cMaq5A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 1/8] contrib/gitdm: filetype interface
 is not in order, fix
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.08.2019. 14.09, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> =D1=98=D0=B5=
 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Markus Armbruster <armbru@redhat.com>
>
> gitm prints the rather cryptic message "interface not found, appended
> to the last order".  This is because filetypes.txt has filetype
> interface, but neglects to mention it in order.  Fix that.
>
> Fixes: 2f28271d807edfcdc47a280c06999dd866dcae10
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20190822122350.29852-2-armbru@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  contrib/gitdm/filetypes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
> index 165b71b3f9a..2d5002fea0c 100644
> --- a/contrib/gitdm/filetypes.txt
> +++ b/contrib/gitdm/filetypes.txt
> @@ -34,7 +34,7 @@
>  #   If there is an filetype which is not in order but has values, it wil=
l
>  #   be added at the end.
>  #
> -order build,tests,code,documentation,devel-doc,blobs
> +order build,interface,tests,code,documentation,devel-doc,blobs
>
>  #
>  #
> --
> 2.20.1
>
>
