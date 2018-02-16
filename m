Received: from eggs.gnu.org ([2001:4830:134:3::10]:46079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1emhIC-0002RX-Cg
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1emhI9-0004d5-9p
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:47:16 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:50757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1emhI9-0004ct-3h
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:47:13 -0500
Received: by mail-it0-x229.google.com with SMTP id y16so2077519itc.0
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 06:47:12 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180216131540.ioudb6rwf4y6qnxq@sirius.home.kraxel.org>
Date: Fri, 16 Feb 2018 09:47:10 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <55E5910F-47CB-49BD-83F2-E867750F9BEA@gmail.com>
References: <20180203171743.13612-1-programmingkidx@gmail.com>
	<20180216131540.ioudb6rwf4y6qnxq@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v6] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org


> On Feb 16, 2018, at 8:15 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Sat, Feb 03, 2018 at 12:17:43PM -0500, John Arbuckle wrote:
>> Currently the ungrab keys for the Cocoa and GTK interface are =
Control-Alt-g.
>> This combination may not be very fun for the user to have to enter, =
so we
>> now enable the user to specify their own key(s) as the ungrab key(s). =
The
>> list of keys that can be used is found in the file qapi/ui.json under =
QKeyCode.
>> The max number of keys that can be used is three.
>>=20
>> Syntax: -display cocoa,hotkey-grab=3D<key-key-key>
>>=20
>> Example usage:  -display cocoa,hotkey-grab=3Dhome
>> 	        -display cocoa,hotkey-grab=3Dshift-ctrl
>> 		-display cocoa,hotkey-grab=3Dctrl-x
>> 		-display cocoa,hotkey-grab=3Dpgup-pgdn
>> 		-display cocoa,hotkey-grab=3Dkp_5-kp_6
>> 		-display cocoa,hotkey-grab=3Dkp_4-kp_5-kp_6
>> 		-display cocoa,hotkey-grab=3Dctrl-alt
>=20
> Finally found the time for a closer look and some testing.
>=20
> Problem is the hotkeys are all forwarded to the guest.
> So when using -- for example -- the pgup-pgdn hotkey
> and you press the combination the guest will see it.
>=20
> I see basically two options to deal with that:
>=20
> (a) Make the code more clever.  On pgup keydown event
>    the code has to figure this might be part of a hotkey
>    sequence, hold back the event to see what comes next.
>    - If the next event is pgup keyup -> ok, normal pgup
>      keypress, forward both keydown and keyup to the guest.
>    - If the next event is pgdn keydown -> hotkey found.
>      So do hotkey action, don't forward keydown (and
>      following keyup) events to the guest.

Ok. I think this should be doable.

>=20
> (b) Restrict allowed hotkeys to modifier key(s) plus one
>    non-modifier key.  Forwarding modifier keydown+keyup
>    to the guest has typically effects inside the guest,
>    so we only have to hold back that single non-modifier
>    key.  That is alot easier to implement.

Sorry but I was using this patch to make my ungrab key F15.
This key is not used by anything and makes things so simple
for me. Requiring a modifier key in the sequence seems unnecessary.=20

Thank you.=
