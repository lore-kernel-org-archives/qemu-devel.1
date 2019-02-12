Received: from eggs.gnu.org ([209.51.188.92]:42973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtXHH-0005Ht-4h
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtXDh-0005GB-IW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:31:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtXDb-00057M-SI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:31:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so2442316wrn.12
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 04:31:19 -0800 (PST)
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
	<0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
	<0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
	<bf1a6632-594c-cf05-e4cd-c70d9e1e2fbe@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f7b55eef-68da-ef50-b060-05e86f659903@redhat.com>
Date: Tue, 12 Feb 2019 13:31:15 +0100
MIME-Version: 1.0
In-Reply-To: <bf1a6632-594c-cf05-e4cd-c70d9e1e2fbe@linux.ibm.com>
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
To: Stefan Berger <stefanb@linux.ibm.com>, Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On 2/11/19 10:13 PM, Stefan Berger wrote:
> On 2/11/19 3:09 PM, Liam Merwick wrote:
>> On 11/02/2019 19:56, Stefan Berger wrote:
>>> On 2/11/19 11:02 AM, Philippe Mathieu-Daudé wrote:
>>>> On 2/11/19 4:03 PM, Liam Merwick wrote:
[...]
>>>>> -    printf("tpm_tis: %s length = %d\n", string, len);
>>>>> +    printf("tpm_tis: %s length = %u\n", string, len);
>>>> So here the format is '%zu'.
>>>> However in code cleanup we try go get ride of printf() calls and
>>>> replace them with trace points.
>>>
>>>
>>> This code is only used for debugging if DEBUG_TIS has been #defined.
>>> No need to add tracing here.
>>
>> I'd come up the attached change (but that seems like overkill).
> 
> 
> I don't think we need tracing for this.

So if you think the code is mature enough, let's remove the DEBUG calls!

Else we prefer to convert DEBUG printf to trace events because (at least):
- no need to recompile to enable debugging
- when compiled with debugging, you don't mess with STDIO which can be
used as a chardev backend.

Thanks,

Phil.
