Received: from eggs.gnu.org ([2001:4830:134:3::10]:51076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNw6Z-0004qG-8v
	for qemu-devel@nongnu.org; Wed, 30 May 2018 04:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNw6V-0007Hb-VO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 04:05:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNw6V-0007HL-RC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 04:05:07 -0400
Date: Wed, 30 May 2018 16:04:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180530080458.GB27442@xz-mi>
References: <20180521084249.10640-1-peterx@redhat.com>
	<8ef2c984-7817-a54f-ebae-a1f14e453b6a@redhat.com>
	<810f70e6-4ce7-2ad9-2f20-19fc6df57452@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <810f70e6-4ce7-2ad9-2f20-19fc6df57452@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] monitor: turn on Out-Of-Band by default again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Tue, May 22, 2018 at 02:40:26PM -0400, John Snow wrote:
>=20
>=20
> On 05/21/2018 10:13 AM, Eric Blake wrote:
> > On 05/21/2018 03:42 AM, Peter Xu wrote:
> >> We turned Out-Of-Band feature of monitors off for 2.12 release.=C2=A0=
 Now we
> >> try to turn that on again.
> >=20
> > "try to turn" sounds weak, like you aren't sure of this patch.=C2=A0 =
If you
> > aren't sure, then why should we feel safe in applying it?=C2=A0 This =
text is
> > going in the permanent git history, so sound bold, rather than hesita=
nt!
> >=20
> > "We have resolved the issues from last time (commit 3fd2457d reverted=
 by
> > commit a4f90923):
> > - issue 1 ...
> > - issue 2 ...
> > So now we are ready to enable advertisement of the feature by default=
"
> >=20
> > with better descriptions of the issues that you fixed (I can think of=
 at
> > least the fixes adding thread-safety to the current monitor, and fixi=
ng
> > early use of the monitor before qmp_capabilities completes; there may
> > also be other issues that you want to call out).
> >=20
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> --=20
> >> Now OOB should be okay with all known tests (except iotest qcow2, si=
nce
> >> it is still broken on master),
> >=20
> > Which tests are still failing for you?=C2=A0 Ideally, you can still
> > demonstrate that the tests not failing without this patch continue to
> > pass with this patch, even if you call out the tests that have known
> > issues to still be resolved.
> >=20
>=20
> Probably 91 and 169. If any others fail that's news to me.

I just gave it a shot on my workstation too (./check -qcow2):

Not run: 045 059 064 070 075 076 077 078 081 083 084 088 092 093 094 101 =
106 109 113 116 119 123 128 131 135 136 146 148 149 160 162 171 173 175 1=
99 207 210 3
Failures: 087 188 189 198 206
Failed 5 of 167 tests

I'm testing against master, e609fa7.

Thanks,

--=20
Peter Xu
