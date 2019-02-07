Received: from eggs.gnu.org ([209.51.188.92]:48854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrLY-0001dh-Ny
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 16:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrLX-0007ks-RR
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 16:36:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grrLX-0007ef-E5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 16:36:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so1434918wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 13:36:27 -0800 (PST)
References: <20190207193605.25676-1-crosa@redhat.com>
	<20190207193605.25676-3-crosa@redhat.com>
	<eb52ed3a-e2fb-d5d2-5d7e-ceb41e8a7987@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae5fa4e8-24aa-4d00-8d74-21f6539dc59f@redhat.com>
Date: Thu, 7 Feb 2019 22:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <eb52ed3a-e2fb-d5d2-5d7e-ceb41e8a7987@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: fix qemu-img name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>

On 2/7/19 9:11 PM, Laurent Vivier wrote:
> On 07/02/2019 20:36, Cleber Rosa wrote:
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index ff55e2273e..c8fc1647fe 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1768,7 +1768,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>>    virglrenderer   virgl rendering support
>>    xfsctl          xfsctl support
>>    qom-cast-debug  cast debugging support
>> -  tools           build qemu-io, qemu-nbd and qemu-image tools
>> +  tools           build qemu-io, qemu-nbd and qemu-img tools
>>    vxhs            Veritas HyperScale vDisk backend support
>>    bochs           bochs image format support
>>    cloop           cloop image format support
>>
> 
> Fixes: c12d66aac1aa ("configure: add the missing help output for
> optional features")
> 
> Perhaps the list can be updated with qemu-edid, ivshmem-client and elf2dmp?

Good idea! Eventually the trivial@ maintainer is willing to fulfil your
request if he takes this patch :D

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

As it or with Laurent's suggestion:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
