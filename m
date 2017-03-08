Received: from eggs.gnu.org ([2001:4830:134:3::10]:42988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clZYn-00026g-0n
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clZYh-0000k1-Vv
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:15:13 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clZYh-0000hQ-SG
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:15:07 -0500
Received: by mail-qk0-x241.google.com with SMTP id o135so9803752qke.2
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 03:15:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170308105409.18183-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <173781ec-8811-c5ac-2660-b75de504fe82@amsat.org>
Date: Wed, 8 Mar 2017 08:15:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170308105409.18183-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org

On 03/08/2017 07:54 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The 'name' parameter to memory_region_init_* had been marked as debug
> only, however vmstate_region_ram uses it as a parameter to
> qemu_ram_set_idstr to set RAMBlock names and these form part of the
> migration stream.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/exec/memory.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 6911023..de8f69e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -307,7 +307,7 @@ struct MemoryRegionSection {
>   *
>   * @mr: the #MemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @size: size of the region; any subregions beyond this size will be clipped
>   */
>  void memory_region_init(MemoryRegion *mr,
> @@ -355,7 +355,7 @@ void memory_region_unref(MemoryRegion *mr);
>   * @ops: a structure containing read and write callbacks to be used when
>   *       I/O is performed on the region.
>   * @opaque: passed to the read and write callbacks of the @ops structure.
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @size: size of the region.
>   */
>  void memory_region_init_io(MemoryRegion *mr,
> @@ -474,7 +474,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>   *
>   * @mr: the #MemoryRegion to be initialized.
>   * @owner: the object that tracks the region's reference count
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @orig: the region to be referenced; @mr will be equivalent to
>   *        @orig between @offset and @offset + @size - 1.
>   * @offset: start of the section in @orig to be referenced.
> @@ -537,7 +537,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>   *
>   * @mr: the #MemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @size: size of the region.
>   */
>  static inline void memory_region_init_reservation(MemoryRegion *mr,
> @@ -558,7 +558,7 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
>   * @mr: the #MemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
>   * @ops: a function that translates addresses into the @target region
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @size: size of the region.
>   */
>  void memory_region_init_iommu(MemoryRegion *mr,
>
