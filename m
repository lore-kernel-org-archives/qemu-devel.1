Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AF020838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDqIqCmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AF020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5E0N-0004kS-2N
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 16:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Dy8-0002yO-T2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 16:00:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Dy6-00062g-6B
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 16:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597089624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yxESJVWrmBQygfyZQOX9Tcd7Dy8c68STcWv6zkp5cZg=;
 b=gDqIqCmckdis42FamaJ7kvKWj2r9P6gKqUiboB8QF/2M93SNpMkD5n9NFQyZnxkWoPykIJ
 5U6dKPehkjqF3BcAkC94YyGiEl3m5lA4ZN3LKscZWTcoaciFM6LtbiH9LcpgiRspaiHDZg
 xJ+P+OUQxrttiGmwnq8W7kfdvCSD6w8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-A1zhwvLkPNeNpbiYPCexrw-1; Mon, 10 Aug 2020 16:00:21 -0400
X-MC-Unique: A1zhwvLkPNeNpbiYPCexrw-1
Received: by mail-ed1-f70.google.com with SMTP id v11so3659423edr.13
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 13:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yxESJVWrmBQygfyZQOX9Tcd7Dy8c68STcWv6zkp5cZg=;
 b=KmcKcqrL3pTlFB4aew4iFfPfhrL60Ww+bcwcgihTR6wu1zn8kV5d5ye729mMZLBbxU
 QaB0JM/NnQUUhl0p+CZdWuXI2SBiYpvLpKj2bbuI8s3UGCelPYhNUK/T2jMgumFGrJAo
 LDY2T92rhkpUfwL/BVMVkN4/X08emB3QRTfChx2wkEQyLV91guM3rgrlia/ouCOahY1A
 s+d0uqS9FYuEH7jG9qLg35Gx9oKjvU+KkWkyty8iw/f4g8NpXzs13u5dxrAEPDZNeRtx
 VhyYCA8Tn5Eb3mNX+S9ixSgAMYbK2lcz49eJ54wfeMrORiNrMtOv+Uo/e64nBubrg0fh
 ef4Q==
X-Gm-Message-State: AOAM5318IlKc7/syi6fXydT3ZHz9+lAtXWtY6QNLaSWnypzXV1nNZ/1h
 RoRpqGVOi+PHAmB/vvbed8OAh+TkBagfAuvwscMJNEd52vvTLRmGrePMdDMmYdxmEbtyweGW8tE
 3s9PvqXXo3Fgr1oVIi85QJIaIwZHP9Jg=
X-Received: by 2002:aa7:d758:: with SMTP id a24mr16145743eds.379.1597089620601; 
 Mon, 10 Aug 2020 13:00:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTjJXuu2e3Cw/1AJ6T3AKv+inheOLtJZA5YHYslkZh8CxX3uOaHSwwLdehaJ4bOagk5DYkBJqMnyLwnhknNm4=
X-Received: by 2002:aa7:d758:: with SMTP id a24mr16145715eds.379.1597089620411; 
 Mon, 10 Aug 2020 13:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA8smstwpQUD9UJzMuE6Cq2WutQzBPrKLLs=3wvfXUmpUg@mail.gmail.com>
 <b710345e-1644-782a-44a9-537493b85d95@redhat.com>
 <CAFEAcA9v7jv=SYZ0NLeSkjoM3da-apeu4OC5BMmorxMue0-viQ@mail.gmail.com>
 <6a82c3b5-037f-7cd7-68fd-0fffd8eff192@redhat.com>
 <CAFEAcA8xB=vOLvj_w9iTWWKh6kwu7fWN8QUbVAYunRdnJG0Qmg@mail.gmail.com>
 <4bbf807f-6ff0-66b5-ac13-65f2bc954d9c@redhat.com>
 <CAFEAcA-M1OXT5Kj0rt4aNHZvzCGi9gX=JDzfdKSp=bD0jOYTVg@mail.gmail.com>
In-Reply-To: <CAFEAcA-M1OXT5Kj0rt4aNHZvzCGi9gX=JDzfdKSp=bD0jOYTVg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2020 22:00:08 +0200
Message-ID: <CABgObfaFnv+G6o4uc=AxZ8uG478f0pkoC=c+pKr_sSWuAzNRKg@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000007fde0105ac8b673f"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007fde0105ac8b673f
Content-Type: text/plain; charset="UTF-8"

Il lun 10 ago 2020, 21:55 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Mon, 10 Aug 2020 at 20:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 10/08/20 21:45, Peter Maydell wrote:
> > >> Note that if you don't install it, you just get the previous behavior
> > >> (plus a warning).  But if you want that, it would be simply "gettext"
> I
> > >> guess.  You're using tests/vm/*bsd right?
> > > Yes. Unless there's a strong reason for testing the no-gettext
> > > configuration via the BSD VMs it seems like we might as well
> > > just install the dependency. Silencing the warning would be
> > > nice as well if the lack of it isn't actually problematic.
> > >
> >
> > No, I think the warning is valid.  Silencing it would be predicated on
> > --disable-gettext or something like that.  I'll just add the dependency.
>
> Our usual default convention is "if the host system has feature X,
> act as if --enable-X, otherwise act as if --disable-X", not
> "act as if --disable-X apart from warning about it".
>

Fair enough. Actually Meson has the same concept of enabled/auto/disabled
features so it would have been nice to just add a required option to
i18n.gettext. I will just open code it to avoid waiting for the next
release.

Paolo


> thanks
> -- PMM
>
>

--0000000000007fde0105ac8b673f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 10 ago 2020, 21:55 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Mon, 10 Aug 2020 at 20:49, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/08/20 21:45, Peter Maydell wrote:<br>
&gt; &gt;&gt; Note that if you don&#39;t install it, you just get the previ=
ous behavior<br>
&gt; &gt;&gt; (plus a warning).=C2=A0 But if you want that, it would be sim=
ply &quot;gettext&quot; I<br>
&gt; &gt;&gt; guess.=C2=A0 You&#39;re using tests/vm/*bsd right?<br>
&gt; &gt; Yes. Unless there&#39;s a strong reason for testing the no-gettex=
t<br>
&gt; &gt; configuration via the BSD VMs it seems like we might as well<br>
&gt; &gt; just install the dependency. Silencing the warning would be<br>
&gt; &gt; nice as well if the lack of it isn&#39;t actually problematic.<br=
>
&gt; &gt;<br>
&gt;<br>
&gt; No, I think the warning is valid.=C2=A0 Silencing it would be predicat=
ed on<br>
&gt; --disable-gettext or something like that.=C2=A0 I&#39;ll just add the =
dependency.<br>
<br>
Our usual default convention is &quot;if the host system has feature X,<br>
act as if --enable-X, otherwise act as if --disable-X&quot;, not<br>
&quot;act as if --disable-X apart from warning about it&quot;.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Fair enough. =
Actually Meson has the same concept of enabled/auto/disabled features so it=
 would have been nice to just add a required option to i18n.gettext. I will=
 just open code it to avoid waiting for the next release.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000007fde0105ac8b673f--


