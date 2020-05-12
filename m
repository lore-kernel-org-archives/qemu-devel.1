Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD03C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5B420736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5B420736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRNi-0000IX-K5
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jYRNB-0008Io-RS
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:38:49 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:59447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jYRNA-0007RK-Mp
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:38:49 -0400
Received: from player730.ha.ovh.net (unknown [10.108.57.53])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 109A923582B
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:38:37 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 09D1D121E2900;
 Tue, 12 May 2020 09:38:24 +0000 (UTC)
Date: Tue, 12 May 2020 11:38:23 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 0/2] 9pfs: regression init_in_iov_from_pdu truncating size
Message-ID: <20200512113823.3c292c27@bahia.lan>
In-Reply-To: <cover.1589132512.git.qemu_oss@crudebyte.com>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7970526915905034560
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrledvgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuedvtefgfeeukeekgeeukefhueekheetffevledvfeevvdfgveethfeghfevhfenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.40.176; envelope-from=groug@kaod.org;
 helo=9.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 05:38:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 10 May 2020 19:41:52 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Stefano, looks like your original patch needs some more fine tuning:
> 
> https://bugs.launchpad.net/bugs/1877688
> 
> Please check if the assumptions I made about Xen are correct, and please
> also test whether these changes still work for you with Xen as intended by
> you.
> 
> Christian Schoenebeck (2):
>   xen-9pfs: Fix log messages of reply errors
>   9pfs: fix init_in_iov_from_pdu truncating size
> 
>  hw/9pfs/virtio-9p-device.c | 35 ++++++++++++++++++++++++--------
>  hw/9pfs/xen-9p-backend.c   | 41 ++++++++++++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 18 deletions(-)
> 

Sorry, I'm off this week, not sure I'll have time to review.
So I've only applied patch 1 for now and I'll let Stefano
and you sort out what should be done for patch 2.

Cheers,

--
Greg

