Received: from eggs.gnu.org ([2001:4830:134:3::10]:57790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eEEcj-0006UR-6y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eEEci-0005Lq-6s
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:18:01 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:48118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eEEci-0005L4-31
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:18:00 -0500
Received: by mail-qt0-x22d.google.com with SMTP id y5so3136536qtk.4
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 05:17:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113125933.kvykfcrxgyh7bn2v@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-2-makovick@gmail.com>
	<20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
	<20171113125933.kvykfcrxgyh7bn2v@sirius.home.kraxel.org>
From: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Date: Mon, 13 Nov 2017 14:17:58 +0100
Message-ID: <CAHmvugcrN1xjeQ=Zf56oAbV19a+-jBK70GCAQSi1CvOc4LvK3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating
 after the window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Nov 13, 2017 at 1:59 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, Nov 13, 2017 at 01:39:14PM +0100, Gerd Hoffmann wrote:
>> On Sun, Nov 12, 2017 at 08:30:25PM +0100, Jindrich Makovicka wrote:
>> > With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
>> > blocks all subsequent display updates.
>> >
>> > Instead of trying to override the change, just update the scon->hidden
>> > flag.
>>
>> Has for me the side effect that sometimes I have to press ctrl-alt-2
>> twice.  Showing window first time works.  Hiding the window works too.
>> Showing it the second time needs the double keypress.
>>
>> Added fprintfs to figure why [1].  Reason for that seems to be a suspiou=
s
>> SDL_WINDOWEVENT_SHOWN event from SDL, so qemu thinks the window is
>> visible even though it actually is hidden.
>>
>> Have a slightly older SDL version (2.0.3).  Do you see that effect with
>> 2.0.6 too?
>
> Oh, and I've just seen the current code has been added as attempt to
> workaround that bug, see commit d3f3a0f453ea590be529079ae214c200bb5ecc1a.
>
> Hmm.  Seems we are trading one issue for another here, due to bugs in
> SDL :(

Does this happen for you with the whole series applied, or just the
1st patch? Especially

[PATCH 8/8] sdl2: Ignore UI hotkeys after a focus change when GUI
modifier is held

can have an impact on the behavior you described.

Regards,
--=20
Jind=C5=99ich Makovi=C4=8Dka
