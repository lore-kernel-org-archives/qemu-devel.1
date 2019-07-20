Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F3C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 08:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1962084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 08:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1962084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hol4x-0006eC-N6
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 04:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fangying1@huawei.com>) id 1hojk2-00006K-4H
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 03:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1hojk1-0007C2-0u
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 03:25:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2240 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1hojjy-00072d-Do; Sat, 20 Jul 2019 03:25:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E0DD4AC38A0F95DE4666;
 Sat, 20 Jul 2019 15:25:01 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.53) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 20 Jul 2019
 15:24:51 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>, "Zhangbo (Oscar)"
 <oscar.zhangbo@huawei.com>
References: <0259E1C966E8C54AA93AA2B1240828E672DE0920@DGGEML529-MBS.china.huawei.com>
 <20190719064229-mutt-send-email-mst@kernel.org>
From: fangying <fangying1@huawei.com>
Message-ID: <7da3cb6d-daf8-99e3-cfde-f19543538ee1@huawei.com>
Date: Sat, 20 Jul 2019 15:24:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719064229-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
X-Mailman-Approved-At: Sat, 20 Jul 2019 04:50:37 -0400
Subject: Re: [Qemu-devel] Discussion: redundant process during hotplug and
 missed process during unplug
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
Cc: "limingwang \(A\)" <limingwang@huawei.com>,
 Jiangyifei <jiangyifei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "dengkai
 \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Michael,
> On Fri, Jul 19, 2019 at 02:35:14AM +0000, Zhangbo (Oscar) wrote:
>> Hi All:
>> I have 2 questions about (un)hotplug on pcie-root-port.
>> First Question (hotplug failure because of redundant PCI_EXP_LNKSTA_DL=
LLA bit set):
>>      during VM boot, qemu sets PCI_EXP_LNKSTA_DLLLA according to this =
process:
>>          pcie_cap_init() -> pcie_cap_v1_fill(),
>>      even if there's no pcie device added to the VM.
>>      I noticed that during hotplug, qemu also sets PCI_EXP_LNKSTA_DLLL=
A in pcie_cap_slot_hotplug_cb().
>>      It means that the bit PCI_EXP_LNKSTA_DLLLA is set TWICE.
>>      why set this bit during initializing pcie-root-port? It seems unn=
ecessary.
>=20
> Makes sense.
>=20
>>      The bad side of this is it causes HOTPLUG FAILURE if we boot the =
VM and hotplug a pcie device at the same time:
>> 	In VM kernel=EF=BC=8Caccording to this bit set, it senses a PDC event=
, the process is:
>>          pciehp_probe -> pcie_init -> pcie_init_slot -> pciehp_queue_p=
ushbutton_work.
>>      If the 2 PDC events get too close, the VM kernel will wrongly unp=
lug the device.
>> Suggestion to the 1st problem:
>> 	Can I remove the PCI_EXP_LNKSTA_DLLLA bit set process during pcie_cap=
_init().
>>

We raise this qeustion here because we find out that if the pcie ext=20
capability PCI_EXP_LNKSTA_DLLLA is set by default, linux kernel may try=20
to send PCI_EXP_HP_EV_PDC event after boot-up. When we do virtio device=20
hotplug during the processing of PCI_EXP_HP_EV_PDC event (pciehp_ist=20
=3D>pciehp_handle_presence_or_link_change =3D> pciehp_enable_slot)
the device may be accidently powered down because the power state=20
detected is ON_STATE.

Kernel sends PCI_EXP_HP_EV_PDC event when it tries to probe the
pcie-root-probe, i.e:
pciehp_probe =3D> pciehp_check_presence =3D>=20
pciehp_card_present_or_link_active  =3D> pciehp_check_link_active
pciehp_check_link_active returns true if PCI_EXP_LNKSTA_DLLLA Cap is=20
presented.

We are going send a patch to have PCI_EXP_LNKSTA_DLLLA Cap removed to=20
fix the problem here.
>> Second Question (time cost too much during pcie device unplug):
>>      qemu only send ABP event to VM kernel during unpluging pcie devic=
es, VM kernel receives the
>>      ABP event then sleep 5s to expect a PDC event, which causes unplu=
ging devices takes too long.
>> Suggestion to the 2nd problem:
>> 	Can I send ABP and *PDC* events to kernet when unplug devices.
>=20
> I think we should not only set PDC but also try clearing presence bit,
> even though the device is actually still there and mapped into guest
> memory.
> Maybe we should also not send the ABP event at all.
>=20
> In both cases it's necessary to test with a non-linux guest
> (e.g. a couple of versions of windows) to be sure we are not breaking
> anything.
>=20
>=20
Thanks to your opinion, we will try to send PCI_EXP_HP_EV_PDC event=20
instead of the PCI_EXP_HP_EV_PDC event at device unplug and do some=20
Windows guest compatibility test.
We will reply later.


