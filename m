Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96316CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD9221655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD9221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbkD-0006ao-UJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNb9H-0007X3-Gn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNb9F-0005Me-WF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNb9F-0005Lw-N8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:19:21 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD55F83F3C
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:19:20 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m19so24618502qtm.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=W9J+8pC0nI1qSWQgoFlrnvJigANruwVWY+QPi7Oi9kc=;
 b=YulAVHkskm69MF7yevWVYYBhtvVrm27zEdG2SotIAgBSW/bEYD5IdP20ZVGS79rf9R
 Zj09S+mzpBvyiHqn80dCpacS7jbFLCjMSCN2gapyI66owVv6XgI/QIGG6WVz062WGe86
 JKnO30eHWHaRteBZ2K2RCSBmPkIMyysF2flJNSHjPsgRubuc/wNHe5qx3Ylxbf+0WI/3
 RTq58RR7esWgDbWPFPyeuyGH1tB77AsnDhRUTu+6wvGc//Su+f+TrkfxPQqHsnXsreNL
 +LNy9y/VGjOqmMLwf32AOmBK6SzP1eBLjEnx281uMmFWjTOZeNUbz+3u3D4nLbaxQjfn
 l0+A==
X-Gm-Message-State: APjAAAXMtMeZNgnXUmHdbSGjf+12xfRlKBkbN2ewt2qQbf1Gq1kGdMA9
 TXyulkc5d1xJiPsmt8AVch2LKrJYiSe8zpipZ6M3/ekbbywntlULDoDiq3aI+36uyTtLx/VswDt
 8BeDFbl/svfd7lKU=
X-Received: by 2002:a0c:fe02:: with SMTP id x2mr6575190qvr.117.1571915960112; 
 Thu, 24 Oct 2019 04:19:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwbZ3igDy9/Zk5fj3+9Q2nFdgrjr95IUlbXzxb5gfGV7G1pl/y4TUMC2a8NpEy1+0a4PPFTQ==
X-Received: by 2002:a0c:fe02:: with SMTP id x2mr6575148qvr.117.1571915959785; 
 Thu, 24 Oct 2019 04:19:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 e13sm10975534qkm.110.2019.10.24.04.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 04:19:19 -0700 (PDT)
Date: Thu, 24 Oct 2019 07:19:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191024071738-mutt-send-email-mst@kernel.org>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <157166664425.24734.3489596262271351160@37313f22b938>
 <20191021143357.GB5837@work-vm>
 <20191024065826-mutt-send-email-mst@kernel.org>
 <20191024110708.GI3700@redhat.com> <20191024111439.GD2877@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191024111439.GD2877@work-vm>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 12:14:39PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > On Thu, Oct 24, 2019 at 06:59:33AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Oct 21, 2019 at 03:33:57PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * no-reply@patchew.org (no-reply@patchew.org) wrote:
> > > > > Patchew URL: https://patchew.org/QEMU/20191021105832.36574-1-dg=
ilbert@redhat.com/
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > This series seems to have some coding style problems. See outpu=
t below for
> > > > > more information:
> > > > >=20
> > > > > Subject: [PATCH 00/30] virtiofs daemon (base)
> > > > > Type: series
> > > > > Message-id: 20191021105832.36574-1-dgilbert@redhat.com
> > > > >=20
> > > > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > > > #!/bin/bash
> > > > > git rev-parse base > /dev/null || exit 0
> > > > > git config --local diff.renamelimit 0
> > > > > git config --local diff.renames True
> > > > > git config --local diff.algorithm histogram
> > > > > ./scripts/checkpatch.pl --mailback base..
> > > >=20
> > > > Expecting checkpatch to be broken here; most of the files
> > > > follow FUSE's formatting.
> > > >=20
> > > > Dave
> > >=20
> > > I wonder what do others think about this.
> > > One problem with such inconsistencies is that people tend to copy c=
ode
> > > around, which tends to result in a mess.
> >=20
> > IIUC, most of this code is simpy copied as-is from the fuse or linux
> > git repos. I'm wondering what the intention is for it long term ?
> >=20
> > For header files, I would have expected us to be able to compile agai=
nst
> > the -devel package provided by the kernel or fuse packages. I can
> > understand if we want to import the headers if the VSOCK additions to
> > them are not yet widely available in distros though. If this is the c=
ase
> > we should put a time limit on how long we'd keep these copied headers
> > around for before dropping them. It would be fine to violate QEMU cod=
ing
> > style in this case as its not code QEMU would "maintain" long term - =
just
> > a read-only import.
>=20
> The headers are really two types;  one are external definitions, the
> other are internal parts of libfuse.  I'd expect to keep the internal
> parts long term; teh external parts hmm; where would we pull them in
> externally from?
>=20
> > The source files though, we appear to then be modifying locally, whic=
h
> > suggests they'll live in our repo forever. In this case I'd expect to
> > have compliance with QEMU coding standards.
>=20
> OK.
>=20
> > I'm surprised we need to copy so much in from fuse though. Is there a
> > case to be made for fuse to provide a library of APIs for people who
> > are building fuse daemons to link against, instead of copy & fork ?
>=20
> libfuse *is* such a library; but it preserves ABI compliance; it's
> intention is to be used to build filesystem implementations on top of -
> and that's got a fairly good separation;  however changing the fuse
> transport, and security models is much more invasive than it was
> designed for.
>=20
> Dave


I guess you did try to propose adding the functionality to the libfuse
maintainer and got rejected? If not it's worth asking.



> > Regards,
> > Daniel
> > --=20
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dbe=
rrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berran=
ge.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dbe=
rrange :|
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

