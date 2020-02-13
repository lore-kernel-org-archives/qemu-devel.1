Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A480C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41EB218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41EB218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arrikto.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Esl-0005Tg-34
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ndragazis@arrikto.com>) id 1j2ErZ-0004Jl-2k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ndragazis@arrikto.com>) id 1j2ErX-0001bf-Ah
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:49:04 -0500
Received: from mx0.arrikto.com ([2a01:7e00::f03c:91ff:fe6e:d7ab]:38179)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ndragazis@arrikto.com>)
 id 1j2ErX-0001bH-1p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:49:03 -0500
Received: from troi.prod.arr (mail.arr [10.99.0.5])
 by mx0.arrikto.com (Postfix) with ESMTP id 3AB871FE006;
 Thu, 13 Feb 2020 15:49:00 +0200 (EET)
Received: from [10.89.50.23] (naxos.vpn.arr [10.89.50.23])
 by troi.prod.arr (Postfix) with ESMTPSA id DA66A2AD;
 Thu, 13 Feb 2020 15:48:59 +0200 (EET)
From: Nikos Dragazis <ndragazis@arrikto.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
In-Reply-To: <CAJSP0QW6cC=rCTn--vJ84t+LzeFND_SeN76CdF1fv6-F4NVDyg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/1] Vhost User Cross Cable: Intro
Message-ID: <10735dfd-1da5-416e-1b25-b5c354bb1901@arrikto.com>
Date: Thu, 13 Feb 2020 15:48:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:7e00::f03c:91ff:fe6e:d7ab
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
Cc: Vangelis Koukis <vkoukis@arrikto.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "V." <mail@winaoe.org>, "Stojaczyk, Dariusz" <dariusz.stojaczyk@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 10:20 Stefan Hajnoczi
<stefanha@gmail.com> wrote:
 > On Fri, Jan 10, 2020 at 10:34 AM Marc-Andr=C3=A9 Lureau
 > <address@hidden> wrote:
 > > On Wed, Jan 8, 2020 at 5:57 AM V. <address@hidden> wrote:
 >
 > Hi V.,
 > I think I remember you from Etherboot/gPXE days :).
 >
 > > > 3.
 > > > Now if Cross Cable is actually a new and (after a code-rewrite of =
10) a
 > > > viable way to connect 2 QEMU's together, could I actually
 > > > suggest a better way?
 > > > I am thinking of a '-netdev vhost-user-slave' option to connect (a=
s client
 > > > or server) to a master QEMU running '-netdev vhost-user'.
 > > > This way there is no need for any external program at all, the mas=
ter can
 > > > have it's memory unshared and everything would just work
 > > > and be fast.
 > > > Also the whole thing can fall back to normal virtio if memory is n=
ot shared
 > > > and it would even work in pure usermode without any
 > > > context switch.
 > > >
 > > > Building a patch for this idea I could maybe get around to, don't =
clearly
 > > > have an idea how much work this would be but I've done
 > > > crazier things.
 > > > But is this is something that someone might be able to whip up in =
an hour
 > > > or two? Someone who actually does have a clue about vhost
 > > > and virtio maybe? ;-)
 > >
 > > I believe https://wiki.qemu.org/Features/VirtioVhostUser is what you
 > > are after. It's still being discussed and non-trivial, but not very
 > > active lately afaik.
 >
 > virtio-vhost-user is being experimented with in the SPDK community but
 > there has been no activity on VIRTIO standardization or the QEMU
 > patches for some time.=C2=A0 More info here:
 > https://ndragazis.github.io/spdk.html
 >
 > I think the new ivshmem v2 feature may provide the functionality you
 > are looking for, but I haven't looked at them yet.=C2=A0 Here is the l=
ink:
 > https://www.mail-archive.com/address@hidden/msg668749.html
 >
 > And here is Jan's KVM Forum presentation on ivshmem v2:
 > https://www.youtube.com/watch?v=3DTiZrngLUFMA
 >
 > Stefan


Hi Stefan,

First of all, sorry for the delayed response. The mail got lost
somewhere in my inbox. Please keep Cc-ing me on all threads related to
virtio-vhost-user.

As you correctly pointed out, I have been experimenting with
virtio-vhost-user on SPDK and [1] is a working demo on this matter. I
have been working on getting it merged with SPDK and, to this end, I
have been interacting with the SPDK team [2][3] and mostly with Darek
Stojaczyk (Cc-ing him).

The reason that you haven=E2=80=99t seen any activity for the last months=
 is
that I got a job and hence my schedule has become tighter. But I will
definitely find some space and fit it into my schedule. Let me give you
a heads up, so that we get synced:

Originally, I created and sent a patch (influenced from your DPDK patch
[4]) to SPDK that was enhancing SPDK=E2=80=99s internal rte_vhost library=
 with
the virtio-vhost-user transport. However, a few weeks later, the SPDK
team decided to switch from their internal rte_vhost library to using
DPDK=E2=80=99s rte_vhost library directly [3]. Given that, I refactored a=
nd sent
the patch for the virtio-vhost-user transport to the DPDK mailing list
[5]. Regarding the virtio-vhost-user device, I have made some
enhancements [6] on your original RFC device implementation and, as you
may remember, I have sent some revised versions of the spec to the
virtio mailing list [7].

At the moment, the blocker is the virtio spec. The last update on this
was my discussion with Michael Tsirkin (Cc-ing him as well) about the
need for the VIRTIO_PCI_CAP_DOORBELL_CFG and
VIRTIO_PCI_CAP_NOTIFICATION_CFG configuration structures [8].

So, I think the next steps should be the following:

1. merging the spec
2. adding the device on QEMU
3. adding the vvu transport on DPDK
4. extending SPDK to make use of the new vhost-user transport

To conclude, I still believe that this device is useful and should be
part of virtio/qemu/dpdk/spdk and I will continue working on this
direction.

Best regards,
Nikos


[1] https://ndragazis.github.io/spdk.html
[2] https://lists.01.org/hyperkitty/list/spdk@lists.01.org/thread/UR4FM45=
LEQIBJNQ4MTDZFH6SLTXHTGDR/#ZGPRKS47QWHXHFBEKSCA7Z66E2AGSLHN
[3] https://lists.01.org/hyperkitty/list/spdk@lists.01.org/thread/WLUREJG=
PK5UJVTHIQ5GRL3CDWR5NN5BI/#G7P3D4KF6OQDI2RYASXQOZCMITKT5DEP
[4] http://mails.dpdk.org/archives/dev/2018-January/088155.html
[5] https://lore.kernel.org/dpdk-dev/e03dcc29-d472-340a-9825-48d13e472a48=
@redhat.com/T/
[6] https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02910.html
[7] https://lists.oasis-open.org/archives/virtio-dev/201906/msg00036.html
[8] https://lists.oasis-open.org/archives/virtio-dev/201908/msg00014.html

