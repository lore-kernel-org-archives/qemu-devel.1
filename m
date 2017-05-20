Received: from eggs.gnu.org ([2001:4830:134:3::10]:57068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBvA6-0003ve-5V
	for qemu-devel@nongnu.org; Fri, 19 May 2017 23:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBvA5-00039j-Ep
	for qemu-devel@nongnu.org; Fri, 19 May 2017 23:34:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516001150.11508-1-f4bug@amsat.org>
	<20170516001150.11508-2-f4bug@amsat.org>
	<79ae9877-afd9-50a7-c9f2-a12d294ff1ac@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb9fcebd-b201-4598-fc2f-41c6533e8b60@amsat.org>
Date: Sat, 20 May 2017 00:34:29 -0300
MIME-Version: 1.0
In-Reply-To: <79ae9877-afd9-50a7-c9f2-a12d294ff1ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] coccinelle: fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 05/16/2017 11:35 AM, Eric Blake wrote:
> On 05/15/2017 07:11 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  scripts/coccinelle/return_directly.cocci | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Did you intend for this to be threaded with your other 'oslib: strip
> trailing '\n'...' patch? If so, where's the 0/2 cover letter and proper
> subject lines?

Hi Eric, I think I did a mistake in my command, I intended to generate 
the patches in the same branch but wanted to send them as unrelated 
(without cover). I didn't noticed while sending until your remark, I'll 
double-check next time!

>
> At any rate,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

>
>>
>> diff --git a/scripts/coccinelle/return_directly.cocci b/scripts/coccinelle/return_directly.cocci
>> index 48680f2c2a..4cf50e75ea 100644
>> --- a/scripts/coccinelle/return_directly.cocci
>> +++ b/scripts/coccinelle/return_directly.cocci
>> @@ -1,4 +1,4 @@
>> -// replace 'R = X; return R;' with 'return R;'
>> +// replace 'R = X; return R;' with 'return X;'
>>  @@
>>  identifier VAR;
>>  expression E;
>>
>
