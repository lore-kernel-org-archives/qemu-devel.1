Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538B4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C99206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C99206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWgT-0002Ik-AR
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZWfY-0001mR-Em
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:30:16 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:57198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZWfX-00080c-As
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:30:16 -0400
Received: from player797.ha.ovh.net (unknown [10.108.57.153])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id BF5E21674F5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:30:11 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id C2C3EE583884;
 Fri, 15 May 2020 09:30:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00191b856b3-507f-429d-b427-045d68677aaa,1FE7B88794C3EA072CE4CC6A392C038E50AC8F7C)
 smtp.auth=groug@kaod.org
Date: Fri, 15 May 2020 11:30:02 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 0/1] virtio-9pfs: don't truncate response
Message-ID: <20200515113002.785303e7@bahia.lan>
In-Reply-To: <cover.1589481482.git.qemu_oss@crudebyte.com>
References: <cover.1589481482.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6999438247582406976
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuedvtefgfeeukeekgeeukefhueekheetffevledvfeevvdfgveethfeghfevhfenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.41.146; envelope-from=groug@kaod.org;
 helo=1.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 05:30:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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

On Thu, 14 May 2020 20:38:02 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The following patch reverts
> SHA-1 16724a173049ac29c7b5ade741da93a0f46edff for the virtio backend.
> 
> Greg, it is intended as a quick fix for
> https://bugs.launchpad.net/bugs/1877688 at least for virtio, for the
> case the appropriate fix on Xen side might still take a while. Because
> this bug is too serious to let it rest for too long.
> 
> In case Stefano comes up with a fix for Xen soon, you might just ignore
> this patch and just revert SHA-1 16724a173049ac29c7b5ade741da93a0f46edff
> entirely instead of course.
> 

Stefano said he could come up with a fix in a few days, so I'll just
wait for now. If nothing happens in, say, two weeks, please ping me
and I'll merge this patch.

> Christian Schoenebeck (1):
>   virtio-9pfs: don't truncate response
> 
>  hw/9pfs/virtio-9p-device.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 


