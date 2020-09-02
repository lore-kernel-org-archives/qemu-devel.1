Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B21C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A1720829
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A1720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVST-0001oB-A3
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDVRv-0001NU-SN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:17:27 -0400
Received: from relay68.bu.edu ([128.197.228.73]:53527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDVRu-00023u-6o
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:17:27 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 082GH6wg030708
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Sep 2020 12:17:10 -0400
Date: Wed, 2 Sep 2020 12:17:06 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] meson: specify fuzz linker script as a project arg
Message-ID: <20200902161706.qrjygforqz4fzbza@mozz.bu.edu>
References: <20200902143800.124073-1-alxndr@bu.edu>
 <20200902143800.124073-2-alxndr@bu.edu>
 <a629fc46-de76-50f0-f4b1-52031ee79267@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a629fc46-de76-50f0-f4b1-52031ee79267@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:34:22
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200902 1745, Paolo Bonzini wrote:
> On 02/09/20 16:37, Alexander Bulekov wrote:
> > With this change, the fuzzer-linker script should be specified outside
> > any --start-group/--end-group pairs. We need this on oss-fuzz, where
> > partially applying the linker-script results in a linker failure
> 
> Is this okay also for targets that don't link to the fuzzing static library?
> 
> Paolo
> 

To be honest, I still do not completely understand why there is a
different behavior when we specify the script within a group. The man
page for ld.bfd doesn't talk about linker arguments between
--start-group and --end-group that are not archives. If I understand the
purpose of these linker groups, the linker script should still apply to
everything (regardless where it is specified). I would expect there to
be no change in behavior, or a complaint about passing linker arguments
that are not archive paths.

I was also worried about what would happen to all the __wrap_qtest
arguments, since those are still in the group, and they can fail silently.
Disassembling the binary confirmed that all the calls to
qtest_{in*,out*} are still wrapped.

Anyways.. I tested this series with and without LIB_FUZZING_ENGINE, and
used nm to confirm that the layout of the symbols/data is correct in
both cases (at least on my machine and the oss-fuzz docker) ..

-Alex

