Received: from eggs.gnu.org ([2001:4830:134:3::10]:58401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCxln-0005W6-2s
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCxli-00015m-3f
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:10:39 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:32662)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCxlg-0000XE-L0
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:10:33 -0400
References: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
	<20181017094406.4844-4-maozhongyi@cmss.chinamobile.com>
	<134b72ef-0f6a-dd71-e761-0d4ae23e31cf@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <92568c6c-620b-9e9e-5b64-b3f39d91e1f8@cmss.chinamobile.com>
Date: Thu, 18 Oct 2018 10:10:12 +0800
MIME-Version: 1.0
In-Reply-To: <134b72ef-0f6a-dd71-e761-0d4ae23e31cf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] po/Makefile: Modern shell scripting
 (use $() insteadof ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, sw@weilnetz.de



On 10/17/18 5:54 PM, Thomas Huth wrote:
> On 2018-10-17 11:44, Mao Zhongyi wrote:
>> Various shell files contain a mix between obsolete ``
>> and modern $(); It would be nice to convert to using $()
>> everywhere.
>>
>> Cc: philmd@redhat.com
>> Cc: peter.maydell@linaro.org
>> Cc: thuth@redhat.com
>> Cc: sw@weilnetz.de
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   po/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/po/Makefile b/po/Makefile
>> index e47e262ee6..10605e8eb3 100644
>> --- a/po/Makefile
>> +++ b/po/Makefile
>> @@ -36,7 +36,7 @@ clean:
>>   
>>   install: $(OBJS)
>>   	for obj in $(OBJS); do \
>> -	    base=`basename $$obj .mo`; \
>> +	    base=$(basename $$obj .mo); \
> 
> You're changing a Makefile here, so you need to "escape" the "$" by
> doubling it:
> 
> 	base=$$(basename $$obj .mo); \

OK, I see your point.

Thanks,
Mao

> 
>   Thomas
> 
