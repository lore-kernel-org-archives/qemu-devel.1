Received: from eggs.gnu.org ([2001:4830:134:3::10]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7cKF-0004rx-AZ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7cKC-0005J9-5w
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:11:35 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:57067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7cKB-0005It-TO
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:11:32 -0400
Received: by mail-wm0-x241.google.com with SMTP id z3so6080984wme.5
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 00:11:31 -0700 (PDT)
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cefe3ea2-2d89-0cc9-cf23-07456ff66253@linaro.org>
Date: Thu, 26 Oct 2017 09:10:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/26/2017 08:07 AM, Peter Maydell wrote:
> On 25 October 2017 at 13:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Support for Capstone, plus an arm32 fix.
>>
>>
>> r~
>>
>>
>> The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)
>>
>> are available in the git repository at:
>>
>>   git://github.com/rth7680/qemu.git tags/pull-dis-20171025
>>
>> for you to fetch changes up to 383b90bc6a15f4b18ec34f9c0287b26f9a89fcb8:
>>
>>   disas: Add capstone as submodule (2017-10-25 11:55:21 +0200)
>>
>> ----------------------------------------------------------------
>> Capstone disassembler
> 
> 
> Hi. This failed to build for Windows:
> 
> make[1]: *** No rule to make target
> '/home/petmay01/linaro/qemu-for-merges/build/w32-new/capstone/libcapstone.a'.
> Stop.
> Makefile:399: recipe for target 'subdir-capstone' failed

Ug.  Ok, capstone is forcing the use of .lib for windows.

> 
> FreeBSD ar also prints a warning:
>   AR      libcapstone.a
> ar: warning: creating /root/qemu/build/all/capstone/libcapstone.a

Feh.  Capstone has no ARFLAGS variable.  So, no, I can't fix this without
actually modifying the sub-makefile.


r~
