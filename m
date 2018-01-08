Received: from eggs.gnu.org ([2001:4830:134:3::10]:39986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYWHU-0002xl-Gs
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYWHT-0007Qs-CB
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:11:56 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYWHT-0007QN-8T
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:11:55 -0500
Received: by mail-ot0-x243.google.com with SMTP id 5so1059795oth.8
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 04:11:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228082006.xvmw6y4oxkcadenv@hawk.localdomain>
References: <1514423680-11132-1-git-send-email-zhaoshenglong@huawei.com>
	<20171228082006.xvmw6y4oxkcadenv@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 12:11:34 +0000
Message-ID: <CAFEAcA918ynH_zcQ21oRNfrRkbS_OJTbS3u-mCP22cMrr_uwBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Andrew Jones <drjones@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 28 December 2017 at 08:20, Andrew Jones <drjones@redhat.com> wrote:
> On Thu, Dec 28, 2017 at 09:14:40AM +0800, Shannon Zhao wrote:
>> From: Zhaoshenglong <zhaoshenglong@huawei.com>
>>
>> acpi_data_push uses g_array_set_size to resize the memory size. If there
>> is no enough contiguous memory, the address will be changed. If we use
>> the old value, it will assert.
>> qemu-kvm: hw/acpi/bios-linker-loader.c:214: bios_linker_loader_add_checksum:
>> Assertion `start_offset < file->blob->len' failed.`
>>
>> This issue only happens in building SRAT table now but here we unify the
>> pattern for other tables as well to avoid possible issues in the future.
>>
>> Signed-off-by: Zhaoshenglong <zhaoshenglong@huawei.com>
>> ---
>> v3: unify the pattern for MCFG
>> v2: update the commit message according to Andrew's comments
>> ---
>>  hw/arm/virt-acpi-build.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks; applied to target-arm.next.

-- PMM
