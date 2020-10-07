Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F3C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E75206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i91HO7AK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E75206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFTM-0002rW-Vx
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQFSR-00021o-AW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQFSN-0002Mw-PI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602100233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMWUN8eM5TT9ZAjJVgh+G19Ce2yHvmCOHBacJkq/M5g=;
 b=i91HO7AKFh80O11KaNcMuik5x0JCl2zO93X/pBLv+FVqTrNBYZiHLEeYMm4OsKPYQ9Upyx
 +IHJAW4xMz2VGLm/ILgIT5352rhOEzDy0WJFqRl7KaHGtNJ2lhXzXEMiLNoGbUOZJYrIj8
 mWP+bcbQZIXlZ2zDZZ8FjB7oEgFxr4o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-xsujyW1HP_mJPvf0X7Ccwg-1; Wed, 07 Oct 2020 15:50:29 -0400
X-MC-Unique: xsujyW1HP_mJPvf0X7Ccwg-1
Received: by mail-ed1-f70.google.com with SMTP id m10so1351778edj.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 12:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hMWUN8eM5TT9ZAjJVgh+G19Ce2yHvmCOHBacJkq/M5g=;
 b=Okk9AgJ3y0qqwrFHC4SYtDfY5c9Xq6uoo+hoxB8vXVXMdv1mONjKGlz2R8wiBmnWtI
 Bawe9MLwAIskBq4hiUR8J3WNl2OJtA4KcxkRRR3p3Levgy/PY5fAtdFWVCL7oIB5ribB
 ccdc6CUnMuNq6dLTq0yNiFHp4BIQ4Zxvc7FVnGNKwW4PqUkIVWOvIg1O/wk2tlIGIm4U
 x6XUAx8JsltzlWYDFDnpcMoIQVRNe8oG4rtKJ9mdwzn61q2iV9HqTpJWm5KBd9tKU+Ro
 aXN0th2XTxAbEthbAVTcp/a//i1dewTIThROPWIq8hVkbeHxfRKQPmaLp0dfyRx6eX2w
 wDnw==
X-Gm-Message-State: AOAM532U5VOqC0tJIlVUguxDNE/IaWU05D+niMCVwcF4TAp2fWtW/XvC
 nnZFMpGBLGnJMDqoAkwWv8pghuC3oQ6Xai6uKQgRqFcQVFk3lYcFiNqzrRusT8I6ftj9B2nD7xI
 Fh2oF5HCZ3OWvRYSz9Ak92xCRdjyepk8=
X-Received: by 2002:a05:6402:176c:: with SMTP id
 da12mr5438702edb.28.1602100227683; 
 Wed, 07 Oct 2020 12:50:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLG4y+vRqP0uFuJQaDF4FwKrbcWBF0PDAtobaYWi9nga2RmV+vMZgqMP6kanNtcuv/IgnReJbBBVGQwfTucBc=
X-Received: by 2002:a05:6402:176c:: with SMTP id
 da12mr5438685edb.28.1602100227502; 
 Wed, 07 Oct 2020 12:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201007162138.425-1-luoyonggang@gmail.com>
 <CAE2XoE9sf0p5QuG=dSqbOvmGvbzDaEBN8qSG1ejM=RH+D+zq1g@mail.gmail.com>
 <798fb17d-fcf5-3234-1e17-37b3c0a18b8e@redhat.com>
 <CAFEAcA8ivKMgGCjQSB1jmVjYDt4oMDfj+L1-coqVpEJnhEfwpQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8ivKMgGCjQSB1jmVjYDt4oMDfj+L1-coqVpEJnhEfwpQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Oct 2020 21:50:15 +0200
Message-ID: <CABgObfYP+Dik6ZnWz3W60WbMbsvmSc5k8Th9+cxpRHe2iNRTBQ@mail.gmail.com>
Subject: Re: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f48f2005b11a0677"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f48f2005b11a0677
Content-Type: text/plain; charset="UTF-8"

Il mer 7 ott 2020, 21:18 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > I have no idea how to fix it.  Probably it can be made to work using a
> > string argument and "shell=True", but at this point it makes more sense
> > to keep the shell script version.
>
> If you're keeping the shell script version could you queue
> the bugfix patch to it?
>

Yes, I did.

Thanks,

Paolo


>
> https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/
>
> thanks
> -- PMM
>
>

--000000000000f48f2005b11a0677
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 7 ott 2020, 21:18 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">&gt; I have no idea how to fix i=
t.=C2=A0 Probably it can be made to work using a<br>
&gt; string argument and &quot;shell=3DTrue&quot;, but at this point it mak=
es more sense<br>
&gt; to keep the shell script version.<br>
<br>
If you&#39;re keeping the shell script version could you queue<br>
the bugfix patch to it?<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Yes, I did.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
<a href=3D"https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lurea=
u@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patc=
hew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/</a><br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000f48f2005b11a0677--


