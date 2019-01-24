Received: from eggs.gnu.org ([209.51.188.92]:50726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmV8Z-0004w5-JE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmV8Y-00030b-6U
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:53:03 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gmV8Y-0002zc-0V
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:53:02 -0500
Received: by mail-pf1-x443.google.com with SMTP id g62so2208649pfd.12
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 18:53:01 -0800 (PST)
Date: Wed, 23 Jan 2019 18:52:59 -0800 (PST)
In-Reply-To: <CAFEAcA-yeQSbbhKXXJ0f961MJKC-v46DWgoaXcQUt64DZcdzqQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-2bd91def-4148-4180-bdbe-0be851d575e5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL] RISC-V Updates for 3.2, Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Mon, 14 Jan 2019 04:40:06 PST (-0800), Peter Maydell wrote:
> On Fri, 11 Jan 2019 at 18:06, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part2
>>
>> for you to fetch changes up to f7cdfa38f37e0985457ac03c3238861144a58b4c:
>>
>>   default-configs: Enable USB support for RISC-V machines (2019-01-09 17:34:10 -0800)
>>
>> ----------------------------------------------------------------
>> RISC-V Updates for 3.2, Part 2
>>
>> This patch set contains a handful of Michael's CSR-related cleanups,
>> which should allow us to proceed with more outstanding bug fixes that
>> depend on them.
>>
>> Additionally, there is a patch that turns on USB.  This works for me
>> when the kernel has the appropriate drivers (which will soon be in
>> defconfig) and I pass
>>
>>     -device usb-ehci
>>     -drive id=my_usb_disk,file=usbdisk.img,if=none,format=raw
>>     -device usb-storage,drive=my_usb_disk
>>
>> to QEMU.
>>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.

Thanks for the reminder :).  I have an account now so the update should be in 
there, I'll try to remember to include it along with the PR next time.
