Received: from eggs.gnu.org ([2001:4830:134:3::10]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSflR-0004tv-H9
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSflG-0004Yr-V6
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSflD-0004Po-GT
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:11:01 -0500
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
	<2a53c96f-a712-5719-6e29-4df04b7256af@redhat.com>
	<da361a05-a31f-9ae1-f268-589f632ca9cf@weilnetz.de>
	<CAMxuvayaXHhGs1V1FysNBbHH62XfoH-9gpRytNFOjdE9bimuzg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d82537e-3322-5d0a-5fdb-03a23cdcb827@redhat.com>
Date: Fri, 30 Nov 2018 11:10:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvayaXHhGs1V1FysNBbHH62XfoH-9gpRytNFOjdE9bimuzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 0/4] build-sys: require Vista API
 by default globally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 29/11/18 11:50, Marc-Andr=C3=A9 Lureau wrote:
> On Thu, Nov 29, 2018 at 2:45 PM Stefan Weil <sw@weilnetz.de> wrote:
>>
>> Am 29.11.2018 um 11:16 schrieb Paolo Bonzini:
>>> On 22/11/18 12:00, Marc-Andr=C3=A9 Lureau wrote:
>>>>  include/qemu/osdep.h      | 17 ++++++++++
>>>>  accel/tcg/translate-all.c |  4 ---
>>>>  qga/commands-win32.c      | 70 +-----------------------------------=
---
>>>>  util/qemu-thread-win32.c  |  4 ---
>>>>  configure                 |  3 --
>>>>  roms/seabios              |  2 +-
>>>>  6 files changed, 19 insertions(+), 81 deletions(-)
>>>>
>>> Queued, thanks.
>>>
>>> Paolo
>>
>>
>> Was the change for roms/seabios intentional?
>=20
> oh no! sorry Paolo

Removed, no problem.

Paolo
