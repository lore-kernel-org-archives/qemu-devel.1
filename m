Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10906C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FDA20663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfGoQK8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FDA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isAEy-0002d1-Ri
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isADx-0000cB-9Y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isADr-0006uZ-EB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:50:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isADq-0006td-V7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579200625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qj+AKpUtTUItJBPZlV7sxNW9CsDn28xiqMbqFuYdRSo=;
 b=EfGoQK8CiEasNbAlYaTPKcDME87T92J7TPzlEyFMzI5UA8TPlJinH86G0juBOFKcCOC9P4
 qMarvx1+H29jgd7QG92TSAroF0kI1l80fqypjvWcfol9oxYfanG2cRoZPtr7In/Oti17Ht
 PoQI2NZAZs/iM+XPN/u8NxD6r9ua1WM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-iQMs_AdZP5ONA6dV9eHehQ-1; Thu, 16 Jan 2020 13:50:24 -0500
Received: by mail-ed1-f72.google.com with SMTP id g20so14542100edt.18
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+wOR8EwvOi5JLJrApZDs2qJ7M77rJTZzLUyyTWSQAnI=;
 b=Vij43URqz6Tk7oPGDYaUeQuXIIsC9ulj37M9njaResRD9UBrZJQaNSXxO70LrBwcFY
 vtDLp63tNottzlZRcRSp77EQ7KfzTH/miASoLBFQJ1VVTtxQFNp4RSlJrlLX7ZzrXGqC
 n7RzT2PBQxH8Jz+MMzrfGmfrwaVyMqmeR0pbQfHu52W7TIodmO+SSs/FHLlFP6DfPZeT
 rJMTMySzjWXZ55JghriHKsfksWpt0eiz4mD473amJFcZPLs/c3TkjVnEvK5LMX97pH2M
 mfUNYJFR6fls06XBzkBW0mtXNOiG7yxYkXP9e2kPrOBdMjreCt3nOo+TtX7u8Rr7qFsk
 bMXg==
X-Gm-Message-State: APjAAAXpmmOepzLohJEmcULzty6uOdKVzOnxJotuGkMwzEXt6Ga1VEi6
 K+/HGKyNXJ09UUIt/DBBFJ2+IyoSv/80qCPe3ChC+tUTQVSHEV22ZU68clEPmeI5C0Zm8/0CfsU
 AEUGD4iVIZGEmqX5kSW7Jf8maOC7zkB4=
X-Received: by 2002:a17:906:5358:: with SMTP id
 j24mr4433710ejo.44.1579200623402; 
 Thu, 16 Jan 2020 10:50:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMAdqM8ajSnhf94VOxLAmP4F4UsXQ6t7W+0q1hPg1ltHLdPBupL/44jFKwOUQq8a4U295IaqvCb++uEDuGGYs=
X-Received: by 2002:a17:906:5358:: with SMTP id
 j24mr4433691ejo.44.1579200623157; 
 Thu, 16 Jan 2020 10:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200116193321.37830fd7.olaf@aepfle.de>
In-Reply-To: <20200116193321.37830fd7.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Jan 2020 19:50:10 +0100
Message-ID: <CABgObfai6T7yua=mFcXLzve_Y1hQLptx51rySw4zVQCN4DC4_A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>
X-MC-Unique: iQMs_AdZP5ONA6dV9eHehQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002c4b79059c464c3e"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002c4b79059c464c3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 16 gen 2020, 19:33 Olaf Hering <olaf@aepfle.de> ha scritto:

> Am Thu, 16 Jan 2020 19:26:39 +0100
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>
> > xenfv does not support cross-version migration compatibility.
>
> Wait, what does that mean?
> So far live migration of a running domU must be possible from Xen N to Xe=
n
> N+1.
>

The  Xen N+1 must know that the source is running Xen N, and use a machine
type corresponding to the QEMU version that was shipped with Xen N. For new
virtual machines Xen must also use pc-i440fx-M.N and not just PC.

This is not new, versioned machine types were introduced in QEMU 0.10 or
something like that for exactly this purpose.

Paolo

It would be more than unexpected if the target host running "Xen N+1" must
> have the very same qemu version as "Xen N".
>
> Olaf
>

--0000000000002c4b79059c464c3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 16 gen 2020, 19:33 Olaf Hering &lt;<a href=3D"m=
ailto:olaf@aepfle.de">olaf@aepfle.de</a>&gt; ha scritto:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Am Thu, 16 Jan 2020 19:26:39 +0100<br>
schrieb Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;:<br>
<br>
&gt; xenfv does not support cross-version migration compatibility.<br>
<br>
Wait, what does that mean?<br>
So far live migration of a running domU must be possible from Xen N to Xen =
N+1.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">The=C2=A0 Xen N+1 must know that the source is running Xen N, and use a=
 machine type corresponding to the QEMU version that was shipped with Xen N=
. For new virtual machines Xen must also use pc-i440fx-M.N and not just PC.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">This is not new, versio=
ned machine types were introduced in QEMU 0.10 or something like that for e=
xactly this purpose.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pao=
lo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
It would be more than unexpected if the target host running &quot;Xen N+1&q=
uot; must have the very same qemu version as &quot;Xen N&quot;.<br>
<br>
Olaf<br>
</blockquote></div></div></div>

--0000000000002c4b79059c464c3e--


