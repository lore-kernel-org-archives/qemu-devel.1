Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983872068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983872068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdb25-0005cD-OB
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jdb1I-0004mA-GQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:57:32 -0400
Received: from relay64.bu.edu ([128.197.228.104]:60532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jdb1H-0006Vh-By
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:57:31 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04QEuWX5005735
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 May 2020 10:56:35 -0400
Date: Tue, 26 May 2020 10:56:32 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/2] tests/qtest/fuzz: Avoid QTest serialization
Message-ID: <20200526145632.65uxxj7qk2lrwxsv@mozz.bu.edu>
References: <20200526055820.12999-1-f4bug@amsat.org>
 <20200526085609.GA766304@stefanha-x1.localdomain>
 <0e3f6528-b26e-6b5b-be23-f7cf79c216f5@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e3f6528-b26e-6b5b-be23-f7cf79c216f5@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:57:30
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200526 1105, Philippe Mathieu-Daudé wrote:
> On 5/26/20 10:56 AM, Stefan Hajnoczi wrote:
> > On Tue, May 26, 2020 at 07:58:18AM +0200, Philippe Mathieu-Daudé wrote:
> >> Hi Alexander,
> >>
> >> I forgot to share these 2 patches wrote before
> >> the direct MemoryRegion fuzzer sent yesterday.
> >>
> >> Regards,
> >>
> >> Phil.
> >>
> >> Philippe Mathieu-Daudé (2):
> >>   tests/qtest/fuzz: Avoid QTest ioport serialization
> >>   tests/qtest/fuzz: Avoid QTest mmio serialization
> >>
> >>  tests/qtest/fuzz/i440fx_fuzz.c      | 19 +++++++++++++------
> >>  tests/qtest/fuzz/virtio_net_fuzz.c  |  6 ++++--
> >>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  6 +++++-
> >>  3 files changed, 22 insertions(+), 9 deletions(-)
> > 
> > Will it still be possible to print qtest reproducer commands when a
> > crash is found?
> 
> Yes, there is no change in the corpus format.

Yes, though with these patches, the qtest-based code will be gone.
Should there be some option to switch between the two modes?

> > 
> > Other than this concern, higher fuzzing rates would be great.
> 
> Thanks,
> 
> Phil.

