Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCDC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE2720720
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFUrlsr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE2720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48415 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyl8J-0003fI-Pc
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 18:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyl7E-0002lM-9T
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyl7B-0002Qe-Rj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:26:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyl7B-0002JV-Eb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580772408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gm6thpIrCVyxrXhJkvntUAy9mzyZRWWNdXniLVkfLC8=;
 b=aFUrlsr7MgfzFwjeZMFZKVQPJKExXdPlPynFVOz7/Ti60Dhr/+msyb49+NK8kO5YPSl7WK
 w+XdwRylIjJhGygvohBeM0FPEuVCZxJViqhHk21/5wDw9Od9rA/P8VjDfLtra6ejOpnClE
 sAZEUaCuxOyi9F9FRSXyuWE+kG+8SRc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-sSfqqhAMNdqqOax_VDRjrw-1; Mon, 03 Feb 2020 18:26:46 -0500
Received: by mail-ed1-f71.google.com with SMTP id v11so11387394edw.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 15:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FaHx1V2NXPA2xyUhlNNb54uZgbxZyncHLHb0l6F8rJo=;
 b=TxKWvfu8is1QZciO4CIDf1TFyZ49xtS6PFTIoqmfuztc2YIJ/U84nQ8SMIA9TqCdL/
 IeLthO454AWMmg46K+rpy0ysWly0klmAYNe5oFdbXLKsCMpu31Hqby3PmE4vb4NpjQfV
 ogvAYBrUwQ3WYClurQxUaPIKaEUL3rmegAkMnaEQ2pwffgB0KtfQerwx0n8VQmtvERDq
 VE9f9BvJZ+pe6nZmcTnC38xSnCCkE5xXVTWUAr8B0p1d9KV7qYWu+1l4deheNNMh5X32
 WfQpqLcQDMGkoj5ge/5pcuawi471U6epe3qcsxvg7eRtH4ulDwXaJV8yUoFSGMYp+zOV
 RvAg==
X-Gm-Message-State: APjAAAW9UhWLc0BKqahtGzTMuk2zhvwKzIKr28X4Ra5Nlemrt0AFDV4p
 gXJR8JFEItoN5yp8N0ar49Nqt262qyavUiTQZ1RCPkYFSl+BIPb0Z1AgDNGqQD1oIR6sXS/yp5l
 N+0mLSJRFJvs43oot2xuht3gDVDurODo=
X-Received: by 2002:a17:907:104e:: with SMTP id
 oy14mr23100244ejb.82.1580772405134; 
 Mon, 03 Feb 2020 15:26:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzY+7O6hQQaiizXtXHez3drltNZE3gHJfNBrnvSjbtcNgvh753zXzSo7GACETSQKO2nZ/epjYV2et0yYsJhS8Q=
X-Received: by 2002:a17:907:104e:: with SMTP id
 oy14mr23100231ejb.82.1580772404908; 
 Mon, 03 Feb 2020 15:26:44 -0800 (PST)
MIME-Version: 1.0
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
In-Reply-To: <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Feb 2020 00:26:32 +0100
Message-ID: <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>
X-MC-Unique: sSfqqhAMNdqqOax_VDRjrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000aa719d059db44194"
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aa719d059db44194
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru> ha scritto:

>
>
> Speaking seriously, what would I put into the guest?
>

Only things that would be considered drivers. Ignore the partitions issue
for now so that you can just pass the device tree services to QEMU with
hypercalls.

Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLOF,
> smaller but adhoc with only a couple of people knowing it.
>

You can generalize and reuse the s390 code. All you have to write is the
PCI scan and virtio-pci setup.

Paolo

--000000000000aa719d059db44194
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy &lt;<a h=
ref=3D"mailto:aik@ozlabs.ru">aik@ozlabs.ru</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><br>
<br>Speaking seriously, what would I put into the guest?<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Only things that wo=
uld be considered drivers. Ignore the partitions issue for now so that you =
can just pass the device tree services to QEMU with hypercalls.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Netboot&#39;s dhcp/tftp/ip/ipv6 client? It is going =
to be another SLOF,<br>
smaller but adhoc with only a couple of people knowing it.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You can generaliz=
e and reuse the s390 code. All you have to write is the PCI scan and virtio=
-pci setup.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><=
/div>

--000000000000aa719d059db44194--


