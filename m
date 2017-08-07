Received: from eggs.gnu.org ([2001:4830:134:3::10]:58203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1delFk-0000up-Ct
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1delFf-0007B4-Ii
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1delFf-00079m-CN
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:51:35 -0400
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
Date: Mon, 7 Aug 2017 18:51:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

On 08/07/17 16:40, Peter Maydell wrote:
> On 7 August 2017 at 15:31, Igor Mammedov <imammedo@redhat.com> wrote:
>> As I recall there were issues with FAT driver licensing in edk2,
>> but I've heard there were some changes in that regard.
>>
>> Is there any other reasons why we are not putting subj.
>> in QEMU tree like we do with SeaBIOS and other roms?
> 
> I suspect the primary answer is "nobody who's willing to
> maintain, test and update the resulting binary blobs has
> stepped forward to say they want to do so" :-)
> 
> (I think that shipping them in the QEMU tree would be
> nice but is principally a convenience for our direct
> users, since distros are going to want to build their
> own ROM blobs from source anyway.)

I agree that OVMF and ArmVirtQemu firmware binaries (and matching
varstore templates, likely compressed) should be bundled with QEMU.
There are no license-related reasons left that would prevent this.

Please let us discuss this when Gerd returns from vacation. (CC'ing Gerd.)

NB, upstream edk2 does not do releases. Similarly to iPXE -- edk2 is
production quality at all times! /me ducks ;)

Thanks
Laszlo
