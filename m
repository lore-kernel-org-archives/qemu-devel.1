Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm0au-0002C1-Pu
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm0ar-0002ox-LD
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:07:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm0ar-0002oM-Fp
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:07:09 -0500
References: <20170309152708.30635-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa186054-0b8c-924f-b30b-34ed92a83337@redhat.com>
Date: Thu, 9 Mar 2017 17:07:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170309152708.30635-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org



On 09/03/2017 16:27, Dr. David Alan Gilbert (git) wrote:
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
> + *        must be unique within any device
>   * @size: size of the region; any subregions beyond this size will be clipped
>   */
>  void memory_region_init(MemoryRegion *mr,
>                          struct Object *owner,
>                          const char *name,
>                          uint64_t size);

This one should not be necessary I guess?

Paolo
