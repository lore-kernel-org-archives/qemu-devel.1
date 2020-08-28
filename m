Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F266C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40B620665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ikc9FMC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40B620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfqp-0007fT-9k
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBfRW-00012p-Pg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:33:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBfRT-000797-8g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598625201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ODfWBBwiL9iZ2ROaNFchqpkU/kJX0vnKvOEoJJUbsQ=;
 b=Ikc9FMC4lyicVcuStCSeSl9AER33wImzkIS6te2fIPIDD6qK0aH2ssAsGH1mfruNjJhwfO
 DXAaTX32ibM8x5awE7Y3hYkohxHbmCqsHKf65pUJqOySIH02Xpi230UWJAVmA5TrMP6jdB
 WmUT2eLdRpQilIi7hPIUa7XEBgANhNg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-nQ7TtRMuMvWCfJelVL0vWg-1; Fri, 28 Aug 2020 10:33:18 -0400
X-MC-Unique: nQ7TtRMuMvWCfJelVL0vWg-1
Received: by mail-ed1-f72.google.com with SMTP id c3so415165edm.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ODfWBBwiL9iZ2ROaNFchqpkU/kJX0vnKvOEoJJUbsQ=;
 b=LTHLIYVnDLDKIYcdIjmcHB9UTKDJOjKMLVtA4dXbPzIi4c7XgZ5wops997ntubqALp
 fHU/nc0HpusETKA/wSei3SjDeTP982LAysHirCFT2RySzTKGMq90VE2Cig/5lyiHFcFg
 kqGDTASVu7/j9nEH+Mmvlr96Ednt+X2X0JffeJ82rImXpgxMXkUB6AfBB2UBnYFvLlNx
 ZBSJLStRbxQ5jhaupGhYN3p75xpCRABRKl1K10ZFXnXeryC+mTmN17LdcO1K2s7PMtZP
 QFNHNOkAS611eLHxlESQ5K93T97jfzAPiuAeeTUS61sJCvGzN8igmEH1dpAX5bbzzzS9
 Wu+w==
X-Gm-Message-State: AOAM532ALX2YWjOkvT5ivTd4ScbVvI1dmdepmhygMJzxGAtVjqyJZc+0
 ThHSkbLxlP5SrGaB8HIgkyjitQpKhVlXHoPTqmTRFvyovqdv1QEkPhK8dOHyzaF/6di/1yxHD8I
 F5l+osqHesI03qnnhHmWka9pgYNdzbOo=
X-Received: by 2002:a17:906:1cc5:: with SMTP id
 i5mr2205710ejh.449.1598625196803; 
 Fri, 28 Aug 2020 07:33:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+cahgQGgKZuuYnYurYx0236wgyJQhrUuTWnjB2rxy5ofy+agSEKUiLz3fv9bVT20MiKIF1dWrvEBfpSe+IYc=
X-Received: by 2002:a17:906:1cc5:: with SMTP id
 i5mr2205690ejh.449.1598625196622; 
 Fri, 28 Aug 2020 07:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200828080845.28287-1-kraxel@redhat.com>
 <CAFEAcA8rSCDnSvymWigeU4VPjyrEB-WMws57q0-Q3cNijQjEBw@mail.gmail.com>
In-Reply-To: <CAFEAcA8rSCDnSvymWigeU4VPjyrEB-WMws57q0-Q3cNijQjEBw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Aug 2020 16:33:04 +0200
Message-ID: <CABgObfbufQJza=XykCSp2V5xdTwzycx-GsWTD6jKEV3PnomRXQ@mail.gmail.com>
Subject: Re: [PULL 00/18] Usb 20200828 patches
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f95c2305adf0ee00"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f95c2305adf0ee00
Content-Type: text/plain; charset="UTF-8"

Il ven 28 ago 2020, 16:14 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> Why is Meson trying to use CMake here? I don't think we want
> to bring in another build tool dependency...
>

It's asking cmake if it knows about the package, if pkg-config fails. This
is because cmake has its own incompatible mechanism to tell users about
compilation and linking flags, and the "dependency" line doesn't tell Meson
if u2f-emu has a pkg-config or a cmake description.

We can ask to use pkg-config only since none of our dependencies are
cmake-only; see https://mesonbuild.com/Dependencies.html#dependency-method.

Paolo


> thanks
> -- PMM
>
>

--000000000000f95c2305adf0ee00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 28 ago 2020, 16:14 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Why is Meson trying to use CMak=
e here? I don&#39;t think we want<br>
to bring in another build tool dependency...<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s asking cmake if it kno=
ws about the package, if pkg-config fails. This is because cmake has its ow=
n incompatible mechanism to tell users about compilation and linking flags,=
 and the &quot;dependency&quot; line doesn&#39;t tell Meson if u2f-emu has =
a pkg-config or a cmake description.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">We can ask to use pkg-config only since none of our dependenci=
es are cmake-only; see <a href=3D"https://mesonbuild.com/Dependencies.html#=
dependency-method">https://mesonbuild.com/Dependencies.html#dependency-meth=
od</a>.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000f95c2305adf0ee00--


