Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E612922B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg79DRto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E612922B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGdd-0003b0-7S
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBGcU-0002kd-1B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:03:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBGcR-00015m-Lq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598529782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKtkLesNoXADmOkrWGtd1DzClSETZwPbs392XL32ypE=;
 b=Lg79DRtoDSHsxCKAlcrzooiVFxx/eI3S4u8SO0I4nXhzWvKxmcBFJhWJGtnM2oWUrU1PtU
 6wlhtxngd/1nokrcZFyOVLhCxJf07lxxXg/o+/qFLIEvEuq3k0klGFVg8zGeJxwcoQRaov
 DNqdQ6dfgouJaVekA1aZalF+bFPq7HI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Oyk7qOFQNbyx2ZDtWjirxw-1; Thu, 27 Aug 2020 08:03:00 -0400
X-MC-Unique: Oyk7qOFQNbyx2ZDtWjirxw-1
Received: by mail-ej1-f69.google.com with SMTP id i21so2530300ejj.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cKtkLesNoXADmOkrWGtd1DzClSETZwPbs392XL32ypE=;
 b=SFxbMPmRDyiw6mGHr/WQuJDMgs3s/I2+fSqim2TXMFiN+Xb/LUgHmtaU8L3PoOvD7Z
 bAvg9EfVwbF+xeaYfnzB7ukBfsBVIXiSLMns1Tvwe8tOlQe7A7MvJL27ELH+8pX5R5w0
 S7icECAF9rL+WGQEtBTutvepibB2f8shAg9aqaXboQiA5EcIeL559hgyhqr9R9W+9h8M
 w1hJRW8LBpdpILFkSD/QT1fcimt8j36ipUSqInhZ2pMbOa7gyrjT0fT/HZw99d1tdVS4
 gPB3wAfXZfAQlwyVvFFMP38FZsN/k/nCloIFc9Y5xFbfU7EEDoHCadKK/u1Sn1NKuwTS
 /c0A==
X-Gm-Message-State: AOAM531JDUvLHkoTUi9CYjWolvKW3rEhftoio9friuDTynf4W/6po8om
 o7Hdm6ivSz42ZLDB24W/OT44J6L+3I2WHD+iSyiCC0cVyjuqYc3pgIIUb54kLQSrlf8W4BbgGX/
 OYVXquibx83SoRm3Q1bCrL0uvUO4YGrw=
X-Received: by 2002:a17:906:1cc5:: with SMTP id
 i5mr18309966ejh.449.1598529779023; 
 Thu, 27 Aug 2020 05:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDiUiE4bVTZ2VZhoAbngZmsEmX1q7QlJ/tbDjPxd+EYIrXlj5cqoOq66AHSw+UDgkPoAjyrzY8QKup3EUVzAQ=
X-Received: by 2002:a17:906:1cc5:: with SMTP id
 i5mr18309934ejh.449.1598529778764; 
 Thu, 27 Aug 2020 05:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190128.22707-1-pbonzini@redhat.com>
 <3c7ca48a-5eb0-cfd4-bac0-a2a7475eec39@vivier.eu>
 <CABgObfZhE1+N1XiHBaPx7SZHawUwNeA4yG5g1TPNQ5TMCO9xSA@mail.gmail.com>
 <CABgObfas4KFFc=0r9o_N8BYC0jHUoVx=iS0VYFU+zSCj-9yVQg@mail.gmail.com>
 <CABgObfYrFxgUSx2MYDf_uJA_cDXe_befjTm8GuiCBENzRttkOw@mail.gmail.com>
 <CAFEAcA8_ehUpuiCHkpdjdWQLHd8PG4D4ijtTo=vwk88wVip5HQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8_ehUpuiCHkpdjdWQLHd8PG4D4ijtTo=vwk88wVip5HQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 14:02:45 +0200
Message-ID: <CABgObfbOhKjdn8uK+ATW5fxvtYodacjTAS-8gB4sHFDr9AS-iA@mail.gmail.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a0684405addab721"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a0684405addab721
Content-Type: text/plain; charset="UTF-8"

Il gio 27 ago 2020, 12:08 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Thu, 27 Aug 2020 at 10:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > ... and actually it's fixed in 0.55.1. We can therefore just update the
> submodule and declare 0.55.1 the minimum required version for QEMU.
>
> Oh, I meant to ask -- if 0.56 is the one that gets rid of the
> warnings about unstable-keyval backwards compatibility issues,
> is there a reason our submodule version is 0.55 rather than 0.56 ?
>

Because 0.56 has not been released yet, it's what the master branch will be.

Paolo


> thanks
> -- PMM
>
>

--000000000000a0684405addab721
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 27 ago 2020, 12:08 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Thu, 27 Aug 2020 at 10:20, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; ... and actually it&#39;s fixed in 0.55.1. We can therefore just updat=
e the submodule and declare 0.55.1 the minimum required version for QEMU.<b=
r>
<br>
Oh, I meant to ask -- if 0.56 is the one that gets rid of the<br>
warnings about unstable-keyval backwards compatibility issues,<br>
is there a reason our submodule version is 0.55 rather than 0.56 ?<br></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Because 0=
.56 has not been released yet, it&#39;s what the master branch will be.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000a0684405addab721--


