Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE91C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBCA222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkx+7PXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBCA222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRYX-0004Vb-IL
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 14:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irRXr-0003yJ-0f
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irRXm-0005KN-9b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:08:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irRXm-0005K8-6X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579028881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7+E+M/83fN9QRNL5Qo1aVenvIJeDzWwKJWwaKWaUV0=;
 b=hkx+7PXgSzVWjaKSECRBMUwLqCWkoov1CbfBHZ/uUXgXh+V1by87Bqs9fMZ01+4eV+wkcC
 7PuPltuNoU0p0ZaGZU67vqh/xQQEOcHJgh/6OC9djjh3r533vbsZNxJdrqd4HcjzIWvvkY
 0JXrZNjd6U5OW/x19lqyskUdj4I3wrM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-omyglxbAMS-Z8uMM6YSzkw-1; Tue, 14 Jan 2020 14:07:58 -0500
Received: by mail-qk1-f198.google.com with SMTP id m13so8993650qka.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=di+83TqLwbVav26htNA2ep0eEvqfoQNUaBlK3etEOlg=;
 b=RoYci7zEBVAB/raklFCWnzoD6mzwvzFoYHM4mvXkA4cRRerr6tlmXIP05TBRmPmaQI
 Y3WzwCxbQI0JvomL1LZpVZAQSES4/aXRDflabuC8diC+OXnv7ZjCGoYJspd1K9PF/O3M
 oQYO9jZlQ9eWtR1RtiZesbAydCQA97uvesPNq2lZYggMrxP9cnqY4CO5N5kGLDgMeS0d
 9m9yMPsTxi0bas8rtWwNPJ1eMsDv2F0X/maEevp0WEFCzctzFyTUNh6s0r/JiTV9cMw/
 Iq9f0KIiCj/xvZME7lrUkhkvb5ckcxK6usVvH9E/m/9ZBeZIKqz28ZhXW4BFWHw9qBiX
 MfLg==
X-Gm-Message-State: APjAAAUL5gJsySjXFdZLeRBABkmU7Iz1xuajnwnY7Yocyn0SDhvOEPJR
 Ki0fhgkGDNKPhHbTb3eRXTucUVa+uZIDQDm6dXWLH8NeElLFh8OTRBOtBUJrD5cIkyPTCPx29R3
 HExB6eh9tFx+RA9I=
X-Received: by 2002:a37:9186:: with SMTP id
 t128mr22062153qkd.180.1579028878122; 
 Tue, 14 Jan 2020 11:07:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbEC8M+Y5uSsXC5xOqJ3mxq07jMx0yWEG7tnjlfX+U0xFpUnVDrZzKW4/+gy7hRwsbSFQbXw==
X-Received: by 2002:a37:9186:: with SMTP id
 t128mr22062135qkd.180.1579028877910; 
 Tue, 14 Jan 2020 11:07:57 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id d25sm7045265qka.39.2020.01.14.11.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 11:07:56 -0800 (PST)
Date: Tue, 14 Jan 2020 14:07:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 12/13] virtio-iommu: Support migration
Message-ID: <20200114190755.GF225163@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-13-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109144319.15912-13-eric.auger@redhat.com>
X-MC-Unique: omyglxbAMS-Z8uMM6YSzkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 03:43:18PM +0100, Eric Auger wrote:
> Add Migration support. We rely on recently added gtree and qlist
> migration. We only migrate the domain gtree. The endpoint gtree
> is re-constructed in a post-load operation.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


