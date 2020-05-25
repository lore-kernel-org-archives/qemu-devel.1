Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D53AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 06:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A2C2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 06:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLmm6NVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A2C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd6og-0002j2-CZ
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 02:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jd6nC-00024f-R0
 for qemu-devel@nongnu.org; Mon, 25 May 2020 02:40:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24120
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jd6nB-0002dX-VV
 for qemu-devel@nongnu.org; Mon, 25 May 2020 02:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590388856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fh7qy5x7FFYDUUtKa75F1LNppiTgEK3QC0GcpCttKkg=;
 b=HLmm6NVr6eiLAffSCaKKQaHdvCgrRN2+K+aw7l80Srvs8RTjZIKsdCaRm7wKgDFwz3bGDf
 TXtqiNR1P4LutHR12Oa1RXmzqPIuxwlLHlEORsIf8NXo1rwHStu+zHCLNrg7Rsq6+/sY8P
 1WZScg7asjRhZHPUfbv6vmG8KoatKJQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-aQBNJ4FdNkqdB2ayd95xOw-1; Mon, 25 May 2020 02:40:54 -0400
X-MC-Unique: aQBNJ4FdNkqdB2ayd95xOw-1
Received: by mail-ed1-f71.google.com with SMTP id k17so7058223edo.20
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 23:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fh7qy5x7FFYDUUtKa75F1LNppiTgEK3QC0GcpCttKkg=;
 b=oYozc7kzaUK2iDUGziU6yyh49GiFxV55pF8FrEg4sFSyJJ7/c3cu12PChN9PXmGFj7
 4FU7wyHI19YUVE/aSWtQk+nEWdJf2gEQEbjdTp4C28XlbrBEihX/q53VUOwwSnY3nGbg
 eIpTz4Wjgb8nW89ZeP+q5OkOsrQvOBcxast0CLl4vRPFdbSfG/MFVm8P9CtkcBf9pMSU
 C/dwZynSiuYnnumpoT3/bbMXrX72fbvoYiM121q5as6PXgYVJaUSimqkc/naA8diST7U
 b/ioOl5KeaIHUJozsi8PfMwGltE1E31qrwCWPQAJ+A2Bklkc9OOd0rgKUgOa8xfwbpkH
 GFgA==
X-Gm-Message-State: AOAM53387LS1nznWF51nZ0KbKbTNGTZ5MdSGa22XoQFCJBNrCn43M8Vd
 1/JFW2d9yA7vGyZy++NXw1Ho9Lf6Svuby9GVukcIrAWdgkkVekNWMoi578A+FXy6T93YUd8OQfl
 IzJm/9M5uKbEDeM4EqDbbCHjxzUpPrKI=
X-Received: by 2002:a17:906:8d0:: with SMTP id
 o16mr18202326eje.196.1590388852727; 
 Sun, 24 May 2020 23:40:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU27CikJ1mhYODdNeDvWt7d14Fpmm3VZRaRhyyhpgLJ1sNvcAcpF6u85e8wwtKx385kcLPM9GkZ2akFiDNkAY=
X-Received: by 2002:a17:906:8d0:: with SMTP id
 o16mr18202314eje.196.1590388852543; 
 Sun, 24 May 2020 23:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
 <871rnft498.fsf@dusky.pond.sub.org>
 <c3c59472-9f2a-f30a-deed-36192840a892@redhat.com>
 <871rner7ki.fsf@dusky.pond.sub.org>
 <75f22571-138a-337b-a1c3-e715b1622bae@redhat.com>
 <87wo50frwe.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo50frwe.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 May 2020 08:40:39 +0200
Message-ID: <CABgObfYEoZ0=k4uvMq3VGub=nx1UQUTE93G8Rn5rKYLbwxk97Q@mail.gmail.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009c65e805a67342fd"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>, "Habkost,
 Eduardo" <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009c65e805a67342fd
Content-Type: text/plain; charset="UTF-8"

Il lun 25 mag 2020, 08:30 Markus Armbruster <armbru@redhat.com> ha scritto:

> > I think we should move the whole /machine/unattached dance into
> > qdev_realize, and just assert that a device being realized already has a
> > parent.  Then the ref/unref _will_ be unnecessary.  In the meanwhile, I
> > agree to either keep it or move it inside device_set_realized.
>
> Could be done on top.  I might try for v2, if I can find the time.
>

Certainly on top.

Paolo

--0000000000009c65e805a67342fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 25 mag 2020, 08:30 Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">&gt; I think we should move the whole /ma=
chine/unattached dance into<br>
&gt; qdev_realize, and just assert that a device being realized already has=
 a<br>
&gt; parent.=C2=A0 Then the ref/unref _will_ be unnecessary.=C2=A0 In the m=
eanwhile, I<br>
&gt; agree to either keep it or move it inside device_set_realized.<br>
<br>
Could be done on top.=C2=A0 I might try for v2, if I can find the time.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Cert=
ainly on top.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
></div>

--0000000000009c65e805a67342fd--


