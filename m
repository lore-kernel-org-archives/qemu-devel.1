Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56282C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1F220BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1F220BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFgU-0003Jw-JB
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVFRW-0007YR-1v
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:50:22 -0400
Received: from relay64.bu.edu ([128.197.228.104]:37945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVFRU-0006z6-6a
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:50:21 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 09LEnCaO006204
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 21 Oct 2020 10:49:15 -0400
Date: Wed, 21 Oct 2020 10:49:12 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 02/16] fuzz: Add general virtual-device fuzzer
Message-ID: <20201021144912.x6nb4654t4a3gmpo@mozz.bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
 <20201021010752.973230-3-alxndr@bu.edu>
 <675e45e4-3de1-bf0a-b7d3-117710b7fba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675e45e4-3de1-bf0a-b7d3-117710b7fba2@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:03:58
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.454, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 qemu-devel@nongnu.org, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201021 1444, Paolo Bonzini wrote:
> On 21/10/20 03:07, Alexander Bulekov wrote:
> > +static GString *generic_fuzz_cmdline(FuzzTarget *t)
>                    ^^^^^^^
> 
> > +{
> > +    GString *cmd_line = g_string_new(TARGET_NAME);
> > +    if (!getenv("QEMU_FUZZ_ARGS")) {
> > +        usage();
> > +    }
> > +    g_string_append_printf(cmd_line, " -display none \
> > +                                      -machine accel=qtest, \
> > +                                      -m 512M %s ", getenv("QEMU_FUZZ_ARGS"));
> > +    return cmd_line;
> > +}
> > +
> > +static void register_generic_fuzz_targets(void)
> > +{
> > +    fuzz_add_target(&(FuzzTarget){
> > +            .name = "generic-fuzz",
> > +            .description = "Fuzz based on any qemu command-line args. ",
> > +            .get_init_cmdline = general_fuzz_cmdline,
>                                    ^^^^^^^
> 
> Does this actually compile?
> 
> Paolo

Oops I fix-uped the general->generic change into the wrong commit. I'll
build-test after each commit.
-Alex

> 
> > +            .pre_fuzz = general_pre_fuzz,
> > +            .fuzz = general_fuzz});
> 

