Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ezo4u-0006Bg-7B
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ezo3i-0008Si-Vy
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:39:36 -0400
References: <4e8dcc24123a09587ecc427f2e80727ba41a7866.1521868380.git.mprivozn@redhat.com>
	<CAJ+F1CJgXUY888Bo-SQ2yiDWeKk0NKe06bdzkZFL7A-6B4FusQ@mail.gmail.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <82d1bda3-36a9-e5b9-1aa0-8319750c57f7@redhat.com>
Date: Sat, 24 Mar 2018 13:40:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJgXUY888Bo-SQ2yiDWeKk0NKe06bdzkZFL7A-6B4FusQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 03/24/2018 12:01 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sat, Mar 24, 2018 at 6:13 AM, Michal Privoznik <mprivozn@redhat.com>=
 wrote:
>> When trying to build with latest libcacard-2.5.1, I hit the
>> following error:
>>
>> In file included from hw/usb/ccid-card-passthru.c:12:0:
>> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libca=
card.h> can be included directly" [-Werror=3Dcpp]
>>  #warning "Only <libcacard.h> can be included directly"
>>
>=20
> The warning was promptly removed in 2.5.2:
> https://cgit.freedesktop.org/spice/libcacard/commit/?id=3D998db1e88eb82=
19264476c022d1446f3cb4330e8

Cool. But We can still include just top level header file instead of
individual files, can't we?

Michal
