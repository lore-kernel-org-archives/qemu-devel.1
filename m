Received: from eggs.gnu.org ([209.51.188.92]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1go8X6-0008Dl-KQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1go8SD-0005pY-C5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:04:11 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
	<CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
	<5daf9f5e-cbda-8642-f4f6-46939fe223d1@redhat.com>
	<CAFEAcA_XxEXVcvR-3DMQsWpu8YRYspdDQ5SsrNKHnKjNw0YA-w@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b5f82ed4-151e-fcca-1719-aa68825e8b31@redhat.com>
Date: Mon, 28 Jan 2019 16:03:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_XxEXVcvR-3DMQsWpu8YRYspdDQ5SsrNKHnKjNw0YA-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Configuring pflash devices for OVMF
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 01/28/19 15:58, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 14:56, Laszlo Ersek <lersek@redhat.com> wrote:
>> Regarding OVMF, I kept the flash driver intentionally in the dark about
>> split vs. unified pflash, so OVMF will not care, as long as the same
>> GPAs behave the same as before.
>>
>> Regarding ArmVirtQemu, I'm not so sure. It think it already depends on
>> two separate pflash chips, through the DTB that QEMU exposes. So
>> unifying the chips (albeit with multiple regions) might actually confuse
>> the firmware.
> 
> "virt" is a funny case because there is no underlying hardware
> that we're trying to match. So it is whatever we say it is
> and we've said it's two separate pflash chips. We don't need
> to change that I think. (IIRC this is derived partly from
> OVMF usecase requirements and partly from the vexpress devboards
> having 2 flash chips.)

That sounds great, but in that case, would the work be justified in
practice, to introduce single-ship-with-multiple-regions, if only x86
put it to use (for OVMF), but arm/aarch64 "virt" would have to stick
with the current layout?

Thanks
Laszlo
