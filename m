Received: from eggs.gnu.org ([2001:4830:134:3::10]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwhe-0005V7-KS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exwhb-0005Kx-FQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:28:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exwhb-0005Kh-9P
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:27:59 -0400
References: <20180316140508.863778-1-eblake@redhat.com>
	<CAFEAcA85KuXQ7afcAQWJcBeh6ghpnxnGnZWDph51XgQhxPNN4Q@mail.gmail.com>
	<20180319092618.GF2477@xz-mi>
	<3a7260c1-bb51-63a0-5a1b-588a7b1757b3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0c59533-3501-e17e-92d3-6af81f872206@redhat.com>
Date: Mon, 19 Mar 2018 10:27:41 -0500
MIME-Version: 1.0
In-Reply-To: <3a7260c1-bb51-63a0-5a1b-588a7b1757b3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 03/19/2018 09:57 AM, Eric Blake wrote:
> On 03/19/2018 04:26 AM, Peter Xu wrote:
>=20
>>>> for you to fetch changes up to=20
>>>> 75eb57e3ed3682f011a6694863044e8b143a9821:
>>>>
>>>> =C2=A0=C2=A0 qapi: Pass '-u' when doing non-silent diff (2018-03-16 =
09:00:07=20
>>>> -0500)
>>>>
>=20
>>> Hi. I get a bunch of test assertion failures with this:
>>>

>=20
> I haven't been able to reproduce the testsuite failures on my Linux box=
,=20
> but if it's a race, then that doesn't make me all the more confident on=
=20
> what it takes to reproduce and/or fix the race.

Okay, my simple builds on just x86_64-softmmu weren't hitting it, but my=20
'build all binaries' tree seems to be hitting the same thing:

   GTESTER check-qtest-ppcemb
qemu-system-ppcemb: chardev/char-io.c:91: io_watch_poll_finalize:=20
Assertion `iwp->src =3D=3D NULL' failed.
Broken pipe
GTester: last random seed: R02S74d45e64b38428eddd131a5c1b4c878c
make: *** [/home/eblake/qemu-tmp/tests/Makefile.include:878:=20
check-qtest-ppcemb] Error 1

so I'm now testing if your squash makes a difference, now that it looks=20
like I'm reproducing the problem.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
