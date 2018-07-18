Received: from eggs.gnu.org ([2001:4830:134:3::10]:45601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffs8H-0006kM-H9
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffs8C-0007DH-HZ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:29:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffs8C-0007Cb-9G
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:29:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id h3-v6so3429173wmb.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:28:59 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
	<20180711142819.GM31228@stefanha-x1.localdomain>
	<bc76dd27-434f-9a75-0afd-47049cc915d6@redhat.com>
	<20180718142357.GM21825@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00b4f8fe-b473-ac7a-4f13-9752aeef7062@redhat.com>
Date: Wed, 18 Jul 2018 21:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180718142357.GM21825@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 18/07/2018 16:23, Stefan Hajnoczi wrote:
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

So do you suggest to squash patch 6 into this one, so that a user of
QOSGraphObject exists already here?

Thanks,

Paolo
