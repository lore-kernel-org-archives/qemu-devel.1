Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC77C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3991D21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991D21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdg0h-0002Fw-G9
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45653)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdfyV-0001J3-Jy
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdfyU-0001Wk-4J
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdfyT-0001W3-Rq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:10:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E14B3091DCF;
 Wed, 19 Jun 2019 19:10:25 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9142D60FAB;
 Wed, 19 Jun 2019 19:10:24 +0000 (UTC)
Date: Wed, 19 Jun 2019 16:10:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190619191023.GB26409@habkost.net>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
 <20190612084104.34984-6-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612084104.34984-6-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 19 Jun 2019 19:10:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/9] tests/x86-cpuid: Update testcases
 in test_topo_bits() with multiple dies
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 04:41:00PM +0800, Like Xu wrote:
> The corresponding topo_bits tests are updated to support die configurations.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

This probably should be squashed into patch 4/9 to keep
bisectability.  I can do this while committing.

> ---
>  tests/test-x86-cpuid.c | 84 ++++++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 39 deletions(-)
> 
> diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
> index ff225006e4..1942287f33 100644
> --- a/tests/test-x86-cpuid.c
> +++ b/tests/test-x86-cpuid.c
> @@ -28,74 +28,80 @@
>  
>  static void test_topo_bits(void)
>  {
> -    /* simple tests for 1 thread per core, 1 core per socket */
> -    g_assert_cmpuint(apicid_smt_width(1, 1), ==, 0);
> -    g_assert_cmpuint(apicid_core_width(1, 1), ==, 0);
> +    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 1), ==, 0);
> +    g_assert_cmpuint(apicid_core_width(1, 1, 1), ==, 0);
> +    g_assert_cmpuint(apicid_die_width(1, 1, 1), ==, 0);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 0), ==, 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1), ==, 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 2), ==, 2);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 3), ==, 3);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 0), ==, 0);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 1), ==, 1);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 2), ==, 2);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 3), ==, 3);
>  
>  
>      /* Test field width calculation for multiple values
>       */
> -    g_assert_cmpuint(apicid_smt_width(1, 2), ==, 1);
> -    g_assert_cmpuint(apicid_smt_width(1, 3), ==, 2);
> -    g_assert_cmpuint(apicid_smt_width(1, 4), ==, 2);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 2), ==, 1);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 3), ==, 2);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 4), ==, 2);
>  
> -    g_assert_cmpuint(apicid_smt_width(1, 14), ==, 4);
> -    g_assert_cmpuint(apicid_smt_width(1, 15), ==, 4);
> -    g_assert_cmpuint(apicid_smt_width(1, 16), ==, 4);
> -    g_assert_cmpuint(apicid_smt_width(1, 17), ==, 5);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 14), ==, 4);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 15), ==, 4);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 16), ==, 4);
> +    g_assert_cmpuint(apicid_smt_width(1, 1, 17), ==, 5);
>  
>  
> -    g_assert_cmpuint(apicid_core_width(30, 2), ==, 5);
> -    g_assert_cmpuint(apicid_core_width(31, 2), ==, 5);
> -    g_assert_cmpuint(apicid_core_width(32, 2), ==, 5);
> -    g_assert_cmpuint(apicid_core_width(33, 2), ==, 6);
> +    g_assert_cmpuint(apicid_core_width(1, 30, 2), ==, 5);
> +    g_assert_cmpuint(apicid_core_width(1, 31, 2), ==, 5);
> +    g_assert_cmpuint(apicid_core_width(1, 32, 2), ==, 5);
> +    g_assert_cmpuint(apicid_core_width(1, 33, 2), ==, 6);
>  
> +    g_assert_cmpuint(apicid_die_width(1, 30, 2), ==, 0);
> +    g_assert_cmpuint(apicid_die_width(2, 30, 2), ==, 1);
> +    g_assert_cmpuint(apicid_die_width(3, 30, 2), ==, 2);
> +    g_assert_cmpuint(apicid_die_width(4, 30, 2), ==, 2);
>  
>      /* build a weird topology and see if IDs are calculated correctly
>       */
>  
>      /* This will use 2 bits for thread ID and 3 bits for core ID
>       */
> -    g_assert_cmpuint(apicid_smt_width(6, 3), ==, 2);
> -    g_assert_cmpuint(apicid_core_width(6, 3), ==, 3);
> -    g_assert_cmpuint(apicid_pkg_offset(6, 3), ==, 5);
> +    g_assert_cmpuint(apicid_smt_width(1, 6, 3), ==, 2);
> +    g_assert_cmpuint(apicid_core_offset(1, 6, 3), ==, 2);
> +    g_assert_cmpuint(apicid_die_offset(1, 6, 3), ==, 5);
> +    g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), ==, 5);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 0), ==, 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1), ==, 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2), ==, 2);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 0), ==, 0);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1), ==, 1);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2), ==, 2);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 0), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 0), ==,
>                       (1 << 2) | 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 1), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 1), ==,
>                       (1 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 2), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 2), ==,
>                       (1 << 2) | 2);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 0), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 0), ==,
>                       (2 << 2) | 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 1), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 1), ==,
>                       (2 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 2), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 2), ==,
>                       (2 << 2) | 2);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 0), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 0), ==,
>                       (5 << 2) | 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 1), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 1), ==,
>                       (5 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 2), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 2), ==,
>                       (5 << 2) | 2);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 6 * 3 + 0 * 3 + 0), ==,
> -                     (1 << 5));
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 6 * 3 + 1 * 3 + 1), ==,
> -                     (1 << 5) | (1 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 3 * 6 * 3 + 5 * 3 + 2), ==,
> -                     (3 << 5) | (5 << 2) | 2);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
> +                     1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
> +                     1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
> +                     3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
>  }
>  
>  int main(int argc, char **argv)
> -- 
> 2.21.0
> 

-- 
Eduardo

