Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25BCC4727E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 19:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C364206CB
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/XU+j/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C364206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPsO5-000218-Sf
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 15:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPsMr-0001Rr-Dz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 15:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPsMn-0002nU-T3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 15:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602011476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gu7uILQ5q6vtIVjI7AlaXqDPWX2hrIPmZYov77uRlw4=;
 b=J/XU+j/86H2dQHtt7UZhaCffnZk2qtcaSwqC/Cvv3eG+7h+cS34r9JNv9CxcDouiS+33LR
 GJSPuTLh9Do39SuRmzpx60aUoF6LeuvpUikKW3uEWyYy1KGO61m7g0cHZidt2Jqs77QjcY
 lyPIW27Yq3N06quX6G8tqHwMzb4iAZs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-oGMQCo85PEKzrIbTZhm2jA-1; Tue, 06 Oct 2020 15:11:13 -0400
X-MC-Unique: oGMQCo85PEKzrIbTZhm2jA-1
Received: by mail-ej1-f69.google.com with SMTP id c20so6200820ejs.12
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 12:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gu7uILQ5q6vtIVjI7AlaXqDPWX2hrIPmZYov77uRlw4=;
 b=PF2jKISujR4zhR53FJW0o81rEkC7RaTW8vw5/3Oin1Nag+sROacWmhubcvZ4PTZvX0
 y3f/SVr9jHOaBvQZEmr1vc+hPrR1OlPxbV6x+kbpchTrraCF4eSk43nuoEUBc1249GVz
 o18ap3EfLvOgur3eg6fau83RPtyb6IA1Z0HFHK3rBEdMARJ0VaYsE8lfdLxOpegVovXG
 qDH9NuI4vRGPdQh62lx7UFEojCCeHDlHHytuV18WhmK0uyMa7psEQesrArca/s4dJvPg
 KkJ8BmE93cAAMx2Bxm2MKzwtYTB1dfZYKe1HQOlqpqmFjZkF8bely77adSgo31Qd4ZAQ
 ssMA==
X-Gm-Message-State: AOAM531KGa/Ac15jjbBzWeLJyO1raF5k5I/8sW5Fld7fqnoiK2WQHaxl
 nLBqS+aqisMFuHxJx9KZU1Ee8EvPoPko2vR0rI/UVWQtS8jFLJTC+8pK+fou7YnAlTwsXCghjFf
 y0lsqFNGMWfzrmHC35YH1WAWaLiKOta4=
X-Received: by 2002:a17:906:b043:: with SMTP id
 bj3mr991484ejb.543.1602011471961; 
 Tue, 06 Oct 2020 12:11:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbzdfngIVyXS8qFRnjbL4Q9CRAzTWNVShuauLSvolaN9twQENpMS2WM2eoGRexANvaQNstMdWXcE96vod1uvw=
X-Received: by 2002:a17:906:b043:: with SMTP id
 bj3mr991458ejb.543.1602011471641; 
 Tue, 06 Oct 2020 12:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
 <CAFEAcA97upqUtasSsg+wxLFvak5rz+t3DBD7zMu4dnwvpw73AQ@mail.gmail.com>
 <20201006144215.GK2482221@redhat.com>
 <deb55fbb-637b-0b94-6efb-c508c5dc691a@redhat.com>
In-Reply-To: <deb55fbb-637b-0b94-6efb-c508c5dc691a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 Oct 2020 21:10:59 +0200
Message-ID: <CABgObfbMLLGaw7XcjxtjyXrXSWNcUo_S6HnTsmVgC=7LHiV1kg@mail.gmail.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000b243b905b1055cf1"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b243b905b1055cf1
Content-Type: text/plain; charset="UTF-8"

Il mar 6 ott 2020, 20:47 Thomas Huth <thuth@redhat.com> ha scritto:

> I think Cirrus-CI needs a github account? Is there a way to use Gitlab now
> instead? (just like Travis recently added Gitlab support?)
>

It does only support GitHub. In theory you can set up an automatic push
from Gitlab to GitHub but it doesn't work well if you force push to the
Gitlab repository.

We should eventually set up the cirrus-run tool, so we can use gitlab, too,
> but I think you then still need at least a dummy github account to be able
> to use it, don't you?
>

Yes, that's correct.

Paolo


>   Thomas
>
>

--000000000000b243b905b1055cf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 6 ott 2020, 20:47 Thomas Huth &lt;<a href=3D"ma=
ilto:thuth@redhat.com" target=3D"_blank" rel=3D"noreferrer">thuth@redhat.co=
m</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I think Cirru=
s-CI needs a github account? Is there a way to use Gitlab now <br>
instead? (just like Travis recently added Gitlab support?)<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It does only supp=
ort GitHub. In theory you can set up an automatic push from Gitlab to GitHu=
b but it doesn&#39;t work well if you force push to the Gitlab repository.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">We should eventually set up the cirrus-ru=
n tool, so we can use gitlab, too, <br>
but I think you then still need at least a dummy github account to be able =
<br>
to use it, don&#39;t you?<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Yes, that&#39;s correct.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>

--000000000000b243b905b1055cf1--


