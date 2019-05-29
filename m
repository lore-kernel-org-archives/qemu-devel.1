Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203AC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFEA21670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFEA21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVu7G-0007SN-MO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:39:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hVu6Q-00078S-D8
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hVu6P-0003oN-3p
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:38:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2238 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangjie88@huawei.com>)
	id 1hVu6L-0003mP-LA; Wed, 29 May 2019 04:38:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id E7EF8FCB05CEEA205CF5;
	Wed, 29 May 2019 16:38:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.25.93) by DGGEMS413-HUB.china.huawei.com
	(10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 29 May 2019
	16:37:57 +0800
To: Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
	<cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
	<f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
From: Jie Wang <wangjie88@huawei.com>
Message-ID: <8600e1e3-fd24-6e07-6951-f70b7a23f703@huawei.com>
Date: Wed, 29 May 2019 16:37:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.177.25.93]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] pr-manager-helper: fix pr
 process been killed when reconectting
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
Cc: eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Paolo and Michal:

Let me add some details about this problem.


reappear steps:

1. in Host, execute the following command many times quickly:

"ps aux|grep helper|grep -v grep|grep -v qemu-kvm|awk '{print $2}';ps aux=
|grep helper|grep -v grep|grep -v qemu-kvm|awk '{print $2}'|xargs -n1 kil=
l -9"

2. at the same time , execute PR command continuously in Guest

just execute step 1 and 2 for a moment, the problem will appear.


when the problem appeared:

1. qemu will initialize pr-helper and connect to it cyclically, but alway=
s failed because no running pr-helper process to connect.

2. libvirt will always waiting for connected event, but will never to sta=
rt new pr-helper process because not receive disconnect event.


I'm not found the best way to solve this problem, can you give me some su=
ggestion?


On 2019/5/29 15:33, Michal Privoznik wrote:
> On 5/28/19 7:45 PM, Paolo Bonzini wrote:
>> On 28/05/19 15:06, Jie Wang wrote:
>>> if pr-helper been killed and qemu send disconnect event to libvirt
>>> and libvirt started a new pr-helper process, the new pr-heleper
>>> been killed again when qemu is connectting to the new pr-helper,
>>> qemu will never send disconnect to libvirt, and libvirt will never
>>> receive connected event.
>>
>> I think this would let a guest "spam" events just by sending a lot PR
>> commands.=C2=A0 Also, as you said, in this case QEMU has never sent a
>> "connected" event, so I'm not sure why it should send a disconnection =
event.
>
> So pr manager is initialized on the first PR command and not when qemu =
is starting?
>
> If a user inside the guest could somehow kill pr-helper process in the =
host then yes, they could spam libvirt/qemu. But if a user from inside a =
guest can kill a process in the host that is much bigger problem than spa=
ming libvirt.
>
>>
>> Does libvirt monitor at all the pr-helper to check if it dies?=C2=A0 O=
r does
>> it rely exclusively on QEMU's events?
>
> Libvirt relies solely on QEMU's events. Just like with qemu process its=
elf, libvirt can't rely on SIGCHILD because the daemon might be restarted=
 which would reparent all qemu and pr-helper processes rendering libvirt =
wait for SIGCHILD useless.
>
> But there is an exception to this: when libvirt is spawning pr-helper i=
t does so by following these steps:
>
> 1) Try to acquire (lock) pidfile
> 2) unlink(socket)
> 3) spawn pr-helper process (this yields child's PID)
> 4) wait some time until socket is created
> 5) some follow up work (move child's PID into same cgroup as qemu's mai=
n thread, relabel the socket so that qemu can access it)
>
> If any of these steps fails then child is killed. However, the PID is n=
ot recorded anywhere and thus is forgotten once control jumps out of the =
function.
>
> Michal
>
> .
>
