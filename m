Received: from eggs.gnu.org ([2001:4830:134:3::10]:44620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dme1X-0000od-2S
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dme1T-0001Qf-1k
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:45:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dme1S-0001Oy-OO
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:45:30 -0400
Date: Tue, 29 Aug 2017 18:45:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170829104526.GA8146@lemon>
References: <150338618197.30.13431977153264372738@205a2245145f>
	<d178cec4-e84f-4a1b-8f83-fa0d85d6f707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d178cec4-e84f-4a1b-8f83-fa0d85d6f707@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 0/3] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com

On Tue, 08/29 17:01, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B408=E6=9C=8822=E6=97=A5 15:16, no-reply@patchew.org wrot=
e:
> > Hi,
> >=20
> > This series seems to have some coding style problems. See output belo=
w for
> > more information:
> >=20
> > Type: series
> > Message-id: 1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujits=
u.com
> > Subject: [Qemu-devel] [PATCH V4 0/3] Optimize COLO-compare performanc=
e
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> >=20
> > BASE=3Dbase
> > n=3D1
> > total=3D$(git log --oneline $BASE.. | wc -l)
> > failed=3D0
> >=20
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> >=20
> > commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> > for c in $commits; do
> >      echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)=
..."
> >      if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --ma=
ilback -; then
> >          failed=3D1
> >          echo
> >      fi
> >      n=3D$((n+1))
> > done
> >=20
> > exit $failed
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Switched to a new branch 'test'
> > 37052358b5 net/colo-compare.c: Fix comments and scheme
> > 46824a6565 net/colo-compare.c: Adjust net queue pop order for perform=
ance
> > acea048383 net/colo-compare.c: Optimize unpredictable tcp options com=
parison
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > Checking PATCH 1/3: net/colo-compare.c: Optimize unpredictable tcp op=
tions comparison...
> > Checking PATCH 2/3: net/colo-compare.c: Adjust net queue pop order fo=
r performance...
> > Checking PATCH 3/3: net/colo-compare.c: Fix comments and scheme...
> > ERROR: space prohibited after that '-' (ctx:WxW)
> > #18: FILE: net/colo-compare.c:47:
> > +  |   conn list   + - >      conn     + ------- >      conn     + --=
 > .......
> >                       ^
> >=20
> > ERROR: space prohibited after that '-' (ctx:OxW)
> > #18: FILE: net/colo-compare.c:47:
> > +  |   conn list   + - >      conn     + ------- >      conn     + --=
 > .......
> >                                                 ^
> >=20
> > ERROR: space required one side of that '--' (ctx:WxW)
> > #18: FILE: net/colo-compare.c:47:
> > +  |   conn list   + - >      conn     + ------- >      conn     + --=
 > .......
> >                                                                     ^
> >=20
> > total: 3 errors, 0 warnings, 40 lines checked
> >=20
> > Your patch has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> >=20
> > =3D=3D=3D OUTPUT END =3D=3D=3D
> >=20
> > Test command exited with code: 1
> >=20
> >=20
> > ---
> > Email generated automatically by Patchew [http://patchew.org/].
> > Please send your feedback to patchew-devel@freelists.org
>=20
> Fam, this looks like a false positive since it was actually an ascii gr=
aph
> inside a comment?
>=20

Yes, let's just ignore this report.

Fam
