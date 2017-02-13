Received: from eggs.gnu.org ([2001:4830:134:3::10]:36056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdEIt-0007Hb-FZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdEIq-0000qp-9m
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:56:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cdEIq-0000qS-4c
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:56:16 -0500
References: <CAJSP0QWT14J-cqwLqPCr0iC95pSLaiZJgPkqr1VBU=pqYF6kqQ@mail.gmail.com>
	<20170208221050.GP2955@var.home> <20170212073019.GA25566@cs.unibo.it>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a4a3f167-b23b-621c-3d69-5fe32f7df239@redhat.com>
Date: Mon, 13 Feb 2017 11:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170212073019.GA25566@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] libslirp and QEMU slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Renzo Davoli <renzo@cs.unibo.it>, Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, virtualsquare@cs.unibo.it, jasowang@redhat.com, Jan Kiszka <jan.kiszka@web.de>, peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>

On 12.02.2017 08:30, Renzo Davoli wrote:
> Hi,
>=20
> On Wed, Feb 08, 2017 at 11:10:50PM +0100, Samuel Thibault wrote:
>> Hello,
>>
>> Stefan Hajnoczi, on Mon 06 Feb 2017 11:55:05 +0000, wrote:
>>> I'm proposing this topic for discussion because there might be common
>>> ground for Samuel from QEMU and the VDE folks to collaborate.
>>>
>>> Samuel: Should QEMU join forces with libslirp?
>>
>> Well, there are not that many forces from the QEMU side :)
> Neither on VDE side ;-) but many ants can move mountains...
>>
>> - we are using timers for icmp announcements
>> - qemu needs to be able to save/restore state, with compatibility with
>> previous versions
>=20
> libslirp is using qemu's slirp code.
[...]
> Timers have been reimplemented using the qemu's API.
> save/restore are dummy stubs in libslirp. Qemu's code is still there bu=
t it is not used
> by libslirp.

Well, sure, but if this libslirp is going to evolve into a
QEMU-independent library, such timer and save/restore hacks likely
should go away from the library and implemented on the side of the
consuming application instead.

> It would be a nice project to create a common codebase for libslirp.
> The project sould be interesting for other VM projects (virtualbox-OSE?=
) and
> maybe many others. We could collect several ants...

FWIW, I know that WinUAE is using QEMU's slirp code, too.

I've got a question: Is there already a project page and public
repository for libslirp available somewhere? I did not find anything
useful with Google yet...

 Thomas
