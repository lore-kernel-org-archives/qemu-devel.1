Received: from eggs.gnu.org ([2001:4830:134:3::10]:55599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFYmL-0007e2-7n
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFYmH-0002xL-8j
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:33:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fFYmH-0002vs-3w
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:33:37 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
	<20180504132023.GA5098@localhost.localdomain>
	<c2207b0b-889a-e39f-2f55-640118e2d755@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <69fd5755-d1f0-b69a-fabb-3134fccaa4a5@redhat.com>
Date: Mon, 7 May 2018 07:33:24 +0200
MIME-Version: 1.0
In-Reply-To: <c2207b0b-889a-e39f-2f55-640118e2d755@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 04.05.2018 19:30, Richard Henderson wrote:
> On 05/04/2018 06:20 AM, Kevin Wolf wrote:
>> I'm not sure what the exact systemd model is, but as we came to the
>> conclusion that there is no semantic difference between major and mino=
r
>> version number for QEMU, I'd just merge them.
>>
>> This would result in 3.0 for the next release, 3.1 etc. would be stabl=
e
>> releases, and the December release would be 4.0.
>>
>> It feels like the minimal change to fix our existing versioning scheme=
.
>=20
> This is very similar to what GCC started to use at version 5.
>=20
>     https://gcc.gnu.org/develop.html#num_scheme
>=20
> I do think it makes sense to drop minor versions, leaving only major +
> patchlevel (which then appears to be minor version).

We're currently also using the patch level for marking developing
version (x.y.50) and release candidates (x.y.9r) ... we should also
think of a way how we want to map that to a new numbering scheme. If we
do it the GCC way, I guess the x.0 release will be the development
"versions"? But the release candidates? Do we still need a third number
for doing those (3.0.1 =3D rc1, 3.0.2 =3D rc2, ...)?

 Thomas
