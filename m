Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6739EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238720663
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAltgL50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDajB-0003JJ-3u
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDaed-0001iQ-TH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDaec-0006JS-Sd
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:18:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDaec-0006Hc-Ns
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584307118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTyMKLYginLmm1txRqrZAcoPUUw7zuPYpuhvlLcE+Mg=;
 b=UAltgL50dzRyoFGX977SklvRfhzfI99Zm6rmS6g7lyHg7UXgcchUCFHCZv/qcg9N1NRyPH
 heJLZEORwUamvHMD768NX61nWF7myn0DbaPi/WAia4LFnHGF3zWNPNB31zCTth8dUszOYB
 fDPI+1i41XqNxHTSHiX2ICegrftOAv0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-l0wHGmGnND2MUQST8YtbRQ-1; Sun, 15 Mar 2020 17:18:34 -0400
X-MC-Unique: l0wHGmGnND2MUQST8YtbRQ-1
Received: by mail-qt1-f198.google.com with SMTP id l1so14974890qtp.10
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 14:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h0ZLWa4J+akCTWIhwwIIfIUSHOcDh0fyuuNzQcX4V88=;
 b=gZ93G29mqp8Nx1DVSnuxLU23bIaSxNPmZ+0r8GajGkOrg+MwiYw+vMMcmlHwb77vbv
 iP8+goVw0t5tfwCRpZTwRiJ+E/HBGZQre6f9lKkldCf2CFSsdV+q+djkqzIgq7PrkutJ
 VLvRM5GJSXtgeIPwXxU1dSxeD3qmDGHA0s3FFUvdTnevyGWNHIBvpwOxvTtPXTtAEWrK
 hYW6KPykhGJT+5Fk5QWMVoiH2+Q0JHhfyS4b71tSDrMNwOYPX9Xb0WSLertK9/CTFzsl
 uvZoTg1uUUfZ4EH6apUgdZlo82mI1WXpH73eW34ZQiasJRAWwdbMLlNWVj2gdMSsbAjJ
 4h7Q==
X-Gm-Message-State: ANhLgQ3DhVYsqvLXVzeh2cr5S3Z/O7l1hYNByMIYRIevhQxZynDPH3cB
 VBiK/h0Py4P6xok91l4hK77QJAvQv9mQyHCxggNTHABG4C0x/I5sG5Fvp5DJWhY6+QkxO05YSBF
 hW0RSxC9YRU1VR+E=
X-Received: by 2002:a05:620a:1125:: with SMTP id
 p5mr17517013qkk.103.1584307114186; 
 Sun, 15 Mar 2020 14:18:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu2/dmuQT9B483Bjtl/WLbAKU8WtdA8dbIAWb+7XjIQzwlsWbg45lkGP0dMxvbIByAsGKFRkw==
X-Received: by 2002:a05:620a:1125:: with SMTP id
 p5mr17516999qkk.103.1584307113984; 
 Sun, 15 Mar 2020 14:18:33 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 q66sm225544qkd.47.2020.03.15.14.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 14:18:33 -0700 (PDT)
Date: Sun, 15 Mar 2020 17:18:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 0/2] Fix MAP_SYNC support when host has older glibc
 version
Message-ID: <20200315171719-mutt-send-email-mst@kernel.org>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <7a2bc684-b07e-3825-10db-5f2bf0c33edf@redhat.com>
 <20200315154604.GX1187748@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200315154604.GX1187748@habkost.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 jtomko@redhat.com, qemu-devel@nongnu.org, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 11:46:04AM -0400, Eduardo Habkost wrote:
> On Sat, Mar 14, 2020 at 10:39:11AM +0100, Paolo Bonzini wrote:
> > On 12/03/20 00:23, Eduardo Habkost wrote:
> > > Changes v1 -> v2:
> > > * Use -isystem for $PWD/linux-headers too
> > >   Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> > >=20
> > > This is an alternative to the patch submitted at:
> > >=20
> > >   From: Jingqi Liu <jingqi.liu@intel.com>
> > >   Subject: [PATCH] util: fix to get configuration macros in util/mmap=
-alloc.c
> > >   Date: Thu,  5 Mar 2020 23:41:42 +0800
> > >   Message-Id: <20200305154142.63070-1-jingqi.liu@intel.com>
> > >=20
> > > Before moving the osdep.h include to the top of the file, we had
> > > to address warnings triggered when <linux/mman.h> was included
> > > after <sys/mman.h> (done in patch 1/2).
> > >=20
> > > Eduardo Habkost (2):
> > >   Use -isystem for linux-headers dir
> > >   mmap-alloc: Include osdep.h before checking CONFIG_LINUX
> > >=20
> > >  Makefile.target   | 2 +-
> > >  configure         | 2 +-
> > >  util/mmap-alloc.c | 7 +++----
> > >  3 files changed, 5 insertions(+), 6 deletions(-)
> > >=20
> >=20
> > Queued, thanks.
>=20
> Please don't queue patch 2/2.  It breaks the build on mips.


I don't argue that it doesn't, but MIPS pretends to support features
such as MAP_SYNC when in fact it does nothing.

> --=20
> Eduardo


