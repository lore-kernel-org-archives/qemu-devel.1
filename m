Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A1C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8292076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKnGJm21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8292076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTAqE-0007Fi-Fw
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTAjO-000141-7k
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTAjK-0001hL-PZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602797049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/719wzqoKShD5Z5RTCEKhQqs0pvV10c2RcF2bB5bzys=;
 b=MKnGJm21L5DYSsuKojIXyyv5JcfEQ2PuohhHqYAnznXKIBA9Fzh8ZkYxV8O9gDhlQobvut
 hw4D27DBr2iVl+nVES8Z35XFpYdxi0Qv5Z//gpo0UNUbZxfve2W3McUaooCJOMpWKCOWlx
 KULzxdhRkXBPSimLplbxtduDG9trWHc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-4WzRiiV2O9OfWDABMH8uZg-1; Thu, 15 Oct 2020 17:23:38 -0400
X-MC-Unique: 4WzRiiV2O9OfWDABMH8uZg-1
Received: by mail-ej1-f71.google.com with SMTP id d12so59246ejr.19
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/719wzqoKShD5Z5RTCEKhQqs0pvV10c2RcF2bB5bzys=;
 b=Qn58SM14mVHB8Oy9VXhRlbvwptjT1F2pyUo/y+Z6jmTqDWU0baED9Zm3X646KXy0LI
 gZchaVvL4pIa5tuMB7Gm2BdVEOcWrP5JuTH/YYVFtXvuEsr+13+OxBDmzHgvJbBqG4p2
 NenMHo5Vsw4rWwhut8TNwrEUoRzODuh9CfPh7ngU1Uti//CXroWSQCrYIK5dKEGFL9aQ
 wwnpCCXKQyj/CP8B/yL6gaC9LllonMNEGzq4IyfySI39knLW9VkAFLimG4Qcj0EUbKOL
 gsEiT/0ykIN9BV3424IdGV6kTbm5JTFp3GnmezAH6iHNMFO6ONC9yJfxbEucHy4X1taU
 hwJQ==
X-Gm-Message-State: AOAM533sA5RSt0LT9PFaitudqQFYw47SRwIGGdl0FarbrRswNoSHq7xK
 xzS9A6izy5qBQ3hsqvKTbg1+3Ho90QmU8xmDKb0LkL5Dvy4o+u0/X3ga+/OIsr+qV8PkQbb56xI
 Ts3gTMlTAFSEKHyGnX1t/V4pR2pDRrSo=
X-Received: by 2002:aa7:d143:: with SMTP id r3mr437999edo.103.1602797017412;
 Thu, 15 Oct 2020 14:23:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3MA6zk6PJNL9y5X+8AaB3MZbKTRhyOkZkkzo4WhV/xq8HzKDPEPrA53p0mrQCTuplIoi3ks/q1Z+yy3BUH+k=
X-Received: by 2002:aa7:d143:: with SMTP id r3mr437986edo.103.1602797017214;
 Thu, 15 Oct 2020 14:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <20201015201035.1964-3-luoyonggang@gmail.com>
In-Reply-To: <20201015201035.1964-3-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Oct 2020 23:23:25 +0200
Message-ID: <CABgObfYXes_WRnqkBs2-1cTQVRu5PMO1Wv9vguWxY_41aFzTfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] configure: the docdir option should passed to
 meson as is.
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000dbc57c05b1bc4257"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dbc57c05b1bc4257
Content-Type: text/plain; charset="UTF-8"

Why?

Paolo

Il gio 15 ott 2020, 22:11 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index f839c2a557..1ce31f97b4 100755
> --- a/configure
> +++ b/configure
> @@ -971,7 +971,7 @@ for opt do
>    ;;
>    --with-suffix=*) qemu_suffix="$optarg"
>    ;;
> -  --docdir=*) qemu_docdir="$optarg"
> +  --docdir=*) docdir="$optarg"
>    ;;
>    --sysconfdir=*) sysconfdir="$optarg"
>    ;;
> @@ -5770,7 +5770,6 @@ fi
>  qemu_confdir="$sysconfdir/$qemu_suffix"
>  qemu_moddir="$libdir/$qemu_suffix"
>  qemu_datadir="$datadir/$qemu_suffix"
> -qemu_docdir="$docdir/$qemu_suffix"
>  qemu_localedir="$datadir/locale"
>  qemu_icondir="$datadir/icons"
>  qemu_desktopdir="$datadir/applications"
> --
> 2.28.0.windows.1
>
>

--000000000000dbc57c05b1bc4257
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Why?</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Il gio 15 ott 2020, 22:11 Yonggang Luo &lt;<a href=3D"m=
ailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Signed-off-by: Yonggang Luo &lt;<a href=
=3D"mailto:luoyonggang@gmail.com" target=3D"_blank" rel=3D"noreferrer">luoy=
onggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0configure | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/configure b/configure<br>
index f839c2a557..1ce31f97b4 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -971,7 +971,7 @@ for opt do<br>
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0--with-suffix=3D*) qemu_suffix=3D&quot;$optarg&quot;<br>
=C2=A0 =C2=A0;;<br>
-=C2=A0 --docdir=3D*) qemu_docdir=3D&quot;$optarg&quot;<br>
+=C2=A0 --docdir=3D*) docdir=3D&quot;$optarg&quot;<br>
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0--sysconfdir=3D*) sysconfdir=3D&quot;$optarg&quot;<br>
=C2=A0 =C2=A0;;<br>
@@ -5770,7 +5770,6 @@ fi<br>
=C2=A0qemu_confdir=3D&quot;$sysconfdir/$qemu_suffix&quot;<br>
=C2=A0qemu_moddir=3D&quot;$libdir/$qemu_suffix&quot;<br>
=C2=A0qemu_datadir=3D&quot;$datadir/$qemu_suffix&quot;<br>
-qemu_docdir=3D&quot;$docdir/$qemu_suffix&quot;<br>
=C2=A0qemu_localedir=3D&quot;$datadir/locale&quot;<br>
=C2=A0qemu_icondir=3D&quot;$datadir/icons&quot;<br>
=C2=A0qemu_desktopdir=3D&quot;$datadir/applications&quot;<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>

--000000000000dbc57c05b1bc4257--


