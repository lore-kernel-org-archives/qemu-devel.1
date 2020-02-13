Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09DC3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC05246A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUjPngqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC05246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GJv-0006Yh-DD
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j2Fok-00061M-LZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j2Foh-0005gt-84
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:50:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j2Foh-0005dS-2t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581605409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k76DfKGktXC3gCKxb0MlmatUxUtATJH1V5XwEodiORI=;
 b=hUjPngqpXtP0t1ykrQiYKgjF1z7F5rnM7jls501DVF+DgYd3Yql+GMYsNISmU0PvxPm4np
 iqJb03yOAPQCwfBggQxb7y7U+ZEv2Bb+e6KRYBPqPKSQjH/AFyAu0trQ0R6e0WkhCWC8wu
 ONP1vcdp7Oqnv+pKx8Te/Ypn7Zmoli0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-oU-dOP61PXK0KnZI6o9DXQ-1; Thu, 13 Feb 2020 09:50:07 -0500
Received: by mail-qv1-f72.google.com with SMTP id p3so3645392qvt.9
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eovNYun51mc439+hX2zwVKiuy2KZyB2kwXBRWB23szI=;
 b=dTyVMaQspt8dt9hMvo917+JstUK7T+Xglw4HJpvJfn21S3R+uVkgTTiTnu/r/oePVf
 zOQ2uTLzzq2PACTugcNXeSc5gMSAiAMtlk68RGHBpRXpssi4yXulLHHw0I8fHWCTA5Nc
 eJTbT2g5pVKfzpP3/TQBcKYE1A2d3vIkLsKRZf5tsrXRWNP9THDYdpWJrrZIczVLRo0e
 0p1I8OOA53C5ysxBtAPlvQFvIjL+3SbeW1Vk9bJ7TYIxkeUrNuTT4lX14R2rW2mC0Bwv
 MjRCGxouX/Z97o8DjNGg6qfy35mLFQ3ZKyHuHGBbf807eMIbtgWnYHcKTXIQGdBi4Urp
 JX9g==
X-Gm-Message-State: APjAAAUOKfLcOX+a3n28fEuJuJ0baPRfbU3g82alsqfEwL3IjW46gMxN
 SQGdOQWgreaIC6i1EcjA8tptSJY0ca9ac9z6wpCc1R7uZaCsYbYCbhbil2PFK6qgdHLPZE6edqH
 miPttTKTl1NdSiNc=
X-Received: by 2002:ac8:5502:: with SMTP id j2mr12366823qtq.127.1581605406552; 
 Thu, 13 Feb 2020 06:50:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5WKYG2+h//TLgvRBup1A9MTHLSuATjesCJf2FrpLOLV/OY+QO8VbJEw+GjAO/eXrrwYDn5w==
X-Received: by 2002:ac8:5502:: with SMTP id j2mr12366797qtq.127.1581605406253; 
 Thu, 13 Feb 2020 06:50:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 o189sm1424567qkd.124.2020.02.13.06.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:50:05 -0800 (PST)
Date: Thu, 13 Feb 2020 09:50:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "V." <mail@winaoe.org>
Subject: Re: [PATCH/RFC 0/1] Vhost User Cross Cable: Intro
Message-ID: <20200213094723-mutt-send-email-mst@kernel.org>
References: <98d1e1f0-0e53-d207-78ce-ea9717673985@winaoe.org>
MIME-Version: 1.0
In-Reply-To: <98d1e1f0-0e53-d207-78ce-ea9717673985@winaoe.org>
X-MC-Unique: oU-dOP61PXK0KnZI6o9DXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 02:54:30AM +0100, V. wrote:
> Hi List,
>=20
> For my VM setup I tend to use a lot of VM to VM single network links to d=
o routing, switching and bridging in VM's instead of the host.
> Also stemming from a silly fetish to sometimes use some OpenBSD VMs as fi=
rewall, but that is besides the point here.
> I am using the standard, tested and true method of using a whole bunch=A0=
 of bridges, having 2 vhost taps each.
> This works and it's fast, but it is a nightmare to manage with all the in=
terfaces on the host.
>=20
> So, I looked a bit into how I can improve this, basically coming down to =
"How to connect 2 VM's together in a really fast and easy way".
> This however, is not as straightforward as I thought, without going the w=
hole route of OVS/Snabb/any other big feature bloated
> software switch.
> Cause really, all I want is to connect 2 VM's in a fast and easy way. Sho=
uldn't be that hard right?
>=20
> Anyways, I end up finding tests/vhost-user-bridge.c, which is very nicely=
 doing half of what I wanted.

BTW you can easily run two vhost user bridges and connect them back to
back, right?

> After some doubling of the vhosts and eliminating udp, I came up with a V=
host User Cross Cable. (patch in next post).

Hmm you forgot --thread=3Dshallow so your posts aren't linked.



> It just opens 2 vhost sockets instead of 1 and does the forwarding betwee=
n them.
> A terrible hack and slash of vhost-user-bridge.c, probably now with bugs =
causing the dead of many puppies and the end of humanity,
> but it works!

I think generally this approach has value, maybe a separate utility,
maybe as a flag for vhost-user-bridge.

--=20
MST


