Received: from eggs.gnu.org ([2001:4830:134:3::10]:43196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eUTQI-0005jH-PU
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 03:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eUTQH-0002xm-VT
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 03:20:18 -0500
Date: Thu, 28 Dec 2017 09:20:06 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171228082006.xvmw6y4oxkcadenv@hawk.localdomain>
References: <1514423680-11132-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514423680-11132-1-git-send-email-zhaoshenglong@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3] Virt: ACPI: fix qemu assert due to
 re-assigned table data address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, lersek@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 28, 2017 at 09:14:40AM +0800, Shannon Zhao wrote:
> From: Zhaoshenglong <zhaoshenglong@huawei.com>
> 
> acpi_data_push uses g_array_set_size to resize the memory size. If there
> is no enough contiguous memory, the address will be changed. If we use
> the old value, it will assert.
> qemu-kvm: hw/acpi/bios-linker-loader.c:214: bios_linker_loader_add_checksum:
> Assertion `start_offset < file->blob->len' failed.`
> 
> This issue only happens in building SRAT table now but here we unify the
> pattern for other tables as well to avoid possible issues in the future.
> 
> Signed-off-by: Zhaoshenglong <zhaoshenglong@huawei.com>
> ---
> v3: unify the pattern for MCFG
> v2: update the commit message according to Andrew's comments
> ---
>  hw/arm/virt-acpi-build.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
 
Reviewed-by: Andrew Jones <drjones@redhat.com>
