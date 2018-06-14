Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTLjh-0002mt-T7
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTLjg-0006wS-VL
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:27:57 -0400
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-10-git-send-email-eric.auger@redhat.com>
	<8bf1bccc-b32a-9982-6123-b644c41a96d3@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <33a3fa10-bf1a-45cd-73bd-403cbd8d4792@redhat.com>
Date: Thu, 14 Jun 2018 08:27:46 +0200
MIME-Version: 1.0
In-Reply-To: <8bf1bccc-b32a-9982-6123-b644c41a96d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 9/9] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: wei@redhat.com, drjones@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com

Hi Laszlo,

On 06/13/2018 11:05 PM, Laszlo Ersek wrote:
> On 06/13/18 10:48, Eric Auger wrote:
> 
>> PATCH: merge of ECAM and VCPU extension
>> - Laszlo reviewed the ECAM changes but I dropped his R-b
>>   due to the squash
> 
> Was there any particular reason why the previous patch set (with only
> the ECAM enlargement) couldn't be merged first? To be honest I'm not
> super happy when my R-b is dropped for non-technical reasons; it seems
> like wasted work for both of us.
> 
> Obviously if there's a technical dependency or some other reason why
> committing the ECAM enlargement in separation would be *wrong*, that's
> different. Even in that case, wouldn't it be possible to keep the
> initial virt-3.0 machtype addition as I reviewed it, and then add the
> rest in an incremental patch?

Sorry about that. My fear was about migration. We would have had 2 virt
3.0 machine models not supporting the same features. While bisecting
migration we could have had the source using the high mem ECAM and the
destination not supporting it. So I preferred to avoid this trouble by
merging the 2 features in one patch. However I may have kept your R-b
restricting its scope to the ECAM stuff.

Thanks

Eric
> 
> Thanks,
> Laszlo
> 
