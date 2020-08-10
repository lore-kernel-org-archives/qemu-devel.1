Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2DEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D34206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D34206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5FRk-00045f-KP
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 17:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k5FQy-0003EB-RX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 17:34:20 -0400
Received: from relay68.bu.edu ([128.197.228.73]:47195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k5FQx-00007D-4D
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 17:34:20 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 07ALX05G023990
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Aug 2020 17:33:04 -0400
Date: Mon, 10 Aug 2020 17:33:00 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
Message-ID: <20200810211958.vyhkl3d4cxpu75ni@mozz.bu.edu>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
 <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
 <c81befdd-979c-6060-c0a3-15ea1b142d25@redhat.com>
 <20200702133830.f3mlqli2bxtvk2z4@mozz.bu.edu>
 <f3cf9017-3da5-d6d4-f463-3864ab1f43c6@linux.vnet.ibm.com>
 <b2fc75ef-f6ae-d776-bead-4e6e6de10207@linux.vnet.ibm.com>
 <5c4add59-86c9-453c-3804-e27fc731ae6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c4add59-86c9-453c-3804-e27fc731ae6c@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 17:34:16
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200810 2139, Paolo Bonzini wrote:
> On 10/08/20 21:01, Daniele Buono wrote:
> > So I'm thinking of adding a check in configure. If gold is the linker,
> > automatically create (somehow, still working on it) the full link script
> > by obtaining the default bfd script and add the required parts. Would
> > that work for you?
> 
> Maybe even do it unconditionally?

I agree.

I can try a respin of my compiler-rt/libFuzzer patches to add a built-in
fork-server to libFuzzer, so we can avoid the linker-script madness
altogether. Don't know how soon I can get to this, but I do think it is
worth another try.

TIL about these differences between ld.bfd and ld.gold.
So the idea is to use something like:
"ld --verbose | grep -n ".*:" | grep -A1 "\s.data\s" | tail -n1"
and insert the existing linker-script before that line?
Thanks
-Alex

> Paolo
> 

