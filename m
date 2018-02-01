Received: from eggs.gnu.org ([2001:4830:134:3::10]:48741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ehEet-0004N3-3L
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ehEek-00053H-S9
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:12:07 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:36179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ehEek-00052o-Mw
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:11:58 -0500
Received: by mail-it0-x22c.google.com with SMTP id n206so3778423itg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 05:11:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <alpine.BSF.2.21.1802011314580.39992@zero.eik.bme.hu>
Date: Thu, 1 Feb 2018 08:11:55 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <10A8BD0F-5070-41F9-975A-086460BFC995@gmail.com>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
	<20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
	<F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
	<20180131090310.e4jlhu7euyeompkh@sirius.home.kraxel.org>
	<655BB356-66E8-4AC4-8EC4-47E3E2DA6B36@gmail.com>
	<alpine.BSF.2.21.1802011314580.39992@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v5] cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org


> On Feb 1, 2018, at 7:16 AM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>=20
> On Wed, 31 Jan 2018, Programmingkid wrote:
>>>> Basically there is a array that acts as a check list. It checks off
>>>> keys that belong to the ungrab sequence as they are detected. Once =
a
>>>> non-ungrab key is detected, the check list is cleared. If all the
>>>> ungrab keys are detected the ungrab code is executed. This only
>>>> happens on keyup events. That way if Control-ALT were the ungrab =
keys,
>>>> sending Control-ALT-Delete to the guest is still possible because
>>>> these are the keys detected on the keyup event. The Delete key =
would
>>>> have cleared the check list. Daniel Berrange is the one I can thank
>>>> for this idea. He might be able to explain it better than me.
>>>=20
>>> Hmm, ok.
>>>=20
>>> Doing the same for gtk would basically imply to not use any toolkit
>>> support for hotkeys ...
>>>=20
>>> It'll also become more difficuilt if we use that for multiple =
hotkeys.
>>>=20
>>> But possibly we can share the code across all UIs, now that =
keycodemapdb
>>> is used by qemu.  So first translate the keycode from the UI toolkit =
to
>>> a QKeyCode, then feed that into shared hotkey detection code.
>>=20
>> Sounds like a good idea. I will be more than happy to help. My cocoa =
code
>> uses sets to implement keeping track of key presses. A set is a =
collection of data
>> that only allows for unique values. So no two items in a set can be =
the same
>> value. My patch uses cocoa's NSSet so the shared code would probably =
not be
>> able to use it. I don't currently know of an implementation of a set =
that is
>> in C and available for us to use, so we may have to implement it =
ourselves.
>=20
> I think we already depend on glib so maybe you could find something =
useful for this here:
>=20
> https://developer.gnome.org/glib/stable/glib-data-types.html
>=20
> Regards,
> BALATON Zoltan

Thanks BALATON for the help, but I didn't see anything that was a good =
fit for the patch.
