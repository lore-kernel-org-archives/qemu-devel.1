Received: from eggs.gnu.org ([2001:4830:134:3::10]:59531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWgJ1-0002ji-CT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWgJ0-0001XA-KI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:55 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-2-git-send-email-gengdongjiu@huawei.com>
	<20171228132910.6594110a@igors-macbook-pro.local>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <0353f3c1-7863-0e93-82c7-adae36d6a0f8@huawei.com>
Date: Wed, 3 Jan 2018 18:29:20 +0800
MIME-Version: 1.0
In-Reply-To: <20171228132910.6594110a@igors-macbook-pro.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 1/9] ACPI: add some GHES structures and
 macros definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

Igor,
   sorry for my late response due to chines new year holiday.

On 2017/12/28 20:29, Igor Mammedov wrote:
>> +enum AcpiHestNotifyType {
>> +    ACPI_HEST_NOTIFY_POLLED = 0,
>> +    ACPI_HEST_NOTIFY_EXTERNAL = 1,
>> +    ACPI_HEST_NOTIFY_LOCAL = 2,
>> +    ACPI_HEST_NOTIFY_SCI = 3,
>> +    ACPI_HEST_NOTIFY_NMI = 4,
>> +    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0 */
> for stuff coming from spec comment should be something like this
> /* ACPI 1.0b: 16.2.5.3 Type 1 Opcodes Encoding: DefReturn */
> 
> i.e. concrete version, chapter/table
> otherwise it could be hard to find definition in huge spec 
Ok, got it. I am modifying it.
Appreciated for your detailed comments.
sure, it needs to be updated.

> 
>> +    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0 */
>> +    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0 */
>> +    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1 */
