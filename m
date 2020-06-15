Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD32C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5311920739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5311920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkt3A-00077k-In
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jkt2a-0006aa-03
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:37:00 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:59268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jkt2Y-0003uv-2f
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:36:59 -0400
Received: from player761.ha.ovh.net (unknown [10.110.171.173])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id E42451C8E66
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 19:36:52 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 5362913656B69;
 Mon, 15 Jun 2020 17:36:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0069bb49d2b-ef78-49ef-adb1-453b23a6cdbb,5C47BD02349C79BF9CDCA388379BE458769A1293)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 0/6] Add several Power ISA 3.1 32/64-bit vector
 instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ef31bb82-607c-3fde-577b-559ff5033be6@kaod.org>
Date: Mon, 15 Jun 2020 19:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-1-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12804859643511212864
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhffegleefjeduveeuvddvieegudetteevfffhffdugefggeelleejueeifeeuvdenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.45.168; envelope-from=clg@kaod.org;
 helo=20.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 13:36:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 6/13/20 6:20 AM, Lijun Pan wrote:
> This patch series add several newly introduced 32/64-bit vector
> instructions in Power ISA 3.1. The newly added instructions are
> flagged as ISA300 temporarily in vmx-ops.inc.c and vmx-impl.inc.c
> to make them compile and function since Power ISA 3.1, together
> with next generation processor, has not been fully enabled in QEMU
> yet. When Power ISA 3.1 and next generation processor are fully
> supported, the flags should be changed.

What do you mean ? 

ISA 3.1 and POWER10 are merged in Linux and in the QEMU pseries 
and PowerNV (OPAL) machines.

It's very much empty but it's there.

C. 


> 
> Lijun Pan (6):
>   target/ppc: add byte-reverse br[dwh] instructions
>   target/ppc: add vmulld instruction
>   targetc/ppc: add vmulh{su}w instructions
>   target/ppc: add vmulh{su}d instructions
>   fix the prototype of muls64/mulu64
>   target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
> 
>  include/qemu/host-utils.h           |  4 +-
>  target/ppc/helper.h                 | 13 ++++++
>  target/ppc/int_helper.c             | 58 +++++++++++++++++++++++++
>  target/ppc/translate.c              | 65 +++++++++++++++++++++++++++++
>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++++
>  target/ppc/translate/vmx-ops.inc.c  | 22 ++++++++--
>  6 files changed, 180 insertions(+), 6 deletions(-)
> 


