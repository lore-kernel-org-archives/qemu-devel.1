Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D250C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBBB20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUlDPupU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBBB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EfH-0000AG-4o
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j2EeL-0007n4-Vt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j2EeL-0005EI-1l
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:35:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j2EeK-0005E5-TO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smh11OueIeJXRSfRWFxX/lzH2kekG1l4Ah+fZt8P/co=;
 b=NUlDPupUKgTjCxz1CgpDVFc2v4NXPeq0xIHVAip6CV6Xm5Rzn/2ZkKGwhSYkyVsvDoZSbu
 KEfQPgXliPupbQdCC9BGtZZxMWIltf3YrcBnvpjElLXo0MNjY8UmcIKj4bYdtGS4F0wQ2T
 C3qkWTB3Kh9zUmESDvIJpgtkawxndCM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-o-mmekIPOI2nsODNiHmLDg-1; Thu, 13 Feb 2020 08:35:22 -0500
Received: by mail-qt1-f200.google.com with SMTP id m8so3632530qta.20
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r1efBuYHXZVALheKu8xZ+rsz3Sbv09We/PzN1I182kk=;
 b=lcH54pWwrprWt8MfRmsrhE/FyjcvKtwnRya8ulVoBvgt6DoC17gcTG+ZWIcK8O6L3d
 DO4iZ/aLgOhMcJftM0hyvIONfJarLqcbe9HDqF5+M+QTnbXT+DoRWzqT8gRN42cmggBw
 WpvfqBtRxolFCGKFt15tD6zF5WB8NmRiDvEmf9qc8yiCE4jsl7F4XvX17wGLu7sb5C7u
 xdUr3PFaIjr5FbT2hjxZ2i1e6hHpxdGRemVC3SRt1af1cZfZgLbRjIPLRgwTeaOdrXZt
 LYSxZHRJJxRRCjMfKe6Byk+Yl60OccGP/190GU44t5IAyN8d+GQ2M5ixsL3bo1lB8MUC
 Eqrw==
X-Gm-Message-State: APjAAAWKTuDaB7c5Om4YPC3JpjEi92q5DcYnFZNdm/SmTdqX0y9sqX4j
 wVTTePu9jK/GBrmrDudrqTmtxL4FJ3h2tI7U3LeIpwkgcUke+iyFNyJ1eWs+DwOSB5Zh2gg9IGr
 YJe5muAEs8U9cLLE=
X-Received: by 2002:a05:620a:15cf:: with SMTP id
 o15mr15717421qkm.140.1581600921768; 
 Thu, 13 Feb 2020 05:35:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqySCUH90GX2p3SWxrJAfCdZ53q5JGaMkejgNq7Ynn9L3eMGbOfkWGPIZfQ4Kq0UeCLeBhTaiQ==
X-Received: by 2002:a05:620a:15cf:: with SMTP id
 o15mr15717398qkm.140.1581600921502; 
 Thu, 13 Feb 2020 05:35:21 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 p26sm1283452qkp.34.2020.02.13.05.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 05:35:20 -0800 (PST)
Date: Thu, 13 Feb 2020 08:35:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 0/6] small vhost changes and in-band notifications
Message-ID: <20200213083511-mutt-send-email-mst@kernel.org>
References: <20200123081708.7817-1-johannes@sipsolutions.net>
 <16ac7144ac33d52a740e227e9290a1eb41596e09.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <16ac7144ac33d52a740e227e9290a1eb41596e09.camel@sipsolutions.net>
X-MC-Unique: o-mmekIPOI2nsODNiHmLDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Thu, Feb 13, 2020 at 02:26:10PM +0100, Johannes Berg wrote:
> On Thu, 2020-01-23 at 09:17 +0100, Johannes Berg wrote:
> > Hi,
> >=20
> > Here's a repost of all the patches I sent back in August, with the
> > in-band notifications rebased over the reset patch, so IDs have now
> > changed a bit.
>=20
> Ping?
>=20
> The patches still apply on top of latest qemu.
>=20
> I wanted to send some corresponding kernel patches, but without the
> protocol nailed down ...
>=20
> johannes

Queued, thanks!


