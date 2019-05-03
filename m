Received: from eggs.gnu.org ([209.51.188.92]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMVzM-00034t-3h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMVzK-0003qE-2s
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:04:23 -0400
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ed0ddde0-3c6d-0afe-be9e-b56ecc479d18@vivier.eu>
Date: Fri, 3 May 2019 13:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 03/05/2019 12:34, Peter Maydell wrote:
> On Thu, 2 May 2019 at 19:58, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
>>
>>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>
>> for you to fetch changes up to f7c03a68b814254df414977ff299468fbf0fa1c0:
>>
>>   sockets: avoid string truncation warnings when copying UNIX path (2019-05-02 20:50:47 +0200)
>>
>> ----------------------------------------------------------------
>> Pull request trivial branch 2019-05-02
>>
>> ----------------------------------------------------------------
> 
> Markus's "Clean up includes" patch breaks 'make check' on
> big-endian hosts:
> cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all  i32_to_f16 i
> 64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128 >
>  int-to-float.out 2>&1 || (cat  int-to-float.out && exit 1;)
>>> Testing i32_to_f16, rounding near_even
> ^M372 tests total.
> ^M372 tests performed.
> In 372 tests, no errors found in i32_to_f16, rounding near_even.
>>> Testing i32_to_f16, rounding minMag
> [...]
> ^MErrors found in i32_to_f128:
> 1006FFFF  => +0000.000000000000401B006FFFF00000 .....
>         expected +401B.006FFFF000000000000000000000 .....
> ^M0001DDEB  => +0000.000000000000400FDDEB00000000 .....
>         expected +400F.DDEB000000000000000000000000 .....
> ^MFFF6FFFC  => +0000.000000000000C012200080000000 .....
>         expected -4012.2000800000000000000000000000 .....
> ^MFFFFFFF8  => +0000.000000000000C002000000000000 .....
>         expected -4002.0000000000000000000000000000 .....
> [etc]
> 
> (I had to bounce Markus' own pullreq from a week or
> so back because it had this patch in too and also failed
> for this reason.)

ok, I remove it and re-send the PR.

Thanks,
Laurent
