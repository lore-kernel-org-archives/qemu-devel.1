Received: from eggs.gnu.org ([2001:4830:134:3::10]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewlsx-0003JP-8c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewlsu-0006v9-66
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:42:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewlsu-0006up-0o
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:42:48 -0400
Date: Fri, 16 Mar 2018 09:42:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316094228.GC3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180314073000.3701-1-boqun.feng@intel.com>
	<20180314130130.GH17603@redhat.com>
	<20180316021157.GB3734@dragonstone.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316021157.GB3734@dragonstone.sh.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: add KNM cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boqun Feng <boqun.feng@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 16, 2018 at 10:11:57AM +0800, Boqun Feng wrote:
> On Wed, Mar 14, 2018 at 01:01:30PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Mar 14, 2018 at 03:29:59PM +0800, Boqun Feng wrote:
> > > A new cpu model called "KNM" is added to model Knights Mill process=
ors.
> >=20
> > Why the obscure acryonym? Can't we just call it KnightsMill so it is
> > obvious what it is to everyone, as we've done for all other Intel
> > CPU model names in the past.
> >=20
>=20
> Ah.. my bad, good point! I will rename to "KnightsMill" in the next
> version.
>=20
> > > Compared to "Skylake-Server" cpu model, the following features are
> > > added:
> > >=20
> > > 	avx512_4vnniw avx512_4fmaps avx512pf avx512er avx512_vpopcntdq
> > >=20
> > > and the following features are removed:
> > >=20
> > > 	pcid invpcid clflushopt avx512dq avx512bw axv512cd clwb smap rtm
> > > 	mpx xsavec xgetbv1 hle
> >=20
> > "pcid" was one of the features critical to mitigate performance
> > downside of the Meltdown bug fix in guests. Will Knights Mill have
> > a fix for Meltdown in hardware, to avoid the need for split table
> > pages and thus avoid the perf hit in guests ?
> >=20
>=20
> I got the confirmation the Knights Mill doesn't have PCID at all. For
> the alternative fix for Meltdown in hardware, I will ask around and inf=
o
> you if I get something.

No need to wait for an answer to that question - if 'pcid' is not
in hardware, we simply have to accept whatever the answer is. So
just repost with the changed name.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
