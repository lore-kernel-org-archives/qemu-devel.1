Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8219C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C1D21556
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C1D21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb362-0002Qn-1l
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb35T-0001zC-Pi
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:51:35 -0500
Received: from relay68.bu.edu ([128.197.228.73]:58408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb35R-0004Ud-IH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:51:35 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 0A6EoSfg024503
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Nov 2020 09:50:32 -0500
Date: Fri, 6 Nov 2020 09:50:28 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/9] fuzz: Make fork_fuzz.ld compatible with LLVM's LLD
Message-ID: <20201106145028.qlkng2l25b7ehvsb@mozz.bu.edu>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201105221905.1350-2-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105221905.1350-2-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 08:21:42
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201105 1718, Daniele Buono wrote:
> LLVM's linker, LLD, supports the keyword "INSERT AFTER", starting with
> version 11.
> However, when multiple sections are defined in the same "INSERT AFTER",
> they are added in a reversed order, compared to BFD's LD.
> 
> This patch makes fork_fuzz.ld generic enough to work with both linkers.
> Each section now has its own "INSERT AFTER" keyword, so proper ordering is
> defined between the sections added.
> 

Hi Daniele,
Good to know that LLVM now has support for "INSERT AFTER" :)

I compared the resulting symbols between __FUZZ_COUNTERS_{START,END}
(after linking with BFD) before/after this patch, and they look good. I
also ran a test-build with OSS-Fuzz container and confirmed that the
resulting binary also had proper symbols.

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Tested-by: Alexander Bulekov <alxndr@bu.edu>

Thanks

> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  tests/qtest/fuzz/fork_fuzz.ld | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
> index bfb667ed06..cfb88b7fdb 100644
> --- a/tests/qtest/fuzz/fork_fuzz.ld
> +++ b/tests/qtest/fuzz/fork_fuzz.ld
> @@ -16,6 +16,11 @@ SECTIONS
>        /* Lowest stack counter */
>        *(__sancov_lowest_stack);
>    }
> +}
> +INSERT AFTER .data;
> +
> +SECTIONS
> +{
>    .data.fuzz_ordered :
>    {
>        /*
> @@ -34,6 +39,11 @@ SECTIONS
>         */
>         *(.bss._ZN6fuzzer3TPCE);
>    }
> +}
> +INSERT AFTER .data.fuzz_start;
> +
> +SECTIONS
> +{
>    .data.fuzz_end : ALIGN(4K)
>    {
>        __FUZZ_COUNTERS_END = .;
> @@ -43,4 +53,4 @@ SECTIONS
>   * Don't overwrite the SECTIONS in the default linker script. Instead insert the
>   * above into the default script
>   */
> -INSERT AFTER .data;
> +INSERT AFTER .data.fuzz_ordered;
> -- 
> 2.17.1
> 

