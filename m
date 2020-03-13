Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2042CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA51206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6lfH/1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA51206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClpq-0008PE-0I
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jClmv-0005OZ-IM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jClmt-0004Eu-Ss
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:59:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jClmt-0004Cq-Nx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584111584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gX+Bse4Il4+6kcLBFLlaNb6UUTD2lVAzBEi5/+04rw=;
 b=S6lfH/1OOO4NntTon424x9qhP8yZI9wrY69z3I3Xc3ylBLv8jUKR7uI8WjicZi/225AZ2a
 gGqJL1FCy7x/i7mSRHhG+CNfjj5qAOUY2mDFAWhrYE/xzrv6v1tfcos32nENHZjXV/KHRY
 n7p84AK7aw4j/pAVMkP5eiMChyd3NEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-PHNCILD5M-e0WdNWfEV8_w-1; Fri, 13 Mar 2020 10:59:41 -0400
X-MC-Unique: PHNCILD5M-e0WdNWfEV8_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F12A11005514
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-127-103.rdu2.redhat.com
 [10.10.127.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7620A5C1B5;
 Fri, 13 Mar 2020 14:59:40 +0000 (UTC)
Date: Fri, 13 Mar 2020 10:59:38 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH 1/5] tests/docker: add CentOS 8 Dockerfile
Message-ID: <20200313145938.GB492336@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-2-crosa@redhat.com>
 <20200313084655.GC293912@beluga.usersys.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200313084655.GC293912@beluga.usersys.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 09:46:55AM +0100, Erik Skultety wrote:
> On Thu, Mar 12, 2020 at 03:36:12PM -0400, Cleber Rosa wrote:
> > Which is currenly missing, and will be referenced later in the
> > contributed CI playbooks.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/docker/dockerfiles/centos8.docker | 32 +++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 tests/docker/dockerfiles/centos8.docker
> >=20
> > diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/doc=
kerfiles/centos8.docker
> > new file mode 100644
> > index 0000000000..bfa0d33c9c
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles/centos8.docker
> > @@ -0,0 +1,32 @@
> > +FROM centos:8.1.1911
> > +
> > +RUN dnf -y update
> > +ENV PACKAGES \
> > +    SDL-devel \
> > +    bison \
> > +    bzip2 \
> > +    bzip2-devel \
> > +    dbus-daemon \
> > +    flex \
> > +    gcc \
> > +    gcc-c++ \
> > +    gettext \
> > +    git \
> > +    glib2-devel \
> > +    libaio-devel \
> > +    libepoxy-devel \
> > +    lzo-devel \
> > +    make \
> > +    mesa-libEGL-devel \
> > +    nettle-devel \
> > +    perl-Test-Harness \
> > +    pixman-devel \
> > +    python36 \
> > +    rdma-core-devel \
> > +    spice-glib-devel \
> > +    spice-server \
> > +    tar \
> > +    zlib-devel
> > +
> > +RUN dnf install -y $PACKAGES
> > +RUN rpm -q $PACKAGES | sort > /packages.txt
>=20
> How is the packages.txt consumed later?
>=20
> Erik

The explanation given by Alex on this thread is better than I would be
able to provide. :)

Thanks,
- Cleber.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5rn9oACgkQZX6NM6Xy
CfM+WhAAi4bb/k4jbcWmn7fdzfCSj9rgfNa67UCv2h3FhpfZ7eOvcV0VM2ISktaj
KYR/G2jg2yNShL2gH2Zc0bGMD8LCUID9T817G6b0qUv3bIeJbw/3cC67+P+QVKRy
Gt2zsPVcqkpgvz4v0hm/1idGUrZr5V14WuJaSLTZP/uZ34U4Tc68qQnoaqTtl79x
Zys8nigVy41plTqaVeDLEth4LSx/5RAzzagIUg380zA7My8rWn1hWdKmkZXF7Lfx
V2C7ygE27iqDIyomgzzkLBbF8uRoZwtvzRkMZVZUqa0fEjCp/JcrF7UGQTwF9ft0
3occ0mYMcTZY6ERCZFk2wfvERzc0RHYG/RjBlbCuFwq1im+OUxVqKco1VQmrCzHL
d75z+eRFoPCsirEgMX14nyCqwMRczbOW5Xipj4/5a581Q1SjmEEWgz8dCDn3el+d
1PVqykcSSNmFebSDxmdW60bw+I+vVvCWxrqK7UeOUSL0tFBqFjKLFaIZmsdZzYvP
POdSiQBBDMsUM7SxUOtafjAJtVVomgz73+mwbdIyi8c7EiWwgSa4VhQvv/0Yo6Cp
QnNUHhzPNAxz0nT8vqLL7eeaB4rj10PzNfxPR2cQWraiYiTnUmNTZC3nYIoRR/c+
eo5GSXyAFfZQYMASpvgl5az0gnmNEyI3+78JuGoJRoP1HfecZ7w=
=8K/X
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--


