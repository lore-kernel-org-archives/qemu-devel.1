Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C606CC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA8121582
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA8121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ60o-0003sy-TE
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 22:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kJ5zX-0002yw-DW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 22:19:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:59036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kJ5zV-0000IQ-9T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 22:19:15 -0400
IronPort-SDR: /NqfCkOb1SWoY3hZNm1Zmj5i541PQkWnXrbkXqtJRrh1sVuYwEJGP2sElB/hh7IZNyjfgN9nWk
 krFBpgO3s5pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="160763549"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; d="scan'208";a="160763549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 19:19:00 -0700
IronPort-SDR: yufH9c4z9XH+67yuMxZ1zvJiUj+6BiXJkUHMHcCwuk9mjzcMmdI+lDrwHEV8di9ZsCA92mnWG0
 qWfaTa/6rrWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; d="scan'208";a="410140087"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga001.fm.intel.com with ESMTP; 17 Sep 2020 19:18:57 -0700
Message-ID: <de6e39509242483607525f9e27aeff92e510a5dc.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/2] Mark Icelake-Client CPU models deprecated
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 18 Sep 2020 10:18:56 +0800
In-Reply-To: <20200917180158.GT7594@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
 <1600245434-63021-2-git-send-email-robert.hu@linux.intel.com>
 <20200917180158.GT7594@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=robert.hu@linux.intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 22:19:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, robert.hu@intel.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-09-17 at 14:01 -0400, Eduardo Habkost wrote:
> On Wed, Sep 16, 2020 at 04:37:14PM +0800, Robert Hoo wrote:
> > Going to obsolete Icelake-Client CPU models in the future.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > ---
> > Change log
> > v3:
> > Obsolete in v5.2 --> v5.3.
> > 
> >  target/i386/cpu.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 9cb82b7..15c1c00 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3467,7 +3467,12 @@ static X86CPUDefinition builtin_x86_defs[] =
> > {
> >          .xlevel = 0x80000008,
> >          .model_id = "Intel Core Processor (Icelake)",
> >          .versions = (X86CPUVersionDefinition[]) {
> > -            { .version = 1 },
> > +            {
> > +                .version = 1,
> > +                .deprecated = true,
> > +                .note = "Deprecated. Will be obsoleted in v5.3.
> > Please use "
> > +                        "'Icelake-Server-v1' CPU model",
> 
> What's the difference between "deprecated" and "obsoleted"?
> 
Forgive my non-native understanding on English word:-D
Here is my understanding:
'Deprecate' is to express strong disapproval on the usage; but, can
still be used if user insists.
'Obsolete' means not usable anymore.

You can feel free to reword the note words.
Perhaps substitute 'removed' for 'obsolete' will be better.

> > +            },
> >              {
> >                  .version = 2,
> >                  .note = "no TSX",
> > @@ -3477,6 +3482,9 @@ static X86CPUDefinition builtin_x86_defs[] =
> > {
> >                      { "rtm", "off" },
> >                      { /* end of list */ }
> >                  },
> > +                .deprecated = true,
> > +                .note = "Deprecated. Will be obsoleted in v5.3.
> > Please use "
> > +                        "'Icelake-Server-v2' CPU model",
> >              },
> >              { /* end of list */ }
> >          }
> > -- 
> > 1.8.3.1
> > 
> 
> 


