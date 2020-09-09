Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F032087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkeRH6YF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F032087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG03e-0000jy-Ul
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG030-0008IX-CZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:22:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG02y-0004Ln-8A
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZ5gC2tzhmIVznbaQefEBQyD9pQOnxQiQ/r3+LKlsoI=;
 b=QkeRH6YFQVQOu/HdCtQXsBzO+Ky3kg3os8f/HwFVSM99tfb53d/39vMs9dkLYcer0h12Lh
 w/mBYVnTcMyJqSm/uXb+e2ZkmZEp2cjmesbvzc3D54+KOPKuB357akkuPvCk2BWVZj05HK
 /L/+2glu4n49JbmGaPUqdCPBKuzpFNE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-odlj5pnfP0SSq_DEtBjnqA-1; Wed, 09 Sep 2020 09:21:57 -0400
X-MC-Unique: odlj5pnfP0SSq_DEtBjnqA-1
Received: by mail-ed1-f69.google.com with SMTP id x23so1014700eds.5
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FZ5gC2tzhmIVznbaQefEBQyD9pQOnxQiQ/r3+LKlsoI=;
 b=MaduwitHfg3+0nl5U6ZKnpwHS3kl7DOMMNVEGSVxS6dDqnmUP1ZKIyb8q0R1GIFtvx
 49vpty8YJnlh5DC9SZe5szc5TeQIbXt0OQdV7kr5sinYozlTIn/w+eC35nCd6S7dnK/C
 6D7nizpYkgsYkq1Soxe1ZWUKpLDWUiSJv9lTn2OCq76f/fjocKckGj0SPCU6j1D8iDV1
 ceJFbq45Ujftrgqg4Pvio9X4uS5XqNRMUrufZWOYjA8R7D3l5R6OVLWjsPfmUcBy+hVg
 4pLzB4vHd1w8NiMq36VHm6Pz4WaYXLA2+5S9l9H+8stGvWHjFxr5wUnrKoDXJ7xIAFQw
 0Zng==
X-Gm-Message-State: AOAM5307eO64jrakO4jP5oHylb/aifWLH4o2dZOq5rAZLaHlS8Wd/LFc
 YY1+2X7GRtF+yZVmxUgo0vTjTFptig5MAh55vZHkpV02x0MZvgcrMo0MJ6zf2NWI9nhP7HbN2bL
 /3KAil8dN/AWq9Z8DAbBHdZJWfHQOO60=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr3463272ejb.121.1599657715847; 
 Wed, 09 Sep 2020 06:21:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpKYqNkcQAAg+Qo533kJD2+Jc+6R1bzyzI876ZC2UtKMHw0eZKpYfSdZycj7LZBhPPXKmpuGOoXXcsdq97iwU=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr3463253ejb.121.1599657715654; 
 Wed, 09 Sep 2020 06:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
 <20200826110419.528931-6-marcandre.lureau@redhat.com>
 <20200909095147.p6ywqn5ze7mbmvm6@lws.brq.redhat.com>
 <CAMxuvax6mfV2zX9tz7xJ5qMb5EaX6oLs6piqqAnGY6_dAyFNEQ@mail.gmail.com>
 <20200909124622.nsekxztqfrg6mijs@lws.brq.redhat.com>
 <CAMxuvay2_3nkdfb7=+0t1OKtAdJJ6Zw4KCp4+3NV3p-sssY2VA@mail.gmail.com>
In-Reply-To: <CAMxuvay2_3nkdfb7=+0t1OKtAdJJ6Zw4KCp4+3NV3p-sssY2VA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Sep 2020 15:21:43 +0200
Message-ID: <CABgObfbrzOJzGBhz=zc5+4COvdjqfLxJ7wM-t=xRQyzLnfXFew@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] meson: use meson datadir instead of qemu_datadir
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e7768605aee155ec"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, Miroslav Rezanina <mrezanin@redhat.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e7768605aee155ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 9 set 2020, 15:18 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m> ha
scritto:

> I propose to silently remove the leading '/' in --with-suffix
> argument, or warn/error about its presence.
>

Sounds good to just remove it; recent meson has a substring method so we
can do that in meson.build too.

Paolo


>

--000000000000e7768605aee155ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 9 set 2020, 15:18 Marc-Andr=C3=A9 Lureau &lt;<a=
 href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I propose to sile=
ntly remove the leading &#39;/&#39; in --with-suffix<br>
argument, or warn/error about its presence.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Sounds good to just remove it; r=
ecent meson has a substring method so we can do that in meson.build too.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
</blockquote></div></div></div>

--000000000000e7768605aee155ec--


