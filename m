Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B6BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7FD22242
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4WiFq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7FD22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjtm-0004AN-Ea
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGjsP-0003IW-ED
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:18:09 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:33039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGjsN-0002Db-Qm
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:18:09 -0400
Received: by mail-ej1-x635.google.com with SMTP id j11so14084474ejk.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wmBA2vMI1I7MFwphTBeZ4GLfSzONe8aJeArUBbxMmMI=;
 b=iU4WiFq0hiD/DiBEznAn3vdHaY6xD4fZqcm+Ga8u4hZgRntZpySqbQiQY1sJcAt8Ay
 67g/Us9WGK96SgNfsf/RfQppgpSdM9Nm+RTz2UW+lpUsS1pjsk9tfEcGqQNwWS520HlX
 bhAe3z959nuHFqbe+hgSp8Ix6jfY2L2Xf/a4sIzq9cGm2N18CDPwdVZECJ1qqUV79kdA
 egtcT1LwOLrMXhUGFLkwYmOiwQmxr60dXtu0hh6sKP6oqSeAeualhQKxXlGUxPcTyZiv
 yUG5NBO7pLl0A7k32wcZVjaqiYZfvEbiMuLgnTljtN8oJcC7I5rQBqY9munK4cfWukuA
 kqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wmBA2vMI1I7MFwphTBeZ4GLfSzONe8aJeArUBbxMmMI=;
 b=EZlCTESZMcNtRYaMeJEGiLDvq6Zg4aJ/l0f83fV3kuNGpMcDXTzCAfZjSjY8DWbjgl
 cT5eCcH1TytUGY2LfukUrceQhyFadNXI4U6KSe4UiLjymKr6Qtaw53lV6MMevH+dWETS
 zXe3rVC4puGQZrTzsxnAYlrk0m0kQ3F/0SlsPJCDNMSxb41GZG+Lv46wWERJCNHRRe2u
 kttOtK15N6z8Cx3w7NL5Yq+OSVZd+vBw90fHJNiCHtipg5dJ48y44u3m1iVlPAC713BP
 0ZHi9XVWPNkhHztJMBfP+DaKNzj/fKDEjtkxQar5gizFOtVxvb5UnIEv35hPjqMtOZVD
 oU1A==
X-Gm-Message-State: AOAM530/biwtPS7XN5hP3nHDk0GBVm7kcouMOlvbh1tKd/HKslCdQtGE
 G7uVWPfQBbc6MqONEBlBKmw5dRCQIBTZMe69WQV5UEVxtsY=
X-Google-Smtp-Source: ABdhPJxW/PjJG8rYInmD1KR6Vwe0unySR8j8wVXSfHDBOTFz8sM1gSd2yHemoHsi003SVljF9+Z1D+NckZp3pMuQdRg=
X-Received: by 2002:a17:906:52c2:: with SMTP id
 w2mr2301144ejn.389.1599833885916; 
 Fri, 11 Sep 2020 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200910174850.716104-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Sep 2020 18:17:53 +0400
Message-ID: <CAJ+F1C+cEqVuTqwsYdUjGaEqm4JJX2wxV7sCnCyTyD1owUQFtg@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007845c905af0a5a5c"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007845c905af0a5a5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 10, 2020 at 9:49 PM <marcandre.lureau@redhat.com> wrote:

>
> Shameful pain point: meson & cargo don't play nicely together.
>

I realize you need to configure with --enable-debug if you try this patch,
or it will fail to find the library location. (eh, it's really a PoC!).
Obviously, tested on a Linux/Fedora with Rust/cargo etc installed from
rustup.

--=20
Marc-Andr=C3=A9 Lureau

--0000000000007845c905af0a5a5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 9:49 PM &lt=
;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<br>
Shameful pain point: meson &amp; cargo don&#39;t play nicely together.<br>
</blockquote></div><div><br></div><div>I realize you need to configure with=
 --enable-debug if you try this patch, or it will fail to find the library =
location. (eh, it&#39;s really a PoC!). Obviously, tested on a Linux/Fedora=
 with Rust/cargo etc installed from rustup.<br></div><br>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000007845c905af0a5a5c--

