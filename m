Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F21C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A892070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh7u5eIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A892070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHP6l-000169-5m
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHP5d-0000Bm-21
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHP5b-0006bc-KA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:46:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHP5b-0006aQ-Fr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585215973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyqfYHYIHhGIshtBljTvoynxBHZUL4wOuIRheeuAzUQ=;
 b=Eh7u5eIoHIdWOi7IBTo7YTV9atVuvYpi5bmnHhauEmeSTxxJdsg+Cs2KodPiviBTe0S1ai
 XG99K32D5ZpejhCuLBMln8irnEw+L6hXHOFb8LmfwQoP814UKkEyHtBrH786jzm0J8Iy2j
 8/xOIpIVVatO7unYPLI+EhzhpMqtplg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-S1BdD39uNxqo4axIUKfsng-1; Thu, 26 Mar 2020 05:46:12 -0400
X-MC-Unique: S1BdD39uNxqo4axIUKfsng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B7CF8F16D;
 Thu, 26 Mar 2020 09:46:02 +0000 (UTC)
Received: from [10.72.13.193] (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE5CE10002A5;
 Thu, 26 Mar 2020 09:45:51 +0000 (UTC)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW3F1ZXN0aW9uXXZob3N0LXVzZXI6IGF0dW8gZml4?=
 =?UTF-8?Q?_network_link_broken_during_migration?=
To: "yangke (J)" <yangke27@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0CC1E03725E48D478F815032182740230A42A312@DGGEMM532-MBS.china.huawei.com>
 <47abadbd-c559-1900-f3b1-3697f9e7c0b5@redhat.com>
 <0CC1E03725E48D478F815032182740230A42C15B@DGGEMM532-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bb51d1b8-522d-0c05-46ec-102cb8a917f7@redhat.com>
Date: Thu, 26 Mar 2020 17:45:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0CC1E03725E48D478F815032182740230A42C15B@DGGEMM532-MBS.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/24 =E4=B8=8B=E5=8D=887:08, yangke (J) wrote:
>>> We find an issue when host mce trigger openvswitch(dpdk) restart in
>>> source host during guest migration,
>>
>> Did you mean the vhost-user netev was deleted from the source host?
>
> The vhost-user netev was not deleted from the source host. I mean that=EF=
=BC=9A
> in normal scenario, OVS(DPDK) begin to restart, then qemu_chr disconnect =
to OVS and link status is set to link down; OVS(DPDK) started, then qemu_ch=
r reconnect to OVS and link status is set to link up. But in our scenario, =
before qemu_chr reconnect to OVS, the VM migrate is finished. The link_down=
 of frontend was loaded from n->status in destination, it cause the network=
 in gust never be up again.


I'm not sure we should fix this in qemu.

Generally, it's the task of management to make sure the destination=20
device configuration is the same as source.

E.g in this case, management should bring up the link if re-connection=20
in source is completed.

What's more the qmp_set_link() done in vhost-user.c looks hacky which=20
changes the link status without the care of management.


>
> qemu_chr disconnect:
> #0  vhost_user_write (msg=3Dmsg@entry=3D0x7fff59ecb2b0, fds=3Dfds@entry=
=3D0x0, fd_num=3Dfd_num@entry=3D0, dev=3D0x295c730, dev=3D0x295c730)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost_user.c:239
> #1  0x00000000004e6bad in vhost_user_get_vring_base (dev=3D0x295c730, rin=
g=3D0x7fff59ecb510)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost_user.c:497
> #2  0x00000000004e2e88 in vhost_virtqueue_stop (dev=3Ddev@entry=3D0x295c7=
30, vdev=3Dvdev@entry=3D0x2ca36c0, vq=3D0x295c898, idx=3D0)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost.c:1036
> #3  0x00000000004e45ab in vhost_dev_stop (hdev=3Dhdev@entry=3D0x295c730, =
vdev=3Dvdev@entry=3D0x2ca36c0)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost.c:1556
> #4  0x00000000004bc56a in vhost_net_stop_one (net=3D0x295c730, dev=3Ddev@=
entry=3D0x2ca36c0)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/net/vhost_net.c:326
> #5  0x00000000004bcc3b in vhost_net_stop (dev=3Ddev@entry=3D0x2ca36c0, nc=
s=3D<optimized out>,=09total_queues=3D4)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/net/vhost_net.c:407
> #6  0x00000000004b85f6 in virtio_net_vhost_status (n=3Dn@entry=3D0x2ca36c=
0,=09status=3Dstatus@entry=3D7 '\a')
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/net/virtio_net.c:177
> #7  0x00000000004b869f in virtio_net_set_status (vdev=3D<optimized out>, =
status=3D<optimized out>)
>      at /usr/src/debug/qemu-kvm-2.8.1/hw/net/virtio_net.c:243
> #8  0x000000000073d00d in qmp_set_link (name=3Dname@entry=3D0x2956d40 "ho=
stnet0", up=3Dup@entry=3Dfalse, errp=3Derrp@entry=3D0x7fff59ecd718)
>      at net/net.c:1437
> #9  0x00000000007460c1 in net_vhost_user_event (opaque=3D0x2956d40, event=
=3D4) at net/vhost_user.c:217//qemu_chr_be_event
> #10 0x0000000000574f0d in tcp_chr_disconnect (chr=3D0x2951a40) at qemu_ch=
ar.c:3220
> #11 0x000000000057511f in tcp_chr_hup (channel=3D<optimized out>,=09cond=
=3D<optimized out>, opaque=3D<optimized out>) at qemu_char.c:3265
>
>
>>
>>> VM is still link down in frontend after migration, it cause the network=
 in VM never be up again.
>>>
>>> virtio_net_load_device:
>>>       /* nc.link_down can't be migrated, so infer link_down according
>>>        * to link status bit in n->status */
>>>       link_down =3D (n->status & VIRTIO_NET_S_LINK_UP) =3D=3D 0;
>>>       for (i =3D 0; i < n->max_queues; i++) {
>>>           qemu_get_subqueue(n->nic, i)->link_down =3D link_down;
>>>       }
>>>
>>> guset:               migrate begin -----> vCPU pause ---> vmsate load -=
--> migrate finish
>>>                                       ^                ^               =
 ^
>>>                                       |                |               =
 |
>>> openvswitch in source host:   begin to restart   restarting        star=
ted
>>>                                       ^                ^               =
 ^
>>>                                       |                |               =
 |
>>> nc in frontend in source:        link down        link down        link=
 down
>>>                                       ^                ^               =
 ^
>>>                                       |                |               =
 |
>>> nc in frontend in destination:   link up          link up          link=
 down
>>>                                       ^                ^               =
 ^
>>>                                       |                |               =
 |
>>> guset network:                    broken           broken           bro=
ken
>>>                                       ^                ^               =
 ^
>>>                                       |                |               =
 |
>>> nc in backend in source:         link down        link down        link=
 up
>>>                                       ^                ^               =
 ^
>>>                                       |                |               =
 |
>>> nc in backend in destination:    link up          link up          link=
 up
>>>
>>> The link_down of frontend was loaded from n->status, n->status is link
>>> down in source, so the link_down of frontend is true. The backend in
>>> destination host is link up, but the frontend in destination host is li=
nk down, it cause the network in gust never be up again until an guest cold=
 reboot.
>>>
>>> Is there a way to auto fix the link status? or just abort the migration=
 in virtio net device load?
>>
>> Maybe we can try to sync link status after migration?
>>
>> Thanks
>
> In extreme scenario, after migration the OVS(DPDK) in source may be still=
 not started.
>
>
> Our plan is to check the link state of backend when load the link_down of=
 frontend.
>       /* nc.link_down can't be migrated, so infer link_down according
>        * to link status bit in n->status */
> -    link_down =3D (n->status & VIRTIO_NET_S_LINK_UP) =3D=3D 0;
> +    if (qemu_get_queue(n->nic)->peer->info->type =3D=3D NET_CLIENT_DRIVE=
R_VHOST_USER) {
> +        link_down =3D (n->status & VIRTIO_NET_S_LINK_UP | !qemu_get_queu=
e(n->nic)->peer->link_down) =3D=3D 0;
> +    } else {
> +        link_down =3D (n->status & VIRTIO_NET_S_LINK_UP) =3D=3D 0;
> +    }
>       for (i =3D 0; i < n->max_queues; i++) {
>           qemu_get_subqueue(n->nic, i)->link_down =3D link_down;
>       }
>
> Is good enough to auto fix the link status?


I still think it's the task of management. Try sync status internally as=20
what vhost-user currently did may lead bugs.

Thanks


>
> Thanks


