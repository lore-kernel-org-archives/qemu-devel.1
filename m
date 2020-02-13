Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD0C3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1332469A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvSOqmGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1332469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GLT-0000XP-Cr
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2GC8-0004hS-NX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2GC7-0000KB-Dt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:14:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2GC7-0000GO-93
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581606861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ade2SLj469FEqRgx9o4Hyyq2hjcS5wtLZnI6lrJkg3U=;
 b=VvSOqmGz4IrmYYMDYsnTSWPwnOKUmq05fIQ6jCXV7obz0Tu7zMNEuRbetz09on+mFV5LFl
 q2i/4E2XFi5cfgeTff2eQhVSuILJjH1z1eOAE4IBcNxz3M+nE/DR+Ga2p4mSWOlI5tSfkr
 aYbwlFf1RCbHk+xjeIUd3+34lkBZqTA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-0silQa-2PDWzV--IiAyvVA-1; Thu, 13 Feb 2020 10:14:19 -0500
Received: by mail-qv1-f72.google.com with SMTP id dr18so3675750qvb.14
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 07:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=D7J324WQAoq2u/kCpVQoNxxqWQHNOPZCO9rtsI+SE2g=;
 b=Yx35rqXGzmQkAB4tFVjV0kWECCEniMMLXyjlfRBgMtylLUqwMFS0UlumoMU0IZn6W9
 L6H2qOktjlHiRp55ksv4Qgf3ivzF4058VlL5ELQLOurNUw/nOV3wWZlRxFSz9rtro/sX
 lml733jVTsJS3nn6ezLToYqlstRV8dPDXlQ7DJoBp9Ru86ipN2aa9x5Wt/I3h0aGlZFT
 Jw8MPbPpFuQy0HpRuHc3wqijNnxUZG3ykARDvCGvkCA95q2HxLmzaWEW/FQ+kNhAqI3U
 k4UTH6YuwcL2yZBAR4lD2GGaHXIBNcxKp4Pp7EhEizgTACsuJWxZraI55A7jcYR/nuUY
 2Q6Q==
X-Gm-Message-State: APjAAAUL+40bS7vxOuTeYuNjVIIKSuiY5MondLDO4QsjiSUCo8sqa0GJ
 WwpdR1ngCGr0Upv5/k/ZK8uJW2acVVZHiUrm8SLIa6NhDuei/S6zM1OQO6/HrW2KPK4bNIzVGvT
 nApww4O9fMlBIvFA=
X-Received: by 2002:ac8:3fd7:: with SMTP id v23mr11839175qtk.293.1581606858701; 
 Thu, 13 Feb 2020 07:14:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/olUw67aKcDa7V3uIGbnjWmagwwd8gdJGvG4T5y4R5j6P9/7zwS0mga+7AjKw14eAlN5l8Q==
X-Received: by 2002:ac8:3fd7:: with SMTP id v23mr11839146qtk.293.1581606858479; 
 Thu, 13 Feb 2020 07:14:18 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id 73sm1605499qtg.40.2020.02.13.07.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 07:14:17 -0800 (PST)
Date: Thu, 13 Feb 2020 10:14:15 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 16/25] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20200213151415.GC1103216@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-17-git-send-email-yi.l.liu@intel.com>
 <20200211233548.GO984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA669@SHSMSX104.ccr.corp.intel.com>
 <20200212152629.GA1083891@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BBCA9@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1BBCA9@SHSMSX104.ccr.corp.intel.com>
X-MC-Unique: 0silQa-2PDWzV--IiAyvVA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 02:59:37AM +0000, Liu, Yi L wrote:
> > - Remove the vtd_pasid_as check right below because it's not needed.
> >=20
> > >
> > >
> > > > > +        if (vtd_pasid_as &&
> >                    ^^^^^^^^^^^^
>=20
> yes, it is. In current series vtd_add_find_pasid_as() doesn=E2=80=99t che=
ck the
> result of vtd_pasid_as mem allocation, so no need to check vtd_pasid_as
> here either. However, it might be better to check the allocation result
> or it will result in issue if allocation failed. What's your preference
> here?

That should not be needed, because IIRC g_malloc0() will directly
coredump if allocation fails.  Even if not, it'll coredump in
vtd_add_find_pasid_as() soon when accessing the NULL pointer.

--=20
Peter Xu


