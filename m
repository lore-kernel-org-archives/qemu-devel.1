Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF860C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D502206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jW1cclnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D502206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaP0-0003w3-Rm
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaLv-00012F-Pl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:29:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyaLu-0003SL-01
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595507373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNuj0yqfT5LypjnMB0nz+Sodw22E9TDocg2TKZlWStE=;
 b=jW1cclnjVtVHQUNNl5X6YsRrS4Uf9O5T+UkMJmQokWMFcZbaR4eT4A1Ur2GZDoKMlzXfDb
 H/l2DcK90/Iw6O9ArI5Lked/KYlZ7wUXFV4gpA3r7nT86tbqhTV/X5IC+aA6WACnqzgsa1
 IRv2LsUi64AKlr7+mqrGgm+njotdquI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-SQ083dTRPOOPURM-6z1-2A-1; Thu, 23 Jul 2020 08:29:30 -0400
X-MC-Unique: SQ083dTRPOOPURM-6z1-2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46208017FB
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 12:29:29 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4E858BED8;
 Thu, 23 Jul 2020 12:29:25 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:29:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 2/3] virtiofsd: add
 container-friendly -o chroot sandboxing option
Message-ID: <20200723122924.GJ186372@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722181710.GA598987@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722181710.GA598987@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 02:17:10PM -0400, Vivek Goyal wrote:
> On Wed, Jul 22, 2020 at 02:02:05PM +0100, Stefan Hajnoczi wrote:
> > virtiofsd cannot run in an unprivileged container because CAP_SYS_ADMIN
> > is required to create namespaces.
> >=20
> > Introduce a weaker sandbox that is sufficient in container environments
> > because the container runtime already sets up namespaces. Use chroot to
> > restrict path traversal to the shared directory.
> >=20
> > virtiofsd loses the following:
> >=20
> > 1. Mount namespace. The process chroots to the shared directory but
> >    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
> >    syscalls.
> >=20
> > 2. Pid namespace. This should be fine because virtiofsd is the only
> >    process running in the container.
> >=20
> > 3. Network namespace. This should be fine because seccomp already
> >    rejects the connect(2) syscall, but an additional layer of security
> >    is lost. Container runtime-specific network security policies can be
> >    used drop network traffic (except for the vhost-user UNIX domain
> >    socket).
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/helper.c         |  3 +++
> >  tools/virtiofsd/passthrough_ll.c | 44 ++++++++++++++++++++++++++++++--
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index 3105b6c23a..7421c9ca1a 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -151,6 +151,9 @@ void fuse_cmdline_help(void)
> >             "    -o cache=3D<mode>            cache mode. could be one =
of \"auto, "
> >             "always, none\"\n"
> >             "                               default: auto\n"
> > +           "    -o chroot|no_chroot        use container-friendly chro=
ot instead\n"
> > +           "                               of stronger mount namespace=
 sandbox\n"
> > +           "                               default: false\n"
>=20
> This option name disabling namespace setup is little confusing to me.
>=20
> Will it make sense to provide another option to disable/enable
> namespaces. "-o no-namespaces" and that disables setting up
> namespaces.

Thanks, I'll propose a new syntax.

Stefan

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZgqQACgkQnKSrs4Gr
c8h2qAgAyLOF3qPM7OoCvAWSwDCEsd0FRWJFZcterUjQ//F5p4gyp3tB0KTJdmpO
VCs7ileThaahPFtmW9bw1iZAFVh+x9juOk6jusR1k4hE/caBQxpUsiKjnQaIFtWS
TquT7UD/4DWE3bokfB9NZ7K7fiNR4ZAswCEO+6dXQDCxWVX0YdRaXDnq+s7c7wyq
ebIYRc5ZidHaF3A+vrETTACycBxI/FjjVrvKi85S0E7ILs1TuuuL3AawaAB9lIGO
5oCvRhxyVnfK60iI4+iUWo+vIF6pL3Ao//y2yeTkSyBFxwbtb5W7EWt/4Ttwp1Wa
xfZRxvqJVZKEk6ynPnJlHpHenrEdZw==
=RCxG
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--


