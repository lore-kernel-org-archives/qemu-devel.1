Received: from eggs.gnu.org ([209.51.188.92]:48154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h18rY-0006d4-Vw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h18rW-0001XY-KV
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:08:00 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h18rU-0001G3-O6
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:07:57 -0500
Received: by mail-wm1-f46.google.com with SMTP id j125so2321697wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 04:07:55 -0800 (PST)
References: <20190304180920.21534-1-svens@stackframe.org>
	<20190304180920.21534-2-svens@stackframe.org>
	<2951e9ec-41c9-14cb-423c-4292c27965aa@redhat.com>
	<20190305071712.GA29106@t470p.stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a136fc7-66a9-8695-25d5-3b964f4f32e0@redhat.com>
Date: Tue, 5 Mar 2019 13:07:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190305071712.GA29106@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] lsi: use enum type for s->waiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 3/5/19 8:17 AM, Sven Schnelle wrote:
> Hi Philippe,
> 
> On Tue, Mar 05, 2019 at 12:18:01AM +0100, Philippe Mathieu-Daudé wrote:
>>>  
>>> +enum {
>>> +    LSI_NOWAIT,
>>
>> You forgot the comment for NOWAIT.
> 
> I thought LSI_NOWAIT is self-explaining, but will add that.
> 
>>>      int waiting;
>>
>> When a field is not used by migration, you can declare it as enum:
>>
>>        enum {
>>            LSI_NOWAIT = 0, /* SCRIPTS are running or stopped */
>>            LSI_WAIT_RESELECT = 1, /* Wait Reselect instruction has been
>> issued */
>>            LSI_DMA_SCRIPTS = 2, /* processing DMA from lsi_execute_script */
>>            LSI_DMA_IN_PROGRESS = 3, /* DMA operation is in progress */
>>        } waiting;
>>
>> This gives hints to the compiler about values to check.
> 
> But it is used by migration, so this doesn't apply here? I had a typedef enum before,
> but this doesn't compile.

Oh you are right, I didn't check... So with the updated comment:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Otherwise thanks for reviewing.
> 
> Regards
> Sven
> 
> 
