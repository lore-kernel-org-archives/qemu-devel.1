Received: from eggs.gnu.org ([209.51.188.92]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErBE-0004kx-1S
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErBD-00007P-2j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hErBB-000065-78
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:04:59 -0400
References: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
	<20190412080249.x2b6utfnqh255msd@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed6c2780-302d-195a-42a0-d0c50152917a@redhat.com>
Date: Fri, 12 Apr 2019 10:04:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190412080249.x2b6utfnqh255msd@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] roms: assert if max rom size is
 less than the used size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, richard.henderson@linaro.org, stefanha@redhat.com

On 12/04/19 10:02, Stefano Garzarella wrote:
> On Thu, Apr 11, 2019 at 01:28:18PM +0200, Igor Mammedov wrote:
>> It would ensure that we would notice attempt to write beyond
>> the allocated buffer. In case of MemoryRegion backed ROM it's
>> the host buffer and the guest RAM otherwise.
>>
>> assert can be triggered with:
>>   dd if=/dev/zero of=/tmp/blob bs=63k count=1
>>   qemu-system-x86_64 `for  i in {1..33}; do echo -n " -acpitable /tmp/blob"; done`
>>
>> Fixes: (a1666142db acpi-build: make ROMs RAM blocks resizeable)
>>
>> Reported-by: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  hw/core/loader.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefano
> 

Queued, thanks.

Paolo
