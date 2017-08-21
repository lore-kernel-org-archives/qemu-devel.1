Received: from eggs.gnu.org ([2001:4830:134:3::10]:36665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1djpF1-0004Ue-AT
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1djpEy-0002dA-36
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1djpEx-0002bZ-QH
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:07:48 -0400
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com> <874lt1587y.fsf@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ad0f6973-af7e-61ba-c2da-3bb934eb63b7@redhat.com>
Date: Mon, 21 Aug 2017 18:07:39 +0200
MIME-Version: 1.0
In-Reply-To: <874lt1587y.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 08/21/17 16:03, Alex Benn=C3=A9e wrote:
>=20
> Gerd Hoffmann <kraxel@redhat.com> writes:
>=20
>> On Mon, 2017-08-07 at 18:51 +0200, Laszlo Ersek wrote:
>>> On 08/07/17 16:40, Peter Maydell wrote:
>>>> On 7 August 2017 at 15:31, Igor Mammedov <imammedo@redhat.com>
>>>> wrote:
>>>>> As I recall there were issues with FAT driver licensing in edk2,
>>>>> but I've heard there were some changes in that regard.
>>>>>
>>>>> Is there any other reasons why we are not putting subj.
>>>>> in QEMU tree like we do with SeaBIOS and other roms?
>>>>
>>>> I suspect the primary answer is "nobody who's willing to
>>>> maintain, test and update the resulting binary blobs has
>>>> stepped forward to say they want to do so" :-)
>>>>
>>>> (I think that shipping them in the QEMU tree would be
>>>> nice but is principally a convenience for our direct
>>>> users, since distros are going to want to build their
>>>> own ROM blobs from source anyway.)
>>>
>>> I agree that OVMF and ArmVirtQemu firmware binaries (and matching
>>> varstore templates, likely compressed) should be bundled with QEMU.
>>> There are no license-related reasons left that would prevent this.
>>>
>>> Please let us discuss this when Gerd returns from vacation. (CC'ing
>>> Gerd.)
>>
>> slighly oldish wip branch:
>> https://www.kraxel.org/cgit/qemu/log/?h=3Dwork/edk2
>>
>> Related question (as the edk2 blobs are pretty big):  Do we want commi=
t
>> this to the qemu repo directly?   Or should we create a qemu-firmware
>> repo for the precompiled blobs and hook it up as submodule?
>=20
> How big?

The ArmVirtQemu firmware binary, and its matching varstore template,
need to be padded to 64MB each, after the edk2 build process completes,
before the fw binary, and a variable store created from the varstore
template, can be passed to QEMU.

So, "pretty big".

Thanks
Laszlo

> Things like github tend to get picky with blobs over 50Mb and
> git isn't really set-up for large binary bits hence things like git-lfs=
.
> Unfortunately there seems to be multiple solutions to the blobs in git
> problem.
>=20
> We should also take some care to reproducibility so they can be updated
> by someone other than the original author.
>=20
>>
>> cheers,
>>   Gerd
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
