Received: from eggs.gnu.org ([2001:4830:134:3::10]:38835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Y8y-0001pv-6q
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Y8v-0004iD-3q
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:23:32 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Y8u-0004i0-UM
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:23:29 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so1025391qkh.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:23:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-2-f4bug@amsat.org>
	<f5f5a368-0784-ca00-173d-b921a748ff12@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58cbaa6e-7657-e20e-9a69-efba892d9d15@amsat.org>
Date: Wed, 10 May 2017 17:23:24 -0300
MIME-Version: 1.0
In-Reply-To: <f5f5a368-0784-ca00-173d-b921a748ff12@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] coccinelle: add a script to optimize
 tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/10/2017 05:12 PM, Eric Blake wrote:
> On 05/10/2017 03:05 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  scripts/coccinelle/tcg_gen_extract.cocci | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
>>
>> diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
>> new file mode 100644
>> index 0000000000..4080f97cc7
>> --- /dev/null
>> +++ b/scripts/coccinelle/tcg_gen_extract.cocci
>> @@ -0,0 +1,26 @@
>> +// optimize TCG using extract op
>> +//
>> +// Copyright: (C) 2017 Philippe Mathieu-Daudé. GPLv2.
>
> Unless you provide a strong reason to the contrary, new files should be
> GPLv2+ rather than GPLv2-only.

Ok sorry! Wrong copy/paste mostly.

While here, I was unsure how to add this file in MAINTAINERS for 
get_maintainer.pl since it works on many target/ directories.

Stefan just merged one of your script you added under the "QObject" 
section, it makes sens.

But does it make sens to add this one in the "Common Code" section of 
"Tiny Code Generator (TCG)"? I don't think it is useful, it will only 
bother Richard Henderson.

Maybe we should add a "Coccinelle" entry with peoples willing to 
review/help those scripts... What do you think?

Regards,

Phil.
