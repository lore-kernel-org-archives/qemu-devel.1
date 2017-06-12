Received: from eggs.gnu.org ([2001:4830:134:3::10]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dKUnW-000873-Cr
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dKUnV-0007ax-Jv
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:14:46 -0400
References: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
	<1497023553-18411-2-git-send-email-eric.auger@redhat.com>
	<87r2yplo5l.fsf@secure.mitica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5a97d277-58d7-84e3-97a3-a06837bd3459@redhat.com>
Date: Mon, 12 Jun 2017 21:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <87r2yplo5l.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/4] kvm-all: Pass an error object to
 kvm_device_access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: wei@redhat.com, peter.maydell@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, qemu-devel@nongnu.org, peterx@redhat.com, Vijaya.Kumar@cavium.com, qemu-arm@nongnu.org, christoffer.dall@linaro.org, zhaoshenglong@huawei.com, dgilbert@redhat.com, eric.auger.pro@gmail.com

Hi Juan,

On 12/06/2017 08:23, Juan Quintela wrote:
> Eric Auger <eric.auger@redhat.com> wrote:
>> In some circumstances, we don't want to abort if the
>> kvm_device_access fails. This will be the case during ITS
>> migration, in case the ITS table save/restore fails because
>> the guest did not program the vITS correctly. So let's pass an
>> error object to the function and return the ioctl value. New
>> callers will be able to make a decision upon this returned
>> value.
>>
>> Existing callers pass &error_abort which will cause the
>> function to abort on failure.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thank you for the review!

Eric
> 
