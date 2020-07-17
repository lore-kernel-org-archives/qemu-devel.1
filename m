Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE03C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE54207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE54207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwF5f-0001zm-GC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 21:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwF55-0001XW-A0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 21:22:31 -0400
Received: from relay64.bu.edu ([128.197.228.104]:57168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jwF52-0007Gc-S0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 21:22:30 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 06H1LpoW022538
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2020 21:21:56 -0400
Date: Thu, 16 Jul 2020 21:21:51 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
Message-ID: <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 21:22:27
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200717 0853, Li Qiang wrote:
> P J P <ppandit@redhat.com> 于2020年7月17日周五 上午3:26写道：
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > While sending packets, the check that packet 'payload_len'
> > is within 64kB limit, seems to happen only for GSO frames.
> > It may lead to use-after-free or out-of-bounds access like
> > issues when sending non-GSO frames. Check the 'payload_len'
> > limit for all packets, irrespective of the gso type.
> >
> 
> Hello Prasad,
> Which issue are you trying to solve, any reference linking?
> 
> I also send a patch related this part and also a UAF.
> 
> Thanks,
> Li Qiang

Hi Li, Prasad,
I reported a UAF privately to QEMU-Security in May. I believe the one Li
is referring to is this one https://bugs.launchpad.net/qemu/+bug/1886362

When I saw Prasad's email, I was worried that I reported the same bug
twice, but I can still reproduce LP#1886362 with Prasad's patch.

On the other hand, I cannot reproduce either issue with Li's patch:
Message-Id: <20200716161453.61295-1-liq3ea@163.com>

Based on this, I think there were two distinct issues. Both of the
crashes rely on e1000e tx loopback into e1000e MMIO. Since Li's
patch adds a TX bh, it seems to mitigate such types of issues.

Sorry about any confusion.
-Alex

> > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/net/net_tx_pkt.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> > index 162f802dd7..e66998a8f9 100644
> > --- a/hw/net/net_tx_pkt.c
> > +++ b/hw/net/net_tx_pkt.c
> > @@ -607,12 +607,10 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
> >       * Since underlying infrastructure does not support IP datagrams longer
> >       * than 64K we should drop such packets and don't even try to send
> >       */
> > -    if (VIRTIO_NET_HDR_GSO_NONE != pkt->virt_hdr.gso_type) {
> > -        if (pkt->payload_len >
> > -            ETH_MAX_IP_DGRAM_LEN -
> > -            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
> > -            return false;
> > -        }
> > +    if (pkt->payload_len >
> > +        ETH_MAX_IP_DGRAM_LEN -
> > +        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
> > +        return false;
> >      }
> >
> >      if (pkt->has_virt_hdr ||
> > --
> > 2.26.2
> >
> >

