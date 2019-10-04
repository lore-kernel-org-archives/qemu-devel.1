Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0178C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 06:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A424F20862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 06:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A424F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGHW7-0003L1-SB
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 02:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iGHUE-0002C8-UX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 02:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iGHUA-0006Tf-SU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 02:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iGHUA-0006TT-N8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 02:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3417B309B142;
 Fri,  4 Oct 2019 06:54:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26C83608A5;
 Fri,  4 Oct 2019 06:54:39 +0000 (UTC)
Date: Fri, 4 Oct 2019 08:54:37 +0200
From: Andrew Jones <drjones@redhat.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v5 0/9] target/arm/kvm: enable SVE in guests
Message-ID: <20191004065437.xrcdsvytouau5fus@kamzik.brq.redhat.com>
References: <8898674D84E3B24BA3A2D289B872026A78C9895A@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A78C9895A@G01JPEXMBKW03>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 04 Oct 2019 06:54:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>, "Okamoto,
 Takayuki" <tokamoto@jp.fujitsu.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 03, 2019 at 11:55:36PM +0000, Zhang, Lei wrote:
> Hi Jones,
> 
> Thanks for your patch.
> 
> I have tested the v5 patch.
> 
> All the test is passed, except one problem.
> The problem was reported
> in [[Qemu-devel] [RFC QEMU v2 0/2] arm/virt: Account for guest pause time]
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05713.html

This problem is unrelated to SVE.

> 
> My test environment is below.
> 
> *QEMU
> base + v5 pathc
> 
> base is 
>     commit 860d9048c78ce59c5903c3d5209df56f38400986
>     Merge: 8dc5728 571a8c5
>     Author: Peter Maydell <peter.maydell@linaro.org>
>     Date:   Tue Sep 24 13:51:51 2019 +0100
>     
> 
> *libvirt
> https://github.com/andreabolognani/libvirt/tree/sve
> 
> commit 236fb544ff8fcecfc618608b3ae2b65fc74e4d7c
> 
> *Kernel
> 5.3.1
> 
> Best Regards,
> Lei Zhang
>

Since the problem you point out is not related to SVE, or this series,
then do you agree to providing a tested-by for this series?

Thanks,
drew

