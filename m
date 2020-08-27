Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE82EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143982078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGwVseR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143982078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBBC4-0008Kb-UE
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBBBC-0007sR-Pr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:14:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBBBB-0005Us-9Q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598508872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGbR62hatY0tG41UFmN0X9XuoDxItnp1gFfdFM0KLZ4=;
 b=OGwVseR2CyEjXe219ZCvyCabz3C893LXVHQLX/dJ7hZbBZHdaMVTGx//BnbPtFfYlGfnWK
 GJunVfkV8yRkJxeZFbCCAHSST5SUFDq7NeXXiWjVgydyd5pBsXJMW7i9mlsDF2mQAU/yuQ
 qS2hDg5LMBtrZIb6yW07Bw574mz1arw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-nFCSdP47MJi6wNMO31k-Ug-1; Thu, 27 Aug 2020 02:14:28 -0400
X-MC-Unique: nFCSdP47MJi6wNMO31k-Ug-1
Received: by mail-ej1-f72.google.com with SMTP id dr9so1690582ejc.19
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 23:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hGbR62hatY0tG41UFmN0X9XuoDxItnp1gFfdFM0KLZ4=;
 b=ltU9V/31coq0ySRtz3qIcEDjv7oOPcZRZ6JiwRLY9Rjey3salWttbqLsSMzxTAMo4M
 hjNXFtgckW0D7fWz7czgeuF17Z6mycGuohQjge36qx/ytvPVvtrni3jbrR6Zkbb284+6
 d6NyWnsiNYfK+e00IFi8nva+h2T6i+rFHWtey72eUMykEEjTS6ALZ9eIwp7rpaV//JId
 dWH5k74WW7yaVC/8SUXa71VTBY64ErVp22NaJl4eRNFkaVeRqy/9b8opv97I+p9EE+qp
 68KQ0sez+WXJ5R4ipoq9wA1pmrviesBSiCNOK4lzq1kmzp9RX7aEFslnf041uO7EYdmG
 9lpg==
X-Gm-Message-State: AOAM530bJR0unZhfDWtfq5lTLYR+Fo/WLt++5eeC3WR4vsW4d7zZUvj1
 eStQTeJONl3SF5vgMPk/rbCAgLf5RZs4vrKmCOjwex3gxsK+pOwPcdj8QUE8li69w2XqAPybTwE
 Cyc/xt5OkJh86/K4EuvtziDBEXHwHt6U=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr18181027edt.76.1598508866834; 
 Wed, 26 Aug 2020 23:14:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXvD4V3ZIoJFMvGpQ+1WykGh2bhW/ChUi3UxK/o7yXfuwJ1lF8lNF7hHwavabyW9n0dx35jrjgK1muQgq/sSc=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr18181012edt.76.1598508866629; 
 Wed, 26 Aug 2020 23:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200826070243.11969-1-pbonzini@redhat.com>
 <cc6af807-a24f-42bb-b1f7-8c8c5e59200b@redhat.com>
In-Reply-To: <cc6af807-a24f-42bb-b1f7-8c8c5e59200b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 08:14:15 +0200
Message-ID: <CABgObfYJ=6fRSzTz5C1A8dgbom7-QWtn1J1L7-8+4thkxNTvjA@mail.gmail.com>
Subject: Re: [PATCH] meson: move pixman detection to meson
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002a86e405add5d952"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002a86e405add5d952
Content-Type: text/plain; charset="UTF-8"

Il gio 27 ago 2020, 06:53 Thomas Huth <thuth@redhat.com> ha scritto:

> > -else
> > -  error_exit "pixman >= 0.21.8 not present." \
> > -      "Please install the pixman devel package."
> > -fi
>
> The "else" part now got completely lost, didn't it?


It's replaced by "required: have_system" in meson.build. We can add a
custom "not found" message, but if the current one is not enough we should
improve Meson so that it figures out a good one from the version
requirement.

--0000000000002a86e405add5d952
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 27 ago 2020, 06:53 Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">&gt; -else<br>
&gt; -=C2=A0 error_exit &quot;pixman &gt;=3D 0.21.8 not present.&quot; \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 &quot;Please install the pixman devel package.&q=
uot;<br>
&gt; -fi<br>
<br>
The &quot;else&quot; part now got completely lost, didn&#39;t it?</blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s repla=
ced by &quot;required: have_system&quot; in meson.build. We can add a custo=
m &quot;not found&quot; message, but if the current one is not enough we sh=
ould improve Meson so that it figures out a good one from the version requi=
rement.</div></div>

--0000000000002a86e405add5d952--


