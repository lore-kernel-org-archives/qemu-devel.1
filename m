Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2937C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFB92173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFB92173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQPB-0007Tw-Sc
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hoQP0-0006uO-BD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hoQOz-00072y-Bh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:46:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>)
 id 1hoQOx-0006zv-63; Fri, 19 Jul 2019 06:46:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EAE730832C8;
 Fri, 19 Jul 2019 10:46:09 +0000 (UTC)
Received: from redhat.com (ovpn-121-25.rdu2.redhat.com [10.10.121.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 261C35D719;
 Fri, 19 Jul 2019 10:46:05 +0000 (UTC)
Date: Fri, 19 Jul 2019 06:46:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Message-ID: <20190719064229-mutt-send-email-mst@kernel.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DE0920@DGGEML529-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DE0920@DGGEML529-MBS.china.huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 19 Jul 2019 10:46:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiangyifei <jiangyifei@huawei.com>, fangying <fangying1@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 02:35:14AM +0000, Zhangbo (Oscar) wrote:
> Hi All:
> I have 2 questions about (un)hotplug on pcie-root-port.
> First Question (hotplug failure because of redundant PCI_EXP_LNKSTA_DLL=
LA bit set):
>     during VM boot, qemu sets PCI_EXP_LNKSTA_DLLLA according to this pr=
ocess:
>         pcie_cap_init() -> pcie_cap_v1_fill(),=20
>     even if there's no pcie device added to the VM.
>     I noticed that during hotplug, qemu also sets PCI_EXP_LNKSTA_DLLLA =
in pcie_cap_slot_hotplug_cb().
>     It means that the bit PCI_EXP_LNKSTA_DLLLA is set TWICE.
>     why set this bit during initializing pcie-root-port? It seems unnec=
essary.

Makes sense.

>     The bad side of this is it causes HOTPLUG FAILURE if we boot the VM=
 and hotplug a pcie device at the same time:
> 	In VM kernel=EF=BC=8Caccording to this bit set, it senses a PDC event,=
 the process is:=20
>         pciehp_probe -> pcie_init -> pcie_init_slot -> pciehp_queue_pus=
hbutton_work.=20
>     If the 2 PDC events get too close, the VM kernel will wrongly unplu=
g the device.
> Suggestion to the 1st problem:
> 	Can I remove the PCI_EXP_LNKSTA_DLLLA bit set process during pcie_cap_=
init().
>=20
> Second Question (time cost too much during pcie device unplug):
>     qemu only send ABP event to VM kernel during unpluging pcie devices=
, VM kernel receives the
>     ABP event then sleep 5s to expect a PDC event, which causes unplugi=
ng devices takes too long.=20
> Suggestion to the 2nd problem:
> 	Can I send ABP and *PDC* events to kernet when unplug devices.

I think we should not only set PDC but also try clearing presence bit,
even though the device is actually still there and mapped into guest
memory.
Maybe we should also not send the ABP event at all.

In both cases it's necessary to test with a non-linux guest
(e.g. a couple of versions of windows) to be sure we are not breaking
anything.


--=20
MST

