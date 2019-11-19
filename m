Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5804C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F5822384
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnUCUuR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F5822384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6ZL-0003Zr-KT
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iX6X8-00027Y-Oa
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iX6X5-0007Yo-Qz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:39:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iX6X5-0007YM-MP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574181554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VQUXsHoPz1NsWKtE7cjcJ/5l1l0RUZGX9CGudOHXak=;
 b=TnUCUuR7yYrFTOmMh7R6axl1YLKJ9r8l3DHswEO4VicN5LwgDqsy5Z1BfpVwNdy7qffWkJ
 Alr2nM/zgQuQtQxBsTh7HXPxCYLALwWXGaJ1XKtJI37V0fsXhYIAH5ouhsfdF7DEDdtuNE
 /CPlYCYH5Le54MEMgExdcNIZyFdrKWg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KyYf1SwhO_SrcyEc77Alog-1; Tue, 19 Nov 2019 11:39:11 -0500
Received: by mail-qt1-f200.google.com with SMTP id 6so14984557qtu.7
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=anC+AjZDFuVdi1e2ULPAYuCmWljwvJ63B/JrHNoxseg=;
 b=NRo6OYe9jGdFMl2m2EdaLsoBAIWEmQ2EdMLrO2UJ6ytnLy9RgtixIDadn0HDUZ5d3Z
 i0HSXTnqbgMxngsIhczaR4Hb50BHnFUsxnobopOCoBber9jxTezcw7gCu2N0X5yusx4K
 uk2yuS1yMQ7cJCtzLvPNB+s5T3NgdnRVRTq8X9t9nFKPJQdqduhP0J8nrBd8JnoA9M21
 fMWyjHdOOQXapsk4FjJRpEyg5G4kLmeYwW9O0zdfQPZKTAgYeZPEHBV2ojMB0Y9/n0EI
 /6QSKLv8k3vHKCTZlVvxWn5RsL3OWikEuf+WvifzzjlKwBqsB71wbWh87JKjt53zCO17
 AxuQ==
X-Gm-Message-State: APjAAAX0oPt0Ws1h1bG83xSWj4Cd6yrZ50Pc9vc5AABUfoC0Kq5R+DSD
 AfcWoGKvZN7K0mynvEgiU65GJRtK/6GGfm5MzcQGtqe5lzpzM9lS+FoEE1wy/+wP4MLal6m7fdG
 xzzD+aVMN4ewTmVY=
X-Received: by 2002:a37:668f:: with SMTP id a137mr1644667qkc.338.1574181550905; 
 Tue, 19 Nov 2019 08:39:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/XMxl3j9a8Uqy8rlDpwwnYykwgKbJxv2Fi9e6RNZNCmcsMQto8ZliwFWyAO4P61sN2kEsaA==
X-Received: by 2002:a37:668f:: with SMTP id a137mr1644625qkc.338.1574181550573; 
 Tue, 19 Nov 2019 08:39:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id x1sm10463806qke.125.2019.11.19.08.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 08:39:09 -0800 (PST)
Date: Tue, 19 Nov 2019 11:39:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 0/2] TM field check failed
Message-ID: <20191119113853-mutt-send-email-mst@kernel.org>
References: <cover.1570503331.git.qi1.zhang@intel.com>
 <20191119060259-mutt-send-email-mst@kernel.org>
 <20191119162110.GL9053@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20191119162110.GL9053@xz-x1>
X-MC-Unique: KyYf1SwhO_SrcyEc77Alog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 11:21:10AM -0500, Peter Xu wrote:
> On Tue, Nov 19, 2019 at 06:05:11AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 19, 2019 at 08:28:12PM +0800, qi1.zhang@intel.com wrote:
> > > From: "Zhang, Qi" <qi1.zhang@intel.com>
> > >=20
> > > spilt the reserved fields arrays and remove TM field from reserved=20
> > >  bits
> >=20
> > Looks good to me.
> > Also Cc Peter Xu.
> > Also I wonder - do we need to version this change
> > with the machine type? Peter what's your take?
>=20
> It should be a bugfix to me.  With the patchset we check even less
> reserved bits, then imho it shouldn't break any existing good users.
> So we can probably skip versioning this change.


Can you ack this patch then?

> > Also, Peter, how about we create a MAINTAINERS entry for IOMMUs
> > and add everyone involved, this way people will
> > remember to CC you?
>=20
> Sure, I'll be fine with either way.
>=20
> Thanks,
>=20
> --=20
> Peter Xu


