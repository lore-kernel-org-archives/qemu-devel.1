Received: from eggs.gnu.org ([209.51.188.92]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtZL3-0005do-KM
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtZ6s-0002bx-2K
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:32:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtZ6r-0002ZQ-QY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:32:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so3192118wmh.4
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 06:32:29 -0800 (PST)
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
	<0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
	<0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
	<bf1a6632-594c-cf05-e4cd-c70d9e1e2fbe@linux.ibm.com>
	<f7b55eef-68da-ef50-b060-05e86f659903@redhat.com>
	<113577fd-71c8-972f-b658-635d3decd62d@linux.ibm.com>
	<7339d38a-74b7-bac8-677f-a27b88226453@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3db74195-1a59-29c6-51e7-80802028def5@redhat.com>
Date: Tue, 12 Feb 2019 15:32:26 +0100
MIME-Version: 1.0
In-Reply-To: <7339d38a-74b7-bac8-677f-a27b88226453@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 2/12/19 2:43 PM, Liam Merwick wrote:
> On 12/02/2019 13:27, Stefan Berger wrote:
>> On 2/12/19 7:31 AM, Philippe Mathieu-Daudé wrote:
>>> On 2/11/19 10:13 PM, Stefan Berger wrote:
>>>> On 2/11/19 3:09 PM, Liam Merwick wrote:
>>>>> On 11/02/2019 19:56, Stefan Berger wrote:
>>>>>> On 2/11/19 11:02 AM, Philippe Mathieu-Daudé wrote:
>>>>>>> On 2/11/19 4:03 PM, Liam Merwick wrote:
>>> [...]
>>>>>>>> -    printf("tpm_tis: %s length = %d\n", string, len);
>>>>>>>> +    printf("tpm_tis: %s length = %u\n", string, len);
>>>>>>> So here the format is '%zu'.
>>>>>>> However in code cleanup we try go get ride of printf() calls and
>>>>>>> replace them with trace points.
>>>>>>
>>>>>> This code is only used for debugging if DEBUG_TIS has been #defined.
>>>>>> No need to add tracing here.
>>>>> I'd come up the attached change (but that seems like overkill).
>>>>
>>>> I don't think we need tracing for this.
>>> So if you think the code is mature enough, let's remove the DEBUG calls!
>>>
>>> Else we prefer to convert DEBUG printf to trace events because (at
>>> least):
>>> - no need to recompile to enable debugging
>>> - when compiled with debugging, you don't mess with STDIO which can be
>>> used as a chardev backend.
>> Fine. Then I withdraw my reviewed-by.
> 
> 
> I don't see a way of removing the DEBUG calls without adding the
> overhead of a call to tpm_tis_show_buffer() each time even if tracing is
> not enabled (the 3 trace calls are interdependent and need a for loop).
> Is there any example of a trace point that calls a function that then
> does non-trivial printing?
> 
> I could send a v3 with the patch I attached previously with the 3 printf
> calls changed to trace points but still wrapped in 'if (DEBUG_TIS)' and
> optimised out in non-debug.

You can look at commit 56853498648.

Thanks!

Phil.
