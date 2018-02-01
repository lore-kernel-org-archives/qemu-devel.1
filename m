Received: from eggs.gnu.org ([2001:4830:134:3::10]:53455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehDnC-0007N6-Qc
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehDn7-0001ng-Rw
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:16:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:50896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ehDn7-0001lg-HB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:16:33 -0500
Date: Thu, 1 Feb 2018 13:16:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <655BB356-66E8-4AC4-8EC4-47E3E2DA6B36@gmail.com>
Message-ID: <alpine.BSF.2.21.1802011314580.39992@zero.eik.bme.hu>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
	<20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
	<F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
	<20180131090310.e4jlhu7euyeompkh@sirius.home.kraxel.org>
	<655BB356-66E8-4AC4-8EC4-47E3E2DA6B36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Programmingkid <programmingkidx@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Wed, 31 Jan 2018, Programmingkid wrote:
>>> Basically there is a array that acts as a check list. It checks off
>>> keys that belong to the ungrab sequence as they are detected. Once a
>>> non-ungrab key is detected, the check list is cleared. If all the
>>> ungrab keys are detected the ungrab code is executed. This only
>>> happens on keyup events. That way if Control-ALT were the ungrab keys,
>>> sending Control-ALT-Delete to the guest is still possible because
>>> these are the keys detected on the keyup event. The Delete key would
>>> have cleared the check list. Daniel Berrange is the one I can thank
>>> for this idea. He might be able to explain it better than me.
>>
>> Hmm, ok.
>>
>> Doing the same for gtk would basically imply to not use any toolkit
>> support for hotkeys ...
>>
>> It'll also become more difficuilt if we use that for multiple hotkeys.
>>
>> But possibly we can share the code across all UIs, now that keycodemapdb
>> is used by qemu.  So first translate the keycode from the UI toolkit to
>> a QKeyCode, then feed that into shared hotkey detection code.
>
> Sounds like a good idea. I will be more than happy to help. My cocoa code
> uses sets to implement keeping track of key presses. A set is a collection of data
> that only allows for unique values. So no two items in a set can be the same
> value. My patch uses cocoa's NSSet so the shared code would probably not be
> able to use it. I don't currently know of an implementation of a set that is
> in C and available for us to use, so we may have to implement it ourselves.

I think we already depend on glib so maybe you could find something useful 
for this here:

https://developer.gnome.org/glib/stable/glib-data-types.html

Regards,
BALATON Zoltan
