Received: from eggs.gnu.org ([209.51.188.92]:38349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyan122@huawei.com>) id 1h18Hr-0005e4-P5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyan122@huawei.com>) id 1h18He-0003HF-I2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:30:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2180 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangyan122@huawei.com>)
	id 1h18Hc-00026u-JL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:30:53 -0500
References: <b9bd74df-62a0-5c1e-c356-b7cc641822ab@huawei.com>
	<20190226101158.4bc3c88b@bahia.lan>
From: wangyan <wangyan122@huawei.com>
Message-ID: <51874464-caac-e5d7-8369-90f8a110c05f@huawei.com>
Date: Tue, 5 Mar 2019 19:28:37 +0800
MIME-Version: 1.0
In-Reply-To: <20190226101158.4bc3c88b@bahia.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Several questions about " [PATCH v3 0/5]
 virtio-9p: hotplug and migration support"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

I am very happy for your reply. 

I am very interested in your old WIP and want to take a look. 

Our project still use 9pfs, and it needs to live migrate the
device while it is being used by the guest, is there any advice
for us to make it come true or any WIP about this? 


On 2019/2/26 17:11, Greg Kurz wrote:
> On Tue, 26 Feb 2019 11:17:16 +0800
> wangyan <wangyan122@huawei.com> wrote:
>
>> Dear Kurz,
>>
>> Good day.
>>
>> This is Yan Wang from china. Glad to contact with you.
>>
> Hi Yan Wang,
>
>> I found your patch "[Qemu-devel] [PATCH v3 0/5] virtio-9p: hotplug and migration support" on the internet. Recently, our project need to use the feature of 9pfs living migration, and I want to know if you have the plan to merge the patch to the master branch of qemu, or do you have any other plans about the migration feature?
>>
> AFAIK some of these patches have already been merged.
>
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=4652f1640e029e1f2433fa77ba6af285c7cd923a
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=6cecf093735f2e5af7d0e29d957350320044e354
>
> These are enough to live-migrate a quiescent virtio-9p device, ie,
> only if the 9p filesystem is NOT mounted in the guest.
>
> If your need is to live migrate the device while it is being used by
> the guest, then this is a different story. Basically, this requires
> to quiesce the device so that its state can be captured. Also, some
> state belongs to the host and maybe hard to capture/migrate. For
> example, if the guest opens a file, write some data in it, unlinks the
> file but keeps the fd, it expects to be able to read the same data
> back, even after migration to some other host system.
>
> 9pfs is no longer a priority for anyone in the industry. I have no
> plan to make this go forward, an not much time to work on it. But
> if you want to have a look, I guess I can share some old WIP I have
> somewhere.
>
>> Sincerely,
>>
>> Yan Wang
>>
> Cheers,
>
> --
> Greg
>
> .
>
