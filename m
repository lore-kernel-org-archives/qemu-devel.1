Received: from eggs.gnu.org ([2001:4830:134:3::10]:57406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7mmE-0007Oc-Pm
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7mm9-000887-OK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:48:54 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7mm9-000881-Kx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:48:49 -0400
Received: by mail-qt0-x243.google.com with SMTP id l39so10541251qtb.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 10:48:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-17-f4bug@amsat.org> <871srza9bi.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89ae857f-9dd8-6ed1-336f-748920a0f92c@amsat.org>
Date: Mon, 8 May 2017 14:48:46 -0300
MIME-Version: 1.0
In-Reply-To: <871srza9bi.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/23] shippable: do not initialize
 submodules automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On 05/08/2017 08:15 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> do it in the 'ci' target when needed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .shippable.yml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> index fa2d6a4e9b..b3cbca458c 100644
>> --- a/.shippable.yml
>> +++ b/.shippable.yml
>> @@ -1,4 +1,6 @@
>>  language: c
>> +git:
>> +   submodules: false
>>  env:
>>    global:
>>      - LC_ALL=C
>
> Maybe this should be merged with the next patch?

Ok.

> --
> Alex Bennée
>
