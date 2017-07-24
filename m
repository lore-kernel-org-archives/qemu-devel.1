Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlKK-0001wA-4c
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlKG-0003yf-5o
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:55:44 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlKF-0003yI-Uh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:55:40 -0400
Received: by mail-qk0-x242.google.com with SMTP id d145so8600460qkc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:55:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-34-f4bug@amsat.org>
	<CAFEAcA-zk-PcOAeo_sshBi9iPc=zF9SD=38Zsx1hf1YwQJYT3w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28942e9b-13a6-ffd7-8b5f-abdf88ea8b99@amsat.org>
Date: Mon, 24 Jul 2017 18:55:34 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zk-PcOAeo_sshBi9iPc=zF9SD=38Zsx1hf1YwQJYT3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 33/35] configure: clang does
 not support -Wexpansion-to-defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 07/24/2017 06:22 PM, Peter Maydell wrote:
> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   configure | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 6b52e19ee3..48295aa1e6 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1582,8 +1582,12 @@ gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
>>   gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
>>   gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>>   gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>> -gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>> +gcc_flags="-Wno-initializer-overrides $gcc_flags"
>>   gcc_flags="-Wno-string-plus-int $gcc_flags"
>> +# clang does not support -Wexpansion-to-defined
>> +if ! echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
>> +    gcc_flags="-Wexpansion-to-defined $gcc_flags"
>> +fi
> 
> We already have a mechanism for testing that the warning
> flags we pass here are actually supported by the compiler
> (the cc_has_warning_flag() function, which we run on
> every flag in $gcc_flags). Why does -Wexpansion-to-defined
> need special casing?

Yeah no idea, it works with clang 3.9 but not 5.0, I didn't investigate 
further. I prefixed this patch 'RFC' to not consider it but provide it 
if someone wanted to reproduce the analysis. Maybe I should prefix it 
'XXX' next time or 'NOT FOR MERGE'.

Regards,

Phil.
