Received: from eggs.gnu.org ([209.51.188.92]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guFFX-0002ji-1i
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guFFW-0006Jz-5x
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:32:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guFFV-0006IM-WF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:32:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so5850104wmh.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:32:13 -0800 (PST)
References: <20190212045721.28041-1-richard.henderson@linaro.org>
	<CAFEAcA_Oc4fTfcC-RFmV3zi7RnAbjDv=xWG8uPb_AT9buGnAcQ@mail.gmail.com>
	<46f22bec-d2ce-da2c-5aa0-c8572181f9ee@redhat.com>
	<CAFEAcA9yvA5Vs-x3mYEJgn4aB7vN108Q7ek7jAnoNZtJ=K=mDQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d9e4c0a-bc42-49d7-7d5a-b53cdd4be68f@redhat.com>
Date: Thu, 14 Feb 2019 12:32:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9yvA5Vs-x3mYEJgn4aB7vN108Q7ek7jAnoNZtJ=K=mDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/24] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 2/14/19 11:04 AM, Peter Maydell wrote:
> On Wed, 13 Feb 2019 at 18:40, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> What Clang version is that?
>>
>> I can not reproduce using:
>>
>> clang version 7.0.1 (Fedora 7.0.1-1.fc29)
> 
> OSX: Apple LLVM version 10.0.0 (clang-1000.11.45.5)> and Ubuntu bionic: clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)

I can not reproduce on Bionic:

$ clang --version
clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu

./configure --host-cc=clang \
            --cxx=clang++ \
            --cc=clang \
            --extra-cflags=-Werror=typedef-redefinition
Host C compiler   clang
C++ compiler      clang++
Objective-C compiler clang
QEMU_CFLAGS       -I/usr/include/pixman-1 -I$(SRC_PATH)/dtc/libfdt
-Werror  -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99
 -Werror=typedef-redefinition -Wno-error=address-of-packed-member
-Wno-string-plus-int -Wno-initializer-overrides -Wexpansion-to-defined
-Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs
-Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wold-style-definition -Wtype-limits
-fstack-protector-strong  -I/usr/include/p11-kit-1
-I/usr/include/libpng16 -I/usr/include/spice-server
-I/usr/include/spice-1 -I$(SRC_PATH)/capstone/include
[...]

$ make subdir-hppa-softmmu
[...]

$ hppa-softmmu/qemu-system-hppa --version
QEMU emulator version 3.1.50 (v3.1.0-1733-gcb82c5728c-dirty)

I don't have handy OSX setup except Travis, I'll see what I can do.

Regards,

Phil.
