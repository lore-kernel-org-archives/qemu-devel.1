Received: from eggs.gnu.org ([2001:4830:134:3::10]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fftlG-000502-30
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fftlC-000764-0d
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:13:26 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fftlB-00075G-Ly
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 17:13:21 -0400
Received: by mail-ed1-x541.google.com with SMTP id b20-v6so5405727edt.10
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 14:13:21 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
	<20180711142819.GM31228@stefanha-x1.localdomain>
	<bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
	<20180718142357.GM21825@stefanha-x1.localdomain>
	<00b4f8fe-b473-ac7a-4f13-9752aeef7062@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <8349f160-fcc8-610b-774e-b074d77f6d9f@gmail.com>
Date: Wed, 18 Jul 2018 23:13:18 +0200
MIME-Version: 1.0
In-Reply-To: <00b4f8fe-b473-ac7a-4f13-9752aeef7062@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/7] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org



On 07/18/2018 09:28 PM, Paolo Bonzini wrote:
> On 18/07/2018 16:23, Stefan Hajnoczi wrote:
>>>>> +struct QOSGraphObject {
>>>>> +    /* for produces, returns void * */
>>>>> +    QOSGetDriver get_driver;
>>>> Unused?
>>>>
>>>>> +    /* for contains, returns a QOSGraphObject * */
>>>>> +    QOSGetDevice get_device;
>>>> Unused?
>>> What is unused?
>> Neither of these fields are used in this patch.  Please introduce them
>> in the first patch that actually uses them.  This way code review can
>> proceed linearly and it also prevents deadcode when just part of a patch
>> series is merged or backported.
> So do you suggest to squash patch 6 into this one, so that a user of
> QOSGraphObject exists already here?
I think he's right, it makes no sense to have qos-graph as patch 6, it 
could go as patch 2, even though by that time no object/node exist yet.

Moreover, right now no file in patch 3-4-5 is actually compiled until 
patch 6, which is easily prone to errors in case of future edits (I too 
have this problem right now, when I need to modify sdhci.c and I'm 
forced to return to the branch head to compile), so adding it before 
would make things more clear.
> Thanks,
>
> Paolo
