Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A182C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3720838
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKpgVJjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0mJ-0007F1-E3
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL0lh-0006bS-I0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:08:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL0lf-0001q7-Np
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zQCXVf4VBHIw1Cg7JX66Y1VL9FjXY4zX/cD/Rhx7GJY=;
 b=FKpgVJjHG7gV8v1mRZvYs31Njn+JxLArsI3zl8Trj/T9Ebuf1jA95FN8+JhBTg17evSvm8
 2l79clMZM9w2blc5Ul5Hc8RssWM0LFjriSMFstNKicH4nQ8l8lh94QeQgpQP3lk3EQii0s
 ejHi5RnGsJn4pKACDYsMO7qHYgSHWGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-8rEZZCy0NuO02u9M764w4g-1; Wed, 23 Sep 2020 05:08:21 -0400
X-MC-Unique: 8rEZZCy0NuO02u9M764w4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1D098030A6;
 Wed, 23 Sep 2020 09:08:20 +0000 (UTC)
Received: from localhost (ovpn-114-98.ams2.redhat.com [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95AF860BF1;
 Wed, 23 Sep 2020 09:08:20 +0000 (UTC)
Date: Wed, 23 Sep 2020 10:08:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 00/20] block/export: Allow exporting BDSs via FUSE
Message-ID: <20200923090819.GB16268@stefanha-x1.localdomain>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922155838.GR1989025@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922155838.GR1989025@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:08:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, mszeredi@redhat.com, qemu-block@nongnu.org,
 afrosi@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 04:58:38PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 22, 2020 at 12:49:12PM +0200, Max Reitz wrote:
> > Based-on: <20200907182011.521007-1-kwolf@redhat.com>
> >           (=E2=80=9Cblock/export: Add infrastructure and QAPI for block=
 exports=E2=80=9D)
> >=20
> > (Though its patch 16 needs a s/=3D \&blk_exp_nbd/=3D drv/ on top.)
> >=20
> > v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.h=
tml
> >=20
> > Branch: https://github.com/XanClic/qemu.git fuse-exports-v2
> > Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v2
> >=20
> >=20
> > Hi,
> >=20
> > Ever since I found out that you can mount FUSE filesystems on regular
> > files (not just directories), I had the idea of adding FUSE block
> > exports to qemu where you can export block nodes as raw images.  The
> > best thing is that you=E2=80=99d be able to mount an image on itself, s=
o
> > whatever format it may be in, qemu lets it appear as a raw image (and
> > you can then use regular tools like dd on it).
> >=20
> > The performance is quite bad so far, but we can always try to improve i=
t
> > if the need arises.  For now I consider it mostly a cute feature to get
> > easy access to the raw contents of image files in any format (without
> > requiring root rights).
>=20
> Aside from the iotests, so you forsee any particular use cases
> where this feature is desirable / important ?

Alice Frosi is working on a qemu-storage-daemon-based project where the
FUSE export type is useful. In this case qemu-storage-daemon is used
stand-alone without a guest or libvirt directly involved. The goal is
just to export disk images and how they are consumed is the user's
responsibility (processes, containers, guests).

> Looking at it from a security POV, I'm not thrilled about the
> idea of granting QEMU permission to use the mount syscall for
> seccomp or SELinux. IOW, I expect this feature won't be something
> we want to expose in QEMU guests managed by libvirt, which would
> limit how widely it can be used.

I have CCed Miklos Szeredi, the Linux FUSE maintainer, to check what the
options are for unprivileged mounting of a FUSE file system:

1. libfuse invokes open("/dev/fuse") + mount()
2. libfuse spawns the fusermount3 suid root helper
3. Any other options? D-Bus? etc

> QEMU can export NBD. Would it make sense to do this as an NBD
> client ? There's already https://libguestfs.org/nbdfuse.1.html
> but IIUC that exposes it as a file within a dir. Presumably
> it is not too hard to make it support exposing it directly as
> a file too.
>=20
> I wonder how performance compares between your native FUSE
> impl in QEMU vs NBD FUSE ?

NBD exports are useful for networks but shouldn't preclude other export
types from being merged just because they can be implemented on top of
NBD. Native export types are simpler to manage and have less performance
overhead than stacking additional tools on top of NBD.

Stefan

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rEIMACgkQnKSrs4Gr
c8iG5wf/RaEeCAO6fwQialGFjYMyN1f+L//cQCMHJH0KWewi7ebnkMd+5Y59rS+e
qV+KBVWvGAupOs0KuE1/XSBFpqd4aAjvtw8ugTaN47Oddr1qcMBM0c83b82laMQa
kRsDh5LITb6yr7ev3Z2il8IK8dpK67kP+OPMyfvOY65uAhr+BkBqcR2dp0y2TPto
TWIAfkvnIU5QDT31XE8kVPw1e+0EyzUmxcuB9RPBi55Go/7h9qzG5rL2PhpBNxa4
uOeRcmpW1KuE5O2lnffbeUC3V/cLeDwCJ6p6GX7hJN/2XNRdra2B66OAx6265esh
mUCRxse6atgxc5PECZdsrrCfjC2q7Q==
=frtR
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--


