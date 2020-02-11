Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB713C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8686920714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWynsKWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1dX7-0003CB-Mv
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 16:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1dWL-0002eA-OX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1dWJ-0007Ty-M4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:56:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1dWH-0007S9-Ef
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581458196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f21/Alz6iQGm1jt4HaEQlVYFcXWP20O4z1EhzSv4bpE=;
 b=CWynsKWJMrggFnlKk1Vkr1sUsJ/vd6jTkeE6VEFPT2vI7mSw1493RQmdzh8xobOkQUtj9o
 DCfWpHw9ac0XHXo9Pc7Gyw2vNPx5pBVwG8RRoTvr20S/WpwmUhkx3ArGu0+0tpOjHpgQcu
 V3Hfx7LJ/wwOJbF9ztnIGpdyBjLzdus=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-26Ytbq8pPfWd8hPYT4jrKw-1; Tue, 11 Feb 2020 16:56:34 -0500
Received: by mail-qk1-f198.google.com with SMTP id i135so8174830qke.14
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 13:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NE1dJdRP/8g3ODXzP6iKZBLufSoTvZmJMR+yVmTI/CI=;
 b=T8Ss9Orvgndd7X/UUjM7wHi0UX1aWP56FeYNbb++Mf6FpKq9xpFr5Jfc1ZREsmDKWI
 eshAx1NZBJJtVZEqJJAbwdD3KT93fSr+gQ1l+miqgwQVHUg62DD41PtVqpvRme1I1kXI
 q+KuwVULiUE/0QbvaK6sqSTp+Vbm13qyNa0P20EvLWG+c+6o4Mh9oQI85DeE3dITPwfA
 aJ5kVHahe8GvZ9s53XxE1WBan9OvbWNQh3NfwfLNXNVhhKGmoUbNWm8lU3z7hXiph474
 cWpp8S/3kuYr9sGGYrRM3Tl9OSeHu11eXsSZgv1nPSmAI5LVFUC3Y413J3gG1cm5Uskc
 Tnnw==
X-Gm-Message-State: APjAAAXdwwyBqXIUU+a8FedEIwr68eoFiM5r11QHFZRd5W9q47LBYN8f
 XRjiyfnI+5Bnlv50SF05ZkFezCPI+b9YW2c/A8BurqHeVcrsMZJMOInJu/f+zpdU9aNk7BINiEk
 K1FUw+soJVDucLnc=
X-Received: by 2002:ac8:7217:: with SMTP id a23mr4515660qtp.241.1581458193888; 
 Tue, 11 Feb 2020 13:56:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwioyKgRYLaTQid+3oBIsHiXJuXHFBKGSGp0uoPUY/asYhxAfwPjPD4w7PnbofIELfwZSqrjQ==
X-Received: by 2002:ac8:7217:: with SMTP id a23mr4515642qtp.241.1581458193578; 
 Tue, 11 Feb 2020 13:56:33 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id o189sm2774095qkd.124.2020.02.11.13.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 13:56:32 -0800 (PST)
Date: Tue, 11 Feb 2020 16:56:30 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 14/25] intel_iommu: add virtual command capability support
Message-ID: <20200211215630.GN984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-15-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1580300216-86172-15-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: 26Ytbq8pPfWd8hPYT4jrKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 04:16:45AM -0800, Liu, Yi L wrote:
> +/*
> + * The basic idea is to let hypervisor to set a range for available
> + * PASIDs for VMs. One of the reasons is PASID #0 is reserved by
> + * RID_PASID usage. We have no idea how many reserved PASIDs in future,
> + * so here just an evaluated value. Honestly, set it as "1" is enough
> + * at current stage.
> + */
> +#define VTD_MIN_HPASID              1
> +#define VTD_MAX_HPASID              0xFFFFF

One more question: I see that PASID is defined as 20bits long.  It's
fine.  However I start to get confused on how the Scalable Mode PASID
Directory could service that much of PASID entries.

I'm looking at spec 3.4.3, Figure 3-8.

Firstly, we only have two levels for a PASID table.  The context entry
of a device stores a pointer to the "Scalable Mode PASID Directory"
page. I see that there're 2^14 entries in "Scalable Mode PASID
Directory" page, each is a "Scalable Mode PASID Table".
However... how do we fit in the 4K page if each entry is a pointer of
x86_64 (8 bytes) while there're 2^14 entries?  A simple math gives me
4K/8 =3D 512, which means the "Scalable Mode PASID Directory" page can
only have 512 entries, then how the 2^14 come from?  Hmm??

Apart of this: also I just noticed (when reading the latter part of
the series) that the time that a pasid table walk can consume will
depend on this value too.  I'd suggest to make this as small as we
can, as long as it satisfies the usage.  We can even bump it in the
future.

--=20
Peter Xu


