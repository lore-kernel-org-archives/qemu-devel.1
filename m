Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952CEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85F02222B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85F02222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3jX-0006vs-Lg
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3Y6-0001DV-Ix
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:44:08 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3Y4-000140-Kf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:44:05 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09FDhcew001305
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Oct 2020 09:43:41 -0400
Date: Thu, 15 Oct 2020 09:43:38 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v3 09/16] fuzz: add a crossover function to generic-fuzzer
Message-ID: <20201015134338.m3xsvwwsxgyxe63g@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-10-alxndr@bu.edu>
 <m2eemi6jzn.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2eemi6jzn.fsf@oracle.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:44:03
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 qemu-devel@nongnu.org, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks, I added some clarifications, but I added them to 02/16 (where I
first define and use SEPARATOR).

On 201001 1631, Darren Kenny wrote:
> As mentioned in an earlier patch, maybe the definition of SEPARATOR
> should be here as well as some of the comments you provided in the
> replies to it.
> 
> Otherwise, this looks good,
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> On Sunday, 2020-09-20 at 22:24:59 -04, Alexander Bulekov wrote:
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  tests/qtest/fuzz/general_fuzz.c | 90 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 89 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> > index 656ec7fd55..3833b505c8 100644
> > --- a/tests/qtest/fuzz/general_fuzz.c
> > +++ b/tests/qtest/fuzz/general_fuzz.c
> > @@ -741,6 +741,92 @@ static void general_pre_fuzz(QTestState *s)
> >  
> >      counter_shm_init();
> >  }
> > +
> > +/*
> > + * When libfuzzer gives us two inputs to combine, return a new input with the
> > + * following structure:
> > + *
> > + * Input 1 (data1)
> > + * SEPARATOR
> > + * Clear out the DMA Patterns
> > + * SEPARATOR
> > + * Disable the pci_read/write instructions
> > + * SEPARATOR
> > + * Input 2 (data2)
> > + *
> > + * The idea is to collate the core behaviors of the two inputs.
> > + * For example:
> > + * Input 1: maps a device's BARs, sets up three DMA patterns, and triggers
> > + *          device functionality A
> > + * Input 2: maps a device's BARs, sets up one DMA pattern, and triggers device
> > + *          functionality B
> > + *
> > + * This function attempts to produce an input that:
> > + * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
> > + *          functionality A device, replaces the DMA patterns with a single
> > + *          patten, and triggers device functionality B.
> > + */
> > +static size_t general_fuzz_crossover(const uint8_t *data1, size_t size1, const
> > +                                     uint8_t *data2, size_t size2, uint8_t *out,
> > +                                     size_t max_out_size, unsigned int seed)
> > +{
> > +    size_t copy_len = 0, size = 0;
> > +
> > +    /* Check that we have enough space for data1 and at least part of data2 */
> > +    if (max_out_size <= size + strlen(SEPARATOR) * 3 + 2) {
> > +        return 0;
> > +    }
> > +
> > +    /* Copy_Len in the first input */
> > +    copy_len = size1;
> > +    memcpy(out + size, data1, copy_len);
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    /* Append a separator */
> > +    copy_len = strlen(SEPARATOR);
> > +    memcpy(out + size, SEPARATOR, copy_len);
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    /* Clear out the DMA Patterns */
> > +    copy_len = 1;
> > +    if (copy_len) {
> > +        out[size] = OP_CLEAR_DMA_PATTERNS;
> > +    }
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    /* Append a separator */
> > +    copy_len = strlen(SEPARATOR);
> > +    memcpy(out + size, SEPARATOR, copy_len);
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    /* Disable PCI ops. Assume data1 took care of setting up PCI */
> > +    copy_len = 1;
> > +    if (copy_len) {
> > +        out[size] = OP_DISABLE_PCI;
> > +    }
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    /* Append a separator */
> > +    copy_len = strlen(SEPARATOR);
> > +    memcpy(out + size, SEPARATOR, copy_len);
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    /* Copy_Len over the second input */
> > +    copy_len = MIN(size2, max_out_size);
> > +    memcpy(out + size, data2, copy_len);
> > +    size += copy_len;
> > +    max_out_size -= copy_len;
> > +
> > +    return  size;
> > +}
> > +
> > +
> >  static GString *general_fuzz_cmdline(FuzzTarget *t)
> >  {
> >      GString *cmd_line = g_string_new(TARGET_NAME);
> > @@ -760,7 +846,9 @@ static void register_general_fuzz_targets(void)
> >              .description = "Fuzz based on any qemu command-line args. ",
> >              .get_init_cmdline = general_fuzz_cmdline,
> >              .pre_fuzz = general_pre_fuzz,
> > -            .fuzz = general_fuzz});
> > +            .fuzz = general_fuzz,
> > +            .crossover = general_fuzz_crossover
> > +    });
> >  }
> >  
> >  fuzz_target_init(register_general_fuzz_targets);
> > -- 
> > 2.28.0

