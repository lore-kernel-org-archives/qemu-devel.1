Received: from eggs.gnu.org ([2001:4830:134:3::10]:57761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHTht-0005Vk-HG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHThn-0006s1-PH
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:00:45 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:38874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHThn-0006rM-KM
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:00:39 -0500
Received: by mail-ot0-x236.google.com with SMTP id b49so13341394otj.5
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 04:00:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e52d9ae1-50df-8484-4476-e7b9d6ea0d76@weilnetz.de>
References: <20171116163732.31584-1-sw@weilnetz.de>
	<e52d9ae1-50df-8484-4476-e7b9d6ea0d76@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Nov 2017 12:00:17 +0000
Message-ID: <CAFEAcA8e82pfBOA1WLqPV9MonCsoNge_p1LxPwzL=rGCmHiMsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11] Fix build of console and GUI
 executables for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 November 2017 at 21:04, Stefan Weil <sw@weilnetz.de> wrote:
> Am 16.11.2017 um 17:37 schrieb Stefan Weil:
>> It was broken by commit 8ecc89f6e792152496eccb684d6c8c48aba8027d which
>> moved the SDL linker flags from macro libs_softmmu to macro SDL_LIBS.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>
>> Peter, can you apply this fix directly, or do you need a pull request?
>>
>> Regards
>> Stefan
>>
>>  Makefile.target | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile.target b/Makefile.target
>> index e4244c188a..f9a9da7e7c 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -22,7 +22,7 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
>>  else
>>  # system emulator name
>>  QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
>> -ifneq (,$(findstring -mwindows,$(libs_softmmu)))
>> +ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
>>  # Terminate program name with a 'w' because the linker builds a windows executable.
>>  QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
>>  $(QEMU_PROG): $(QEMU_PROGW)
>
>
> The fix missed v2.11.0-rc2. Can it be applied before v2.11.0-rc3?

Sure, I've put it on my list. In general though, just cc'ing
me on patches is not guaranteed to get my attention, as I
more or less ignore whether I'm cc'd or not as I scan
subject lines. Sending a pull request is the best way to
guarantee getting something to my attention to be applied;
pull requests are the mechanism for allowing me to ignore
patches related to all the parts of QEMU I don't care
about, by delegating them to somebody else :-)

thanks
-- PMM
