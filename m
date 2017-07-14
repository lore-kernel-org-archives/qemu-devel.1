Received: from eggs.gnu.org ([2001:4830:134:3::10]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dVtWe-0002ZD-Dl
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dVtWd-0007wM-Jy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:52:28 -0400
References: <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com>
	<1499825297-20335-2-git-send-email-gengdongjiu@huawei.com>
	<20170713195930-mutt-send-email-mst@kernel.org>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <af366144-7508-98dc-d603-153de8de2e8c@huawei.com>
Date: Fri, 14 Jul 2017 13:51:53 +0800
MIME-Version: 1.0
In-Reply-To: <20170713195930-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] ACPI: Add new ACPI structures and
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: lersek@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, james.morse@arm.com, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

Michael,
  Thanks for your review.


On 2017/7/14 1:01, Michael S. Tsirkin wrote:
>> +typedef struct GhesState {
>> +    uint64_t ghes_addr_le;
>> +} GhesState;
>> +
>> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
>> +                            BIOSLinker *linker);
>> +void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_errors);
>> +bool ghes_update_guest(uint32_t notify, uint64_t error_physical_addr);
>> +#endif
> It's pretty unusual to add the function declaration but not the
> definition.
  you are right. I will move this declaration file to another patch.
  thanks. Laszlo also ever mentioned that.

> 
>> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
>> index afe4840..99c4041 100644
>> --- a/include/qemu/uuid.h
>> +++ b/include/qemu/uuid.h
>> @@ -44,6 +44,17 @@ typedef struct {
>>  
>>  #define UUID_NONE "00000000-0000-0000-0000-000000000000"
>>  
>> +#define UUID_BE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)        \
>> +{{{ ((a) >> 24) & 0xff, ((a) >> 16) & 0xff, ((a) >> 8) & 0xff, (a) & 0xff, \
>> +   ((b) >> 8) & 0xff, (b) & 0xff,                   \
>> +    ((c) >> 8) & 0xff, (c) & 0xff,                    \
>> +    (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) } } }
>> +
>> +/* Platform Memory, this is from UEFI 2.6 N.2.2 Section Descriptor */
> Drop "this is" from the sentence.
  OK.

> 
>> +#define UEFI_CPER_SEC_PLATFORM_MEM                   \
>> +    UUID_BE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
>> +    0xED, 0x7C, 0x83, 0xB1)
>> +
>>  void qemu_uuid_generate(QemuUUID *out);
>>  
>>  int qemu_uuid_is_null(const QemuUUID *uu);
