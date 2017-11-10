Received: from eggs.gnu.org ([2001:4830:134:3::10]:53314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCy6u-0001xu-Cb
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 20:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCy6t-0003Nz-82
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 20:27:56 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eCy6t-0003NV-1n
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 20:27:55 -0500
Received: by mail-wm0-x242.google.com with SMTP id z3so21227858wme.5
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 17:27:54 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA8JS+51wyEYKsaestz-ADijZqGpv4tCv1wvfpwfXBB6MA@mail.gmail.com>
References: <14c2a46a082a9e34d6cbd3aba0fb47e353850d0d.1510153659.git.alistair.francis@xilinx.com>
	<CAFEAcA8JS+51wyEYKsaestz-ADijZqGpv4tCv1wvfpwfXBB6MA@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 9 Nov 2017 17:27:23 -0800
Message-ID: <CAKmqyKOJ864t4MmRT1Jh29dASZ1-zYHwcJMbfzcqvWptnWWsCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] Makefile: Capstone: Add support for
 cross compile ranlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Thu, Nov 9, 2017 at 3:09 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 8 November 2017 at 15:10, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> When cross compiling QEMU for Windows we need to specify the cross
>> version of ranlib to avoid build errors when building capstone. This
>> patch ensures we use the same cross prefix on ranlib as other toolchain
>> components.
>>
>> This patch fixes this build error when building on RHEL (or Fedora) with
>> MinGW:
>> /scratch/jenkins_tmp/workspace/QEMU-BuildAll/label/ssw_rhel7/target/windows/build-windows/capstone/capstone.lib:
>> error adding symbols: Archive has no index; run ranlib to add one
>> collect2: error: ld returned 1 exit status
>> make: *** [qemu-io.exe] Error 1
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daud <f4bug@amsat.org>
>
> Something in your patch handling workflow seems to be
> breaking non-ASCII characters, and it has dropped the
> last character in Philippe's surname. It would be good
> if you could look into fixing this -- we have quite a
> few contributors whose names are not representable
> purely in ASCII.

I think it's the way that I copy lines into the patches. I'll be sure
to make sure I get all the characters next time. Thanks for pointing
it out.

Alistair

>
> thanks
> -- PMM
