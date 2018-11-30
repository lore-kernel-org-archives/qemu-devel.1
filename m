Received: from eggs.gnu.org ([2001:4830:134:3::10]:57847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpIT-0003Sw-18
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpIS-0005uD-DR
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:21:57 -0500
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-4-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a8a2197-4b50-0907-343b-29acfcf97da3@redhat.com>
Date: Fri, 30 Nov 2018 14:21:42 -0600
MIME-Version: 1.0
In-Reply-To: <20181130151712.2312-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] hw/smbios/smbios.c: Don't use
 load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 11/30/18 9:17 AM, Peter Maydell wrote:
> The load_image() function is deprecated, as it does not let the
> caller specify how large the buffer to read the file into is.
> Instead use load_image_size().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/smbios/smbios.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 920939454e7..04811279a08 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -982,7 +982,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>           header = (struct smbios_structure_header *)(smbios_tables +
>                                                       smbios_tables_len);
>   
> -        if (load_image(val, (uint8_t *)header) != size) {
> +        if (load_image_size(val, (uint8_t *)header, size) != size) {
>               error_setg(errp, "Failed to load SMBIOS file %s", val);
>               return;
>           }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
