Received: from eggs.gnu.org ([2001:4830:134:3::10]:38032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eppQT-0005yi-Ks
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 01:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eppQO-00059K-MF
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 01:04:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eppQO-000592-Ht
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 01:04:40 -0500
Date: Sun, 25 Feb 2018 14:04:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180225060436.GB18756@lemon.usersys.redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
	<adc8d85b-2e7c-e00e-4eba-515327e48699@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <adc8d85b-2e7c-e00e-4eba-515327e48699@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, 02/14 15:08, Paolo Bonzini wrote:
> On 13/02/2018 19:09, Daniel P. Berrang=E9 wrote:
> > Why is a custom entry needed for block here (and other things
> > below).   Won't running get_maintainer.pl already correctly
> > report when a patch needs cc'ing to qemu-block@nongnu.org
> > based on MAINTAINER rules ?
>=20
> Sometimes you want to CC block people even on a non-block patch, for
> example if you want their opinion about using the API.
>=20
> We should probably add at least arm and ppc profiles, too.
>=20
> > --nogit --nogit-fallback
>=20
> QEMU's getmaintainer (unlike the Linux version!) already tries to avoid
> falling back to git if a maintainer is listed.  Are these options neces=
sary?
>=20

Falling back to git is usually more noisy than useful even when a maintai=
ner is
not listed, in my past experience. That's why I don't use it myself and p=
ropose
such here. But I'm open to different opinions.

Fam
