Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4056DC4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1053024656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DednwtJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1053024656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70x6-00063L-AG
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j70wL-0005XF-NM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j70wK-0004nF-PA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:57:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j70wK-0004lt-Kb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582739862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sebDUYLrDxN15HjxAKvkmNDKIlwQORdu5M9DKS14gEc=;
 b=DednwtJf1sS1nB3tqgY/hhlW65IJmkZTvBoJEKJPJrWeyPEhiIhhMLIABQQUu4hqNA0bGl
 YlEVtYslVZjmaxJSK/FSJN612aJjxtT7JskfWnapvTAPSubq4+0h3xyIcuEBQWhiON5i43
 7eXuw5K9w3UWXY+UIHHzEfngiIS20C0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-HBLgXMBgOAuzxQcc99dsow-1; Wed, 26 Feb 2020 12:57:40 -0500
X-MC-Unique: HBLgXMBgOAuzxQcc99dsow-1
Received: by mail-qk1-f197.google.com with SMTP id s189so183886qke.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zIyV6cYTxtRMRBEZz9p+gZhtydpVS4YQXL45UhS0xXI=;
 b=C66t7zrpfbi+WI5tzL5d22ESShoW7E5QWaTYkthPpr2EDAC64JRdX3UVOb25y0Bzt2
 xNryBzIP6hXOV4nMTCx7tCIcGztRzENQq8UiK5GQw1fnh8z9TXsg3ayOB4DHboP/BMXa
 1xFQdMVon5zzc9D/azRo+ayjzKQwYYaMXlS+q9SnHeTznSrfsF9monpSpZd2Fi6vGtR2
 ookXn5ddSXkLGcFpGnWwmwJKuQ5W1vcwEpG82nUy+EjD3yU0TCS7czJHqFCG9qiCJ/wi
 qklwwoFOrxeiwkHdMZh6Z1YCWKaEUx+fJuRWSB4aBQbfnfx5jXbtI1/+Gj6QF0r/SP2e
 yjfA==
X-Gm-Message-State: APjAAAVWdMhVYPHMt3VvkM+xWcCwR2OCcCDoOJezoMmQBFOBVjQ+ZSYP
 sD5n9Q0u7S7rxWxFG7ohUEg1tsN7CNqq7J8Q5pDYz6HbGGnjygp5VImxvvFU5hjBMLxysqIlVXH
 Hbrvn1WWpXTLeQu8=
X-Received: by 2002:a0c:e408:: with SMTP id o8mr284432qvl.236.1582739860029;
 Wed, 26 Feb 2020 09:57:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMmG/mZ0Fg9vDt+tAGd/Khs641RvsSkOEZG/qyP3trSwBOPv44DOBy30bJA1EwtYbYpEMy4Q==
X-Received: by 2002:a0c:e408:: with SMTP id o8mr284407qvl.236.1582739859731;
 Wed, 26 Feb 2020 09:57:39 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id r37sm1463731qtj.44.2020.02.26.09.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 09:57:38 -0800 (PST)
Date: Wed, 26 Feb 2020 12:57:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus
Message-ID: <20200226175737.GE140200@xz-x1>
References: <20200226172628.17449-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226172628.17449-1-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 06:26:28PM +0100, Eric Auger wrote:
> Make sure a null SMMUPciBus is returned in case we were
> not able to identify a pci bus matching the @bus_num.
>=20
> This matches the fix done on intel iommu in commit:
> a2e1cd41ccfe796529abfd1b6aeb1dd4393762a2
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


