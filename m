Received: from eggs.gnu.org ([2001:4830:134:3::10]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVVp-0004or-AK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVVj-0006cX-G5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUVVj-0006c5-9x
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:01:47 -0400
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
	<1499438577-7674-3-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a092f4f6-a915-b4fc-a5ce-1241856c2e13@redhat.com>
Date: Mon, 10 Jul 2017 12:01:40 +0200
MIME-Version: 1.0
In-Reply-To: <1499438577-7674-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/11] memory: Document that the RAM MR
 initializers do not handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 07/07/2017 16:42, Peter Maydell wrote:
> @@ -522,6 +537,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
>   * @name: the name of the region.
>   * @size: size of the region.
>   * @ptr: memory to be mapped; must contain at least @size bytes.
> + *
> + * Note that this function does not do anything to cause the data in the
> + * RAM memory region to be migrated; that is the responsibility of the caller.

Perhaps add a note that it rarely makes sense for this function?

Paolo

>   */
>  void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>                                         struct Object *owner,
> -- 
