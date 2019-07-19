Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B764C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C312184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot98mWv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C312184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPyi-0002Ku-Ry
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hoPyV-0001vD-Jv
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hoPyU-00060n-F5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:18:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hoPyU-00060E-8n
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:18:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id g17so31720681wrr.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BwSiYvLfQJwpLMZzOwfesRK7Rfnj2MXMjHbhjfCONh4=;
 b=ot98mWv9K8ihEJRWwA+G2wPopS1YbKGxH4QlDRhCx03Gp/6032HrlazINKk6SQztAV
 hhGqmRTBaYP8bxwc2IW+MkOgBC0s7ZLm3W67q8dtQ3nTs+Fwt2T8eyQMOVObZFaD6dR+
 We0uShJv85hImb8yvF7GL5sBwchEvysBhLi87+U0mnH4F0c9ilMSiueO/pQpkIzP0Y8t
 jsbIxossXXXy/xuHT2OoHAvybo/8F/0n9yI+OpXpqewzWuLZZ9H8BvKA7OU9S1/tw+F0
 JgJp2amRzTlmzzBNziuJ4lKTkpET/AZ9X3blbyOLEXy57iUZKFz+t0jP1BekOZhGuoG2
 GuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BwSiYvLfQJwpLMZzOwfesRK7Rfnj2MXMjHbhjfCONh4=;
 b=le3dowUtKBvBtr4CCmFpbwmQ9u2KxkeUjdneegWEZVG0+abCwt1cu2lGr5K5MMkgHq
 gsxohlpVGbfvVkdsZWGD78vT8g9A+BzovhT6UwlviG5+/MSK+nn9tWpJt7gUE+7Il6Ty
 JAsKsGkaT7dAxk23zCC+jz1QWgZ+NloLWKvwYSGKiqUQXISD9p3FMWTnJwndP53mqfgf
 cAjxKwVG0OXd87cFxXMlOMVr/6L2Dbu0J7tMPg3ieDQalWYgYtrsRoZKE2szMF9jWx/1
 EN+OAv3iIK5SDDasmaWLGUq4KxoR/SKL7vAYGJwLKQNKe8ME4bpPItGTD6YwtAV9NtGX
 PoDA==
X-Gm-Message-State: APjAAAXOo4bXMuzvvivb8FQ5pQxeR6/P8IhjA78+cNcR6n3wVJ4tngBM
 JQcJrptPvhs/7VErbjf8sitfPzNp80TQBP5rJuDJGX0erQxPpA==
X-Google-Smtp-Source: APXvYqwuK4f3Patm3jH8bpfq+0iDmVHwari18OxORXb1SphgDVaVjYlnMJdLNRvOhCt7apkxdcIgWf3u97XcR0GvkAQ=
X-Received: by 2002:adf:eac4:: with SMTP id o4mr54129942wrn.290.1563531529118; 
 Fri, 19 Jul 2019 03:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190719100955.17180-1-peter.maydell@linaro.org>
In-Reply-To: <20190719100955.17180-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 19 Jul 2019 14:18:36 +0400
Message-ID: <CAJ+F1CJU5iUDa_W2Vj0WMBEht3eVJ9xsUWt4nCE4-eC14ei4hA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH for-4.1] contrib/elf2dmp: Build download.o
 with CURL_CFLAGS
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
Cc: QEMU <qemu-devel@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jul 19, 2019 at 2:10 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> contrib/elf2dmp has a source file which uses curl/curl.h;
> although we link the final executable with CURL_LIBS, we
> forgot to build this source file with CURL_CFLAGS, so if
> the curl header is in a place that's not already on the
> system include path then it will fail to build.
>
> Add a line specifying the cflags needed for download.o;
> while we are here, bring the specification of the libs
> into line with this, since using a per-object variable
> setting is preferred over adding them to the final
> executable link line.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> I'm pretty sure this is what's causing the compile
> failure described at:
> https://stackoverflow.com/questions/57102476/qemu-recipe-for-target-contr=
ib-elf2dmp-download-o-failed
> I haven't actually got a setup that reproduces the error,
> though, so this is tested by looking at the command lines
> run on an Ubuntu setup that compiles even without the fix.
>
> There's an argument for splitting this into two patches,
> I suppose, one which just fixes the CURL_CFLAGS bug and
> one which tidies the CURL_LIBS handling. But it didn't
> seem worth it to me. Let me know if you'd prefer it split.
> ---
>  Makefile                      | 1 -
>  contrib/elf2dmp/Makefile.objs | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f9791dcb827..27dabb9b1a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,7 +626,6 @@ ifneq ($(EXESUF),)
>  qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
>  endif
>
> -elf2dmp$(EXESUF): LIBS +=3D $(CURL_LIBS)
>  elf2dmp$(EXESUF): $(elf2dmp-obj-y)
>         $(call LINK, $^)
>
> diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.obj=
s
> index e3140f58cf7..15057169160 100644
> --- a/contrib/elf2dmp/Makefile.objs
> +++ b/contrib/elf2dmp/Makefile.objs
> @@ -1 +1,4 @@
>  elf2dmp-obj-y =3D main.o addrspace.o download.o pdb.o qemu_elf.o
> +
> +download.o-cflags :=3D $(CURL_CFLAGS)
> +download.o-libs   :=3D $(CURL_LIBS)
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

