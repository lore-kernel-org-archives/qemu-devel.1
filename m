Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B719C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D0C22202
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AheVojLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D0C22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPjJ-0005Dt-Nn
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXPeO-0006y8-04
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXPeJ-0006Gd-MX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ld1euDwe3yzvwpzFj4cLI5ajmudDnqKTkbju3hA4dXk=;
 b=AheVojLlROGWHPIERrgL6skVKknjhfeSVwKnRC67hRbPq5BNpJPQyEatiIgPYKePJO+P/r
 Zd2WETinC/OWy5yFk5HtMqTBIrZ67W+NWIXlKAz01Sv8wsacw0zcQtnue2+XafDIAU5zlK
 karWvOB7zZUNS6wWq+RKztxcYNW+Vso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-e2tkHk1LMkS_o2qKJh33PA-1; Tue, 27 Oct 2020 10:08:23 -0400
X-MC-Unique: e2tkHk1LMkS_o2qKJh33PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1AF61054F9F;
 Tue, 27 Oct 2020 14:08:19 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 646C45D9DD;
 Tue, 27 Oct 2020 14:08:19 +0000 (UTC)
Date: Tue, 27 Oct 2020 14:08:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201027140818.GC102411@stefanha-x1.localdomain>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 kraxel@redhat.com, "Justin M. Forbes" <jforbes@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Andreas Faerber <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:04:06AM +0000, Peter Maydell wrote:
> On Thu, 22 Oct 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > now that Gitlab is the primary CI infrastructure for QEMU, and that all
> > QEMU git repositories (including mirrors) are available on Gitlab, I
> > would like to propose that committers use Gitlab when merging commits t=
o
> > QEMU repositories.
>=20
> > Nothing would change for developers, who would still have access to all
> > three sets of repositories (git.qemu.org, gitlab.com and github.com).
> > Committers however would need to have an account on the
> > https://gitlab.com/qemu-project organization with access to the
> > repositories they care about.  They would also lose write access to
> > /srv/git on qemu.org.
>=20
> Yes, this makes sense. Who in practice does it actually affect?
> For the main qemu.git repo, my guess is just me, Michael Roth
> for the stable branches, plus Richard H and Stefan H who both
> volunteered to do a turn on the merge-handling rota once we
> eventually get it set up to not depend on my ad-hoc CI setup.
>=20
> I have a gitlab account so I'm set for this. Michael, do you
> have an account there and are you OK with switching to doing
> git pushes to the repo on gitlab rather than direct to qemu.org ?

Here are the users with commit access to qemu.org repos:

berkeley-softfloat-3 - pmaydell,mdroth,stefanha
berkeley-testfloat-3 - pmaydell,mdroth,stefanha
capstone - pmaydell,mdroth,stefanha
dtc - pmaydell,mdroth,stefanha
edk2 - pmaydell,mdroth,stefanha
ipxe - kraxel,lprosek
keycodemapdb - pmaydell,mdroth,stefanha
libslirp - pmaydell,mdroth,stefanha
meson - pmaydell,mdroth,stefanha
openbios - pmaydell,mdroth,stefanha
openhackware - pmaydell,mdroth,stefanha
opensbi - <none>
qboot - pmaydell,mdroth,stefanha
qemu - pmaydell,mdroth,stefanha
qemu-jeos - pmaydell,mdroth,stefanha
QemuMacDrivers - pmaydell,mdroth,stefanha
qemu-palcode - pmaydell,mdroth,stefanha
qemu-stable-0.10 - jforbes,afaerber,mdroth
qemu-stable-0.14 - jforbes,afaerber,mdroth
qemu-stable-0.15 - jforbes,afaerber,mdroth
qemu-stable-1.0 - jforbes,afaerber,mdroth
qemu-stable-1.1 - jforbes,afaerber,mdroth
qemu-stable-1.2 - jforbes,afaerber,mdroth
qemu-stable-1.3 - jforbes,afaerber,mdroth
qemu-stable-1.4 - jforbes,afaerber,mdroth
qemu-web - paolo,jcody,pmaydell,mdroth,thuth
s390-tools - pmaydell,mdroth,stefanha
seabios - pmaydell,mdroth,stefanha
seabios-hppa - pmaydell,mdroth,stefanha
sgabios - paolo
skiboot - pmaydell,mdroth,stefanha
SLOF - pmaydell,mdroth,stefanha
u-boot - pmaydell,mdroth,stefanha
u-boot-sam460ex - pmaydell,mdroth,stefanha
vbootrom - pmaydell,mdroth,stefanha
vgabios - pmaydell,mdroth,stefanha

Quite a few of those repos are mirrors and actually don't need human
push access.

The people who need push access are:
 * bonzini - qemu-web
 * mdroth - qemu-stable
 * pmaydell - qemu
 * rth - qemu
 * stefanha - qemu
 * thuth - qemu-web

Does this sound good?

Stefan

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+YKdIACgkQnKSrs4Gr
c8jvzQf+J6oJV1P465disXcQGO8ZmcFdDG+7mZ6ARL8r7R1g7gsZ/43VmhSY82Bf
DBtKOjHApieE2fp7QE4jty6yKOS0Sx4phsJi7/HMjDnJnqYDl1CFztCHD8W6OW/u
hKENJBJMBf4pMrr3vmOW2p6RbEla+zWLFrgU6tROVENIgYpmtm0oB0e74bR3/t0B
UQloVrtqr6E33ynnZ5EwWJ7QVQOxaUM8iAtFm6FlXJLX3uaUmmb/KSy27Rz5qLBK
TUVv4/2/tlJiQR7mX8WW8TcgnKMh9RdgkZ9cBZbjUAt4alz0soSYp9y/TC0lxbij
1QfsgRF534RjLuDp4NXHFYOUuGGH0g==
=CGVF
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--


