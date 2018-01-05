Received: from eggs.gnu.org ([2001:4830:134:3::10]:38601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eXR3d-0004Za-Ap
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eXR3Y-0005nW-K3
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:25:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eXR3Y-0005lW-DY
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:25:04 -0500
Date: Fri, 5 Jan 2018 20:25:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180105122501.GB8592@lemon.usersys.redhat.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
	<20180103024112.GA25758@localhost.localdomain>
	<CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
	<20180103030556.GA27755@localhost.localdomain>
	<87mv1scyp1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87mv1scyp1.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Fri, 01/05 11:49, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Wed, 01/03 15:54, Michael Clark wrote:
> >> On Wed, Jan 3, 2018 at 3:41 PM, Fam Zheng <famz@redhat.com> wrote:
> >>
> >> > On Wed, 01/03 15:00, Michael Clark wrote:
> >> > > So it's essentially one error, the single line case pattern for
> >> > > table-driven decode which flags for long lines and asks to separ=
ate break
> >> > > onto its own line.
> <snip>
> >> > Thanks for taking a look! Practically, consistency with the rest o=
f the
> >> > code and
> >> > human judgements (comments, explanation in replies etc.) often ove=
rride the
> >> > checkpatch complaints. Checkpatch is not always right.
> <snip>
>=20
> Fam,
>=20
> I wonder is there anyway we could signal to patchew that there are some
> acknowledged and approved coding style variances in the patch? Would
> something like:
>=20
>   CodingStyleExceptions: 12
>=20
> Be too polluting to the commit messages? Or perhaps something that can
> skip individual tests on a given run:
>=20
>   CheckpatchFlags: --ignore-long-lines

It sounds feasible. Putting these flags after a --- line will keep commit
message clean.

OTOH I think we should spend effort on patching checkpatch.pl to implemen=
t this.

Fam
