Received: from eggs.gnu.org ([209.51.188.92]:50349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gwKbf-0006GE-0V
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gwKbd-0006xc-VO
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:39:42 -0500
References: <1550652953-24393-1-git-send-email-like.xu@linux.intel.com>
	<27254af5-b490-165f-8ca3-f60ab7642d72@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Message-ID: <b10cd713-1441-92fb-59e3-4b3162728070@linux.intel.com>
Date: Wed, 20 Feb 2019 13:39:33 +0800
MIME-Version: 1.0
In-Reply-To: <27254af5-b490-165f-8ca3-f60ab7642d72@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] doc: update .gitignore and fix typos for
 docs in tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 2019/2/20 11:09, Eric Blake wrote:
> On 2/20/19 2:55 AM, Like Xu wrote:
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> 
> This feels like two independent patches - the .gitignore change is
> different from typo fixes.
> 
> Actually, for .gitignore, you could just as easily do:
> 
> echo '*.patch' >> .git/info/exclude
> 
> and fix it so you never commit patch files locally, while still leaving
> them visible through 'git status' to other users.  I actually like
> knowing when I have stale patch files lying around, so that I can 'rm'
> them before creating my next patch batch and using 'git send-email
> *.patch' - but of course, I could just as easily add '!*.patch' to my
> .git/info/exclude to override the project default if we decide to go
> with your patch.

Adding '*.patch' to .gitignore is consistent with LKML tree.

> 
> 
>> +++ b/docs/colo-proxy.txt
>> @@ -41,7 +41,7 @@ Below is a COLO proxy ascii figure:
>>   |         |  +------------------------------------------------------+  |                        |        |                              |
>>   |netfilter|  |                       |                         |    |  |   netfilter            |        |                              |
>>   | +----------+ +----------------------------+                  |    |  |  +-----------------------------------------------------------+ |
>> -| |       |  |                       |      |        out       |    |  |  |                     |        |  filter excute order       | |
>> +| |       |  |                       |      |        out       |    |  |  |                     |        |  filter execute order       | |
> 
> You fixed the typo, but broke the whitespacing on this lineart. (twice)

Forgot to check format，thanks!

> 
> 
>> +++ b/docs/qemu-block-drivers.texi
>> @@ -632,7 +632,7 @@ qemu-system-i386 -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
>>   @end example
>>   
>>   
>> -Howto set up a simple iSCSI target on loopback and accessing it via QEMU:
>> +How to set up a simple iSCSI target on loopback and accessing it via QEMU:
> 
> While here, I would also: s/accessing/access/
> 
>> +++ b/docs/usb-storage.txt
>> @@ -16,7 +16,7 @@ too):
>>   
>>   
>>   Number two is the newer usb attached scsi transport.  This one doesn't
>> -automagically create a scsi disk, so you have to explicitly attach one
>> +automatically create a scsi disk, so you have to explicitly attach one
> 
> This one may be intentional, as a play on English words. But changing it
> may sound a bit more professional.

Nice play and let's keep it .

> 
> All your other typo fixes are good.  Looking forward to v2.
> 
