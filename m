Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C3220679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZO4Bbbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdQX-00007Y-7y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNdIL-00076k-5z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNdIH-0004Gc-GI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:36:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNdIH-0004GG-Be
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571924208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdGDywILXLvizSILx6vBEBSjW8/wq6FOi2FvnrmvZeg=;
 b=AZO4BbbjnzgQg7F4dvgPDFIWlsW2SUozJyx8PqwxPd/JK3Ln97swHNyI3jyRVLM31vjDQn
 cLNSUy0Zy7x5C7Wmek48zEjZdNXlCneUY+1eME4ajVuyaXSR6fWzhDcFc5Hl1lubNtprwi
 YR2pEYj+nJsx/hM7bZKSVEWCEWMVqY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-1nHhWw5XPY-qgY9RfS71Mw-1; Thu, 24 Oct 2019 09:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04798107AD31;
 Thu, 24 Oct 2019 13:36:40 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C553A6061E;
 Thu, 24 Oct 2019 13:36:10 +0000 (UTC)
Date: Thu, 24 Oct 2019 14:36:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191024133608.GF2877@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <157166664425.24734.3489596262271351160@37313f22b938>
 <20191021143357.GB5837@work-vm>
 <20191024065826-mutt-send-email-mst@kernel.org>
 <20191024110708.GI3700@redhat.com> <20191024111439.GD2877@work-vm>
 <20191024112553.GA8381@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191024112553.GA8381@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1nHhWw5XPY-qgY9RfS71Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 piaojun@huawei.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Oct 24, 2019 at 12:14:39PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Thu, Oct 24, 2019 at 06:59:33AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Oct 21, 2019 at 03:33:57PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > > * no-reply@patchew.org (no-reply@patchew.org) wrote:
> > > > > > Patchew URL: https://patchew.org/QEMU/20191021105832.36574-1-dg=
ilbert@redhat.com/
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > This series seems to have some coding style problems. See outpu=
t below for
> > > > > > more information:
> > > > > >=20
> > > > > > Subject: [PATCH 00/30] virtiofs daemon (base)
> > > > > > Type: series
> > > > > > Message-id: 20191021105832.36574-1-dgilbert@redhat.com
> > > > > >=20
> > > > > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > > > > #!/bin/bash
> > > > > > git rev-parse base > /dev/null || exit 0
> > > > > > git config --local diff.renamelimit 0
> > > > > > git config --local diff.renames True
> > > > > > git config --local diff.algorithm histogram
> > > > > > ./scripts/checkpatch.pl --mailback base..
> > > > >=20
> > > > > Expecting checkpatch to be broken here; most of the files
> > > > > follow FUSE's formatting.
> > > > >=20
> > > > > Dave
> > > >=20
> > > > I wonder what do others think about this.
> > > > One problem with such inconsistencies is that people tend to copy c=
ode
> > > > around, which tends to result in a mess.
> > >=20
> > > IIUC, most of this code is simpy copied as-is from the fuse or linux
> > > git repos. I'm wondering what the intention is for it long term ?
> > >=20
> > > For header files, I would have expected us to be able to compile agai=
nst
> > > the -devel package provided by the kernel or fuse packages. I can
> > > understand if we want to import the headers if the VSOCK additions to
> > > them are not yet widely available in distros though. If this is the c=
ase
> > > we should put a time limit on how long we'd keep these copied headers
> > > around for before dropping them. It would be fine to violate QEMU cod=
ing
> > > style in this case as its not code QEMU would "maintain" long term - =
just
> > > a read-only import.
> >=20
> > The headers are really two types;  one are external definitions, the
> > other are internal parts of libfuse.  I'd expect to keep the internal
> > parts long term; teh external parts hmm; where would we pull them in
> > externally from?
>=20
> The fuse3-devel RPM on Fedora has some, but not all, of the fuse headers
> the patches copy in. Not sure if that's enough though.

No, that's the public API, not the internals which we're poking at.

> The kernel-devel RPM has fuse.h which seems to match fuse_kernel.h header
> being imported.

We do require that we have one that's new enough, so in future it might
be possible; but we're currently using very new parts of fuse.
(It's also not obvious whether the kernel or libfuse owns the 'newest'
version of that header; we think it's probably the kernel).

> Obviously that would mean a configure check to see if the required
> headers exist or not & are new enough for VSOCK

Dave

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


