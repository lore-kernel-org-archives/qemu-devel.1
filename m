Received: from eggs.gnu.org ([2001:4830:134:3::10]:54283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1ffqpr-0007bq-Ei
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1ffqpo-0006DP-AV
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:05:59 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1ffqpo-0006CS-2p
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:05:56 -0400
Received: by mail-ed1-x542.google.com with SMTP id t2-v6so4988129edr.5
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 11:05:55 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
	<20180711142819.GM31228@stefanha-x1.localdomain>
	<bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
	<20180718142357.GM21825@stefanha-x1.localdomain>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <ec4802c2-bd87-f522-d43d-07c1d76aa3cf@gmail.com>
Date: Wed, 18 Jul 2018 20:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180718142357.GM21825@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org



On 07/18/2018 04:23 PM, Stefan Hajnoczi wrote:
> On Wed, Jul 11, 2018 at 04:58:41PM +0200, Paolo Bonzini wrote:
>> On 11/07/2018 16:28, Stefan Hajnoczi wrote:
>>>> + *
>>>> + * QOSGraphObject also provides a destructor, used to deallocate the
>>>> + * after the test has been executed.
>>>> + */
>>>> +struct QOSGraphObject {
>>>> +    /* for produces, returns void * */
>>>> +    QOSGetDriver get_driver;
>>> Unused?
>>>
>>>> +    /* for contains, returns a QOSGraphObject * */
>>>> +    QOSGetDevice get_device;
>>> Unused?
>> What is unused?
> Neither of these fields are used in this patch.  Please introduce them
> in the first patch that actually uses them.  This way code review can
> proceed linearly and it also prevents deadcode when just part of a patch
> series is merged or backported.
I'm sorry but at this point also sdhci.c, raspi2-machine.c and 
x86_64_pc-machine.c (patch 3-4-5) are not actually even compiled before 
qos-test.c (patch 6). Is that wrong too?
