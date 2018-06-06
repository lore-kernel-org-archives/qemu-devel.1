Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fQPMG-0004UA-Oy
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fQPMG-0008Bt-4W
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:43:36 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1fQPMF-0008Bc-VG
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:43:36 -0400
Received: by mail-ot0-x241.google.com with SMTP id q1-v6so5465360oth.13
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 20:43:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605172222-mutt-send-email-mst@kernel.org>
References: <1528206970-4815-1-git-send-email-xieyongji@baidu.com>
	<20180605172222-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 6 Jun 2018 11:43:34 +0800
Message-ID: <CAONzpcaaAeYCD3tWXGpa3hCYKdL5K9uSm1Xs4BU_9gaBS1hy=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vhost-user-blk: start vhost when guest
 kicks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, changpeng.liu@intel.com, qemu-devel@nongnu.org, chaiwen@baidu.com, nixun@baidu.com

On 5 June 2018 at 22:23, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jun 05, 2018 at 09:56:10PM +0800, Yongji Xie wrote:
>> Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs early")
>> kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This would cause
>> that those old guests fail to boot with vhost-user-blk device.
>>
>> To fix it, start vhost when guest kicks instead of waiting for .set_status().
>>
>> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
>> Signed-off-by: Chai Wen <chaiwen@baidu.com>
>> Signed-off-by: Ni Xun <nixun@baidu.com>
>
> Can we at least limit this to when virtio 1.0 has not
> been negotiated?
>

OK, I will limit this to when driver is v0.9.x and device is v1.0 so
we don't violate the spec.

Thanks,
Yongji
