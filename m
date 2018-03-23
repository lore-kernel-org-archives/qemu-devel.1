Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezMqx-0002Fh-Pa
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezMqw-0000zI-Lt
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:35:31 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezMqw-0000yo-BL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:35:30 -0400
Received: by mail-ot0-x243.google.com with SMTP id t2-v6so13251391otj.4
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 06:35:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323074808.eyxeqaqyuz5sm743@hawk.localdomain>
References: <20180322212318.7182-1-wei@redhat.com>
	<20180323074808.eyxeqaqyuz5sm743@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 13:35:09 +0000
Message-ID: <CAFEAcA9jLpBOLn53S_r_UAuzVAifZ8=GdKqo3=UkSee0eTuYgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 23 March 2018 at 07:48, Andrew Jones <drjones@redhat.com> wrote:
> On Thu, Mar 22, 2018 at 04:23:18PM -0500, Wei Huang wrote:
>> Instead of using "1.0" as the system version of SMBIOS, we should use
>> mc->name for mach-virt machine type to be consistent other architectures.
>> With this patch, "dmidecode -t 1" (e.g., "-M virt-2.12,accel=kvm") will
>> show:
>>
>>     Handle 0x0100, DMI type 1, 27 bytes
>>     System Information
>>             Manufacturer: QEMU
>>             Product Name: KVM Virtual Machine
>>             Version: virt-2.12
>>             Serial Number: Not Specified
>>             ...
>>
>> instead of:
>>
>>     Handle 0x0100, DMI type 1, 27 bytes
>>     System Information
>>             Manufacturer: QEMU
>>             Product Name: KVM Virtual Machine
>>             Version: 1.0
>>             Serial Number: Not Specified
>>             ...
>>
>> For backward compatibility, we allow older machine types to keep "1.0"
>> as the default system version.
>>
>> Signed-off-by: Wei Huang <wei@redhat.com>

> I don't think we need the compat code in this case. I used to pedantically
> recommend compat code for all guest visible changes, but after speaking
> with Igor about the policy for introducing compat code for ACPI table
> updates, I learned that we can relax a bit on a case by case basis. In
> this case I would recommend relaxing, but I won't insist, as the compat
> code is indeed the safest way to go.
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Applied to target-arm.next, thanks.

-- PMM
