Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E44C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F35205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F35205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahcC-0003Ee-1l
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wangjie88@huawei.com>) id 1hahC1-0006Rn-MU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wangjie88@huawei.com>) id 1hahC0-0005ei-FB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:52:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2243 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wangjie88@huawei.com>)
 id 1hahBx-0005aJ-EB; Tue, 11 Jun 2019 09:52:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E7170A5923EF54C2F7A6;
 Tue, 11 Jun 2019 21:51:52 +0800 (CST)
Received: from [10.133.211.192] (10.133.211.192) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 21:51:43 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik
 <mprivozn@redhat.com>, <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
 <cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
 <f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
 <ca74a7bf-dd68-d4c3-2c25-8e43db52678c@redhat.com>
 <f9b6dd9e-3e58-add9-c5ab-da1a883a0a4b@redhat.com>
 <b8a358ee-eb1f-14ca-b406-295ef668bb55@redhat.com>
From: "wangjie (P)" <wangjie88@huawei.com>
Message-ID: <4955ec04-1884-3a68-975f-8d72487c253c@huawei.com>
Date: Tue, 11 Jun 2019 21:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <b8a358ee-eb1f-14ca-b406-295ef668bb55@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.133.211.192]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] pr-manager-helper: fix pr
 process been killed when reconectting
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
Cc: eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi=EF=BC=8C Paolo and Michal=EF=BC=9A

Base on my patch, I found another problem is that=EF=BC=9A

 =C2=A0=C2=A0=C2=A0 qemu: report DISCONNECTED

 =C2=A0=C2=A0=C2=A0 libvirt: start pr-helper #1, but it will takes a whil=
e to complete=20
this action

 =C2=A0=C2=A0=C2=A0 qemu: reconnect to start pr-helper #1 immediately and=
 failed, so=20
report DISCONNECTED

 =C2=A0=C2=A0=C2=A0 libvirt: begin to call qemuProcessStartManagedPRDaemo=
n to start=20
pr-helper #2, but virPidFileAcquirePath failed, so close fd and unlink=20
pidfile by mistake


based on the above problem, I thought out two ways to fix this problem:

1. qemu: when call pr_manager_helper_write failed, sleep one second to=20
make sure libvirt had started pr-helper before call=20
pr_manager_helper_initialize.

2. libvirt: if virFileLock failed in virPidFileAcquirePath, not to close=20
fd and unlink pidfile, because pr-helper #1 is using the pidfile.

what kind of the two above solutions is better? please give me some=20
advice, thanks.


On 2019/5/30 18:59, Paolo Bonzini wrote:
> On 30/05/19 12:08, Michal Privoznik wrote:
>>>> 1) Try to acquire (lock) pidfile
>>>> 2) unlink(socket)
>>>> 3) spawn pr-helper process (this yields child's PID)
>>>> 4) wait some time until socket is created
>>>> 5) some follow up work (move child's PID into same cgroup as qemu's =
main
>>>> thread, relabel the socket so that qemu can access it)
>>> Note that qemu-pr-helper supports the systemd socket activation
>>> protocol.=C2=A0 Would it help if libvirt used it?
>> Thing is, libvirt creates a mount namespace for domains (one namespace
>> for one domain). In this namespace a dummy /dev is mounted and only
>> nodes that qemu is configured to have are created. For instance, you
>> won't see /dev/sda there unless your domain has it as a disk. Then,
>> libvirt moves pr-helper process into the same cgroups as the qemu's ma=
in
>> thread. This is all done so that pr-helper has the same view of the
>> system as qemu. I don't think that he same result can be achieved usin=
g
>> socket activation.
> Why?  The only difference with "normal" behavior and socket activation
> is who creates the socket and calls listen() on it.  Everything else is
> entirely the same.
>
>> Also, libvirt spawns one pr-helper per domain (so that the socket can =
be
>> private and share seclabel with qemu process it's attached to).
> Yes, that is why I thought the socket could be moved in advance to the
> right security label, prior to exec.  Also, perhaps could the child mov=
e
> itself to the right cgroup before dropping privileges.  This would
> remove the window between 3 and 5, by moving all the work *before*
> qemu-pr-helper is exec-ed.
>
> Paolo
>
> .
>

