Received: from eggs.gnu.org ([2001:4830:134:3::10]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezlhY-0004Y7-2B
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezlgU-0004Ns-1h
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 12:07:28 -0400
MIME-Version: 1.0
In-Reply-To: <82d1bda3-36a9-e5b9-1aa0-8319750c57f7@redhat.com>
References: <4e8dcc24123a09587ecc427f2e80727ba41a7866.1521868380.git.mprivozn@redhat.com>
	<CAJ+F1CJgXUY888Bo-SQ2yiDWeKk0NKe06bdzkZFL7A-6B4FusQ@mail.gmail.com>
	<82d1bda3-36a9-e5b9-1aa0-8319750c57f7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 24 Mar 2018 14:38:55 +0100
Message-ID: <CAJ+F1CL4gBhh_qGc0ZV7bE__UvZaeLwFEyV--dHth6iX2HK1vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Michal Privoznik <mprivozn@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Sat, Mar 24, 2018 at 1:40 PM, Michal Privoznik <mprivozn@redhat.com> wro=
te:
> On 03/24/2018 12:01 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Sat, Mar 24, 2018 at 6:13 AM, Michal Privoznik <mprivozn@redhat.com> =
wrote:
>>> When trying to build with latest libcacard-2.5.1, I hit the
>>> following error:
>>>
>>> In file included from hw/usb/ccid-card-passthru.c:12:0:
>>> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcac=
ard.h> can be included directly" [-Werror=3Dcpp]
>>>  #warning "Only <libcacard.h> can be included directly"
>>>
>>
>> The warning was promptly removed in 2.5.2:
>> https://cgit.freedesktop.org/spice/libcacard/commit/?id=3D998db1e88eb821=
9264476c022d1446f3cb4330e8
>
> Cool. But We can still include just top level header file instead of
> individual files, can't we?

Yes, if we bump libcacard version dependency. 2.5.1 (that added
top-level libcacard.h) is from 2015-11-24.



--=20
Marc-Andr=C3=A9 Lureau
