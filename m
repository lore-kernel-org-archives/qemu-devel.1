Received: from eggs.gnu.org ([209.51.188.92]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEEw6-0002Bq-CL
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEEra-0002Pm-Bm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:10:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEEra-0002NS-1u
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:10:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so3426093wrd.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 08:10:09 -0700 (PDT)
References: <20190410045707.16923-1-philmd@redhat.com>
	<e52ff725-a297-5b3c-af7a-1df30baf464f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <94d17504-2366-c5c9-59ee-a958e9dc0b82@redhat.com>
Date: Wed, 10 Apr 2019 17:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <e52ff725-a297-5b3c-af7a-1df30baf464f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] roms: Correct the
 EDK2_BASETOOLS_OPTFLAGS variable description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 4/10/19 4:58 PM, Laszlo Ersek wrote:
> On 04/10/19 06:57, Philippe Mathieu-Daudé wrote:
>> In commit 1cab464136b4 we incorrectly described the
>> EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
>> options to the EDK2 build tools, but it only expands
>> the CFLAGS (not to the CPPFLAGS).
>> Update the description to be more accurate.
>>
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  roms/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/roms/Makefile b/roms/Makefile
>> index 1ff78b63bb3..d7fd6025e7c 100644
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>> @@ -120,8 +120,8 @@ build-efi-roms: build-pxe-roms
>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>  
>> -# Build scripts can pass compiler/linker flags to the EDK2 build tools
>> -# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
>> +# Build scripts can pass compiler/linker flags to the EDK2
>> +# build  tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
>>  # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
>>  #
>>  # Example:
>>
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Please noone submit a pull request with this patch (for 4.1) until my
> edk2 bundling series is merged; as this one will likely introduce
> another contextual conflict, and I'd *really* like to avoid another
> rebase on my end, due to such an issue.

Thanks for the review. I'll rebase it on top of your 'bundle edk2
platform firmware with QEMU' v4 and resend (later). Feel free to include
it on top of your pullreq.

Regards,

Phil.
