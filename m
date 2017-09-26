Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtjh-0002TG-Vc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtjd-0000Fv-Vi
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:33:33 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:55201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwtjd-0000Fg-QV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:33:29 -0400
Received: by mail-it0-x229.google.com with SMTP id e134so3734976ite.3
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:33:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-dVq+7uZJ-3SCyknGgmnVowWTmLPseuobbzmXfkZ3dQA@mail.gmail.com>
References: <CAACKNgWgNbvH_UV-nLUrcrN7F1jh9G2-ZAScm=Xv2OKhc6WyLQ@mail.gmail.com>
	<CAFEAcA_T+w4msJSKi2=zo899+uA5sRGVjiR-aoKXwCg5odp9qw@mail.gmail.com>
	<CAACKNgWbTjtFqV_Qv5aqWaVDxiu-D1Vf7+NvkBLrMzpQsz-BfA@mail.gmail.com>
	<CAFEAcA-dVq+7uZJ-3SCyknGgmnVowWTmLPseuobbzmXfkZ3dQA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2017 10:32:58 -0700
Message-ID: <CAKmqyKM5Y49xhjYNB4wuD95Zrd6m17JWaZHoJEqEvywpCkE+aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Support for ARM CP15 registers via GDB interface
 of qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Abhijit Ray Chaudhury <abhijit.ray.chaudhury@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Sep 22, 2017 at 8:14 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 September 2017 at 16:11, Abhijit Ray Chaudhury
> <abhijit.ray.chaudhury@gmail.com> wrote:
>> Hi Peter,
>>
>> Thanks for your prompt response. I have gone through target
>> description xml format for gdb
>> (https://sourceware.org/gdb//onlinedocs/gdb/ARM-Features.html#ARM-Features)
>> . I could not find a feature description matching cp15 registers.So
>> even if I implement some subset of it would gdb understand it ? Can I
>> randomly name SCTLR TTBR0 etc and gdb understand it ?
>
> Yes, that's the sort of question you'd need to investigate and
> answer to implement this feature :-)

If it helps your investigation we have a little bit of what you are
looking for implemented in our fork. You can see the XML that we
expose here: https://github.com/Xilinx/qemu/blob/master/gdb-xml/aarch64-el3.xml

Our GDB stub is pretty divergent though, we are working on trying to
improve it, but it's slow going.

Thanks,
Alistair

>
> thanks
> -- PMM
>
