Received: from eggs.gnu.org ([209.51.188.92]:45590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hCbeg-0005J0-K6
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hCbef-0002XY-C5
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:06:06 -0400
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hCbee-0002Ww-Nu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 23:06:05 -0400
From: Chen Zhang <tgfbeta@me.com>
Message-Id: <F54427F0-DF20-4F0B-A450-8615E96E1155@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Sat, 6 Apr 2019 11:05:59 +0800
In-Reply-To: <69264EAD-C8B6-4EFC-8B31-CA96FA5E3893@me.com>
References: <176E53D9-50B8-405C-82FF-5247342264C1@me.com>
	<CAFEAcA-0HHD30gBgPT6JKX2yj2S7a03cs8FYOvwgDgXZ_mr=oQ@mail.gmail.com>
	<69264EAD-C8B6-4EFC-8B31-CA96FA5E3893@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa: Fix mouse grabbing in fullscreen
 mode for relative input device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

ping

http://patchwork.ozlabs.org/patch/1059842/

> On Mar 27, 2019, at 10:00 AM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
>=20
>=20
>> On Mar 27, 2019, at 12:20 AM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> On Thu, 21 Mar 2019 at 07:10, Chen Zhang <tgfbeta@me.com> wrote:
>>>=20
>>> In fullscreen mode, the window property of cocoaView may not be the =
key
>>> window, and the current implementation would not grab mouse in
>>> fullscreen mode after left clicks on relative input devices.
>>>=20
>>> This patch used isFullscreen value as a short-cirtuit condition for
>>> relative input device grabbing.
>>>=20
>>> Note that this patch should be tested after applying a previous =
patch
>>> which fixed event location conversion for relative input devices.
>>>=20
>>> Signed-off-by: Chen Zhang <tgfbeta@me.com>
>>=20
>> Can you explain in more detail when this patch makes a
>> difference, please? (for instance, a set of instructions
>> for reproducing the issue).
>>=20
>=20
>> I'm confused, because in the toggleFullScreen method, when
>> we switch to full screen mode (which is the only place where
>> we set isFullscreen to true) we always do a [self grabMouse].
>> So if we get into the event handling function and isFullscreen
>> is true, I think the mouse should already be grabbed. What
>> am I missing ?
> Hi,
>=20
> In fullscreen mode, when the mouse is un-grabbed by pressing =
Cmd-Opt-g, it would not be re-grabbed by clicks in the view, as the =
window of the view would not be key window by then.
>=20
> BTW, the Ctrl-Alt-Xs in ui/cocoa.m was confusing in the context. =
Should they be replaced by Cmd-Opt-Xs?
>>=20
>> thanks
>> -- PMM
>=20
> Best Regards,
