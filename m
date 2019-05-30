Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B8C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91374256C7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91374256C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWI01-0000lg-KM
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:09:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hWHz9-0000Sd-N5
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hWHz8-0007yt-NE
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>)
	id 1hWHz6-0007tl-64; Thu, 30 May 2019 06:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDB5A80467;
	Thu, 30 May 2019 10:08:29 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 165FF5D704;
	Thu, 30 May 2019 10:08:27 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, Jie Wang <wangjie88@huawei.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
	<cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
	<f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
	<ca74a7bf-dd68-d4c3-2c25-8e43db52678c@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <f9b6dd9e-3e58-add9-c5ab-da1a883a0a4b@redhat.com>
Date: Thu, 30 May 2019 12:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ca74a7bf-dd68-d4c3-2c25-8e43db52678c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 30 May 2019 10:08:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On 5/29/19 11:34 AM, Paolo Bonzini wrote:
> On 29/05/19 09:33, Michal Privoznik wrote:
>> On 5/28/19 7:45 PM, Paolo Bonzini wrote:
>>> On 28/05/19 15:06, Jie Wang wrote:
>>>> if pr-helper been killed and qemu send disconnect event to libvirt
>>>> and libvirt started a new pr-helper process, the new pr-heleper
>>>> been killed again when qemu is connectting to the new pr-helper,
>>>> qemu will never send disconnect to libvirt, and libvirt will never
>>>> receive connected event.
>>>
>>> I think this would let a guest "spam" events just by sending a lot PR
>>> commands.=C2=A0 Also, as you said, in this case QEMU has never sent a
>>> "connected" event, so I'm not sure why it should send a disconnection
>>> event.
>>
>> So pr manager is initialized on the first PR command and not when qemu
>> is starting?
>=20
> It is initialized when QEMU is started, but if it dies, that's not
> detected until the first PR command.  The command is retried for 5
> seconds, which should give libvirt ample time to restart the PR manager
> (and it's an exceptional situation anyway).

Ah yes, I recall vaguelly testing this whilst writing patches for libvirt=
.

>=20
>> If a user inside the guest could somehow kill pr-helper process in the
>> host then yes, they could spam libvirt/qemu. But if a user from inside=
 a
>> guest can kill a process in the host that is much bigger problem than
>> spaming libvirt.
>=20
> This is true.
>=20
>>> Does libvirt monitor at all the pr-helper to check if it dies?=C2=A0 =
Or does
>>> it rely exclusively on QEMU's events?
>>
>> Libvirt relies solely on QEMU's events. Just like with qemu process
>> itself, libvirt can't rely on SIGCHILD because the daemon might be
>> restarted which would reparent all qemu and pr-helper processes
>> rendering libvirt wait for SIGCHILD useless.
>>
>> But there is an exception to this: when libvirt is spawning pr-helper =
it
>> does so by following these steps:
>>
>> 1) Try to acquire (lock) pidfile
>> 2) unlink(socket)
>> 3) spawn pr-helper process (this yields child's PID)
>> 4) wait some time until socket is created
>> 5) some follow up work (move child's PID into same cgroup as qemu's ma=
in
>> thread, relabel the socket so that qemu can access it)
>>
>> If any of these steps fails then child is killed. However, the PID is
>> not recorded anywhere and thus is forgotten once control jumps out of
>> the function.
>=20
> Note that qemu-pr-helper supports the systemd socket activation
> protocol.  Would it help if libvirt used it?

Thing is, libvirt creates a mount namespace for domains (one namespace=20
for one domain). In this namespace a dummy /dev is mounted and only=20
nodes that qemu is configured to have are created. For instance, you=20
won't see /dev/sda there unless your domain has it as a disk. Then,=20
libvirt moves pr-helper process into the same cgroups as the qemu's main=20
thread. This is all done so that pr-helper has the same view of the=20
system as qemu. I don't think that he same result can be achieved using=20
socket activation.
Also, libvirt spawns one pr-helper per domain (so that the socket can be=20
private and share seclabel with qemu process it's attached to).

Michal

