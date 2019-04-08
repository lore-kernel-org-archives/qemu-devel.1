Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E6BC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 07:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCC420880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 07:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCC420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDOLg-0005V1-Qv
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 03:05:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hDOKS-0004n3-Ev
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 03:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hDOEe-00045N-R7
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hDOEe-00043P-Fw
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:58:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 582D6308FC22;
	Mon,  8 Apr 2019 06:51:38 +0000 (UTC)
Received: from [10.72.12.140] (ovpn-12-140.pek2.redhat.com [10.72.12.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96B7F5D9C9;
	Mon,  8 Apr 2019 06:51:34 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190325035613.18192-1-jasowang@redhat.com>
	<20190325074939-mutt-send-email-mst@kernel.org>
	<92955c79-8389-85d5-cc1a-545c35aceb74@redhat.com>
	<20190326084809-mutt-send-email-mst@kernel.org>
	<54169022-3b92-a49b-88b9-076e64a22e10@redhat.com>
	<20190401093414-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <df4ab625-501f-c5f8-9b61-e210974f52fd@redhat.com>
Date: Mon, 8 Apr 2019 14:51:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401093414-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 08 Apr 2019 06:51:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 RFT] vhost_net: don't set backend for
 the uninitialized virtqueue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yuri.benditovich@daynix.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408065133.hqNmybfnJMt5LRfLsEC7-7pZBYs3qopMEWmtiszXBcA@z>


On 2019/4/1 =E4=B8=8B=E5=8D=889:44, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2019 at 10:27:01AM +0800, Jason Wang wrote:
>> On 2019/3/26 =E4=B8=8B=E5=8D=888:49, Michael S. Tsirkin wrote:
>>> On Tue, Mar 26, 2019 at 02:59:19PM +0800, Jason Wang wrote:
>>>> On 2019/3/25 =E4=B8=8B=E5=8D=888:32, Michael S. Tsirkin wrote:
>>>>> On Mon, Mar 25, 2019 at 11:56:13AM +0800, Jason Wang wrote:
>>>>>> We used to set backend unconditionally, this won't work for some
>>>>>> guests (e.g windows driver) who may not initialize all virtqueues.=
 For
>>>>>> kernel backend, this will fail since it may try to validate the ri=
ngs
>>>>>> during setting backend.
>>>>>>
>>>>>> Fixing this by simply skipping the backend set when we find desc i=
s
>>>>>> not ready.
>>>>>>
>>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>>> ---
>>>>>>     hw/net/vhost_net.c | 15 +++++++++++++++
>>>>>>     1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>>>>> index be3cc88370..04fd924d15 100644
>>>>>> --- a/hw/net/vhost_net.c
>>>>>> +++ b/hw/net/vhost_net.c
>>>>>> @@ -221,6 +221,7 @@ static int vhost_net_start_one(struct vhost_ne=
t *net,
>>>>>>                                    VirtIODevice *dev)
>>>>>>     {
>>>>>>         struct vhost_vring_file file =3D { };
>>>>>> +    hwaddr a;
>>>>>>         int r;
>>>>>>         net->dev.nvqs =3D 2;
>>>>>> @@ -244,6 +245,13 @@ static int vhost_net_start_one(struct vhost_n=
et *net,
>>>>>>             qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
>>>>>>             file.fd =3D net->backend;
>>>>>>             for (file.index =3D 0; file.index < net->dev.nvqs; ++f=
ile.index) {
>>>>>> +            a =3D virtio_queue_get_desc_addr(dev,
>>>>>> +                                           net->dev.vq_index +
>>>>>> +                                           file.index);
>>>>>> +            if (a =3D=3D 0) {
>>>>>> +                /* Queue might not be ready for start */
>>>>>> +                continue;
>>>>>> +            }
>>>>>>                 r =3D vhost_net_set_backend(&net->dev, &file);
>>>>>>                 if (r < 0) {
>>>>>>                     r =3D -errno;
>>>>>> @@ -256,6 +264,13 @@ fail:
>>>>>>         file.fd =3D -1;
>>>>>>         if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
>>>>>>             while (file.index-- > 0) {
>>>>>> +            a =3D virtio_queue_get_desc_addr(dev,
>>>>>> +                                           net->dev.vq_index +
>>>>>> +                                           file.index);
>>>>>> +            if (a =3D=3D 0) {
>>>>>> +                /* Queue might not be ready for start */
>>>>>> +                continue;
>>>>>> +            }
>>>>>>                 int r =3D vhost_net_set_backend(&net->dev, &file);
>>>>>>                 assert(r >=3D 0);
>>>>>>             }
>>>>> I think we want an API that explicitly says "queue is enabled".
>>>>> For 0.X it will return !!addr. For 1.X it will return enabled.
>>>> For 1.x, desc.addr won't be set until queue_enabled is set through
>>>> virtio_queue_set_vrings(). And it looks to me ccw did something simi=
lar of
>>>> CMD_SET_VQ.
>>>>
>>>> So we're ok actually?
>>>>
>>>> Thanks
>>>>
>>> OK maybe but why can't we use an explicit API?
>>> 0.X can use addr !=3D 0 trick since there's no queue_enabled.
>>>
>> If I understand correctly, you want something similar to what V1 did? =
A bus
>> specific queue_enable() method.
>>
>> Thanks
> For now all I am asking for is simply:
> 	virtio_queue_is_enabled() {
> 		/* desc is only set when queue is enabled */
> 		return vdev->vq[n].vring.desc !=3D 0;
> }
>
> and then we can look at moving the enabled flag into
> struct VRing longer term.
>
>

Ok, let me post V3.

Thanks


