Received: from eggs.gnu.org ([209.51.188.92]:56832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hIx4x-0002Ff-Pk
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hIx4w-0000zt-TX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:11:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hIx4w-0000yo-Mq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:11:26 -0400
References: <20190409155831.18764-1-eric.auger@redhat.com>
	<20190412133111.028a9c6d.cohuck@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e4e20c42-5b6e-7072-8105-486650aaf95b@redhat.com>
Date: Tue, 23 Apr 2019 17:11:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190412133111.028a9c6d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] vfio/common: Introduce
 vfio_set_irq_signaling helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qemu-devel@nongnu.org, eric.auger.pro@gmail.com

Hi Cornelia

On 4/12/19 1:31 PM, Cornelia Huck wrote:
> On Tue,  9 Apr 2019 17:58:31 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> The code used to assign an interrupt index/subindex to an
>> eventfd is duplicated many times. Let's introduce an helper that
>> allows to set/unset the signaling for an ACTION_TRIGGER or
>> ACTION_UNMASK action.
> 
> I like that, and it looks like ccw can use the new function as well. (I
> can do a patch on top.)

Thanks! Yes, feel free to proceed with the ccw patch once this gets
merged.
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> This is a follow-up to
>> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
>> It looks to me that introducing vfio_set_irq_signaling() has more
>> benefits in term of code reduction and the helper abstraction
>> looks cleaner.
>> ---
>>  hw/vfio/common.c              |  61 +++++++++
>>  hw/vfio/pci.c                 | 224 ++++++++--------------------------
>>  hw/vfio/platform.c            |  55 +++------
>>  include/hw/vfio/vfio-common.h |   2 +
>>  4 files changed, 134 insertions(+), 208 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Thanks

Eric
> 
