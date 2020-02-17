Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69658C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D00D20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAcxZOsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D00D20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gzF-0008L0-7D
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ndevos@redhat.com>) id 1j3gyR-0007qW-PN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ndevos@redhat.com>) id 1j3gyK-0004oR-SJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:02:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51114
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ndevos@redhat.com>) id 1j3gyK-0004nr-O7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581948124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/J4XS6S6HB9kBBxJu5IgApFeFH7xdPLijFqrmJWJhak=;
 b=LAcxZOsb9vzOIFefuZoZgsiloRamaLikAhaMLJN10A+tm0Hi99i9XVDbf2+CMaU8NcFN+P
 5BWubFfxJBB5gplP4CNPJ/TSRSdUuU2j+I3ra9z1AThNk4ir/ND9asEpOjM/fdiMMmv1qJ
 t06Rry+e3uYDg5lBYHDdn26ZbWpH/Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ZEhWRzZ0MKGQAcfXjQCq1g-1; Mon, 17 Feb 2020 09:01:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB5D100F603;
 Mon, 17 Feb 2020 14:01:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D93B19E9C;
 Mon, 17 Feb 2020 14:01:53 +0000 (UTC)
Date: Mon, 17 Feb 2020 15:01:51 +0100
From: Niels de Vos <ndevos@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [GEDI] [PATCH 07/17] gluster: Drop useless has_zero_init callback
Message-ID: <20200217140151.GO239686@ndevos-x270.lan.nixpanic.net>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-8-eblake@redhat.com>
 <20200217080614.GG239686@ndevos-x270.lan.nixpanic.net>
 <457280bf-58da-404d-7ac1-edf1531623c9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <457280bf-58da-404d-7ac1-edf1531623c9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZEhWRzZ0MKGQAcfXjQCq1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, david.edmondson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 06:03:40AM -0600, Eric Blake wrote:
> On 2/17/20 2:06 AM, Niels de Vos wrote:
> > On Fri, Jan 31, 2020 at 11:44:26AM -0600, Eric Blake wrote:
> > > block.c already defaults to 0 if we don't provide a callback; there's
> > > no need to write a callback that always fails.
> > >=20
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> >=20
> > Reviewed-by: Niels de Vos <ndevos@redhat.com>
> >=20
>=20
> Per your other message,
>=20
> On 2/17/20 2:16 AM, Niels de Vos wrote:
> > On Fri, Jan 31, 2020 at 11:44:31AM -0600, Eric Blake wrote:
> >> Since gluster already copies file-posix for lseek usage in block
> >> status, it also makes sense to copy it for learning if the image
> >> currently reads as all zeroes.
> >>
>=20
> >> +static int qemu_gluster_known_zeroes(BlockDriverState *bs)
> >> +{
> >> +    /*
> >> +     * GlusterFS volume could be backed by a block device, with no wa=
y
> >
> > Actually, Gluster dropped support for volumes backed by block devices
> > (LVM) a few releases back. Nobody could be found that used it, and it
> > could not be combined with other Gluster features. All contents on a
> > Gluster volume is now always backed by 'normal' files on a filesystem.
>=20
> That's useful to know.  Thanks!
>=20
> >
> > Creation or truncation should behave just as on a file on a local
> > filesystem. So maybe qemu_gluster_known_zeroes is not needed at all?
>=20
> Which version of gluster first required a regular filesystem backing for =
all
> gluster files?  Does qemu support older versions (in which case, what is =
the
> correct version-probing invocation to return 0 prior to that point, and 1
> after), or do all versions supported by qemu already guarantee zero
> initialization on creation or widening truncation by virtue of POSIX file
> semantics (in which case, patch 7 should instead switch to using
> .bdrv_has_zero_init_1 for both functions)?  Per configure, we probe for
> glusterfs_xlator_opt from gluster 4, which implies the code still tries t=
o
> be portable to even older gluster, but I'm not sure if this squares with
> qemu-doc.texi which mentions our minimum distro policy (for example, now
> that qemu requires python 3 consistent with our distro policy, that rules
> out several older systems where older gluster was likely to be present).

The block device feature (storage/bd xlator) got deprecated in Gluster
5.0, and was removed with Gluster 6.0. Fedora 29 is the last version
that contained the bd.so xlator (glusterfs-server 5.0, deprecated).

All currently maintained and available Gluster releases should have
glusterfs_xlator_opt (introduced with glusterfs-3.5 in 2014). However, I
am not sure what versions are provided with different distributions. The
expectation is that at least Gluster 5 is provided, as older releases
will not get any updates anymore. See
https://www.gluster.org/release-schedule/ for a more detailed timeline.

Unfortunately there is no reasonable way to probe for the type of
backend (block or filesystem) that is used. So, a runtime check to be on
the extreme safe side to fallback on block device backends is not an
option.

HTH,
Niels


