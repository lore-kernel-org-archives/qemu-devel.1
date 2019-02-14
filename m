Received: from eggs.gnu.org ([209.51.188.92]:35730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDdJ-0000T7-1n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDdH-0003sn-Cr
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:48:40 -0500
References: <20190208132112.31493-1-peter.maydell@linaro.org>
	<5b9474b0-7ce7-3efb-253e-4be7f1918281@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e1577929-4e16-9971-0686-5b3dadfc6ef7@vivier.eu>
Date: Thu, 14 Feb 2019 10:48:29 +0100
MIME-Version: 1.0
In-Reply-To: <5b9474b0-7ce7-3efb-253e-4be7f1918281@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: Make
 -Waddress-of-packed-member warnings be errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, patches@linaro.org

On 08/02/2019 14:33, Thomas Huth wrote:
> On 2019-02-08 14:21, Peter Maydell wrote:
>> We have now managed to eradicate all the places in the codebase
>> that triggered clang's -Waddress-of-packed-member warning. Remove
>> the compiler flag that exempted it from our usual -Werror policy.
>> This will prevent any new problematic code being added in future.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  configure | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index fbd0825488c..50ac5d90f2e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1881,7 +1881,6 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>>  gcc_flags="-Wno-string-plus-int $gcc_flags"
>> -gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
>>  # Note that we do not add -Werror to gcc_flags here, because that would
>>  # enable it for all configure tests. If a configure test failed due
>>  # to -Werror this would just silently disable some features,
> 
> Great!
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
