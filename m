Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8722C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F2B20717
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F2B20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1gz-0007qI-MA
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hv1gc-0007O4-O3
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hv1gb-0000oD-RQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hv1gb-0000nn-MY
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F57A8EA22;
 Tue,  6 Aug 2019 15:47:40 +0000 (UTC)
Received: from work-vm (ovpn-117-206.ams2.redhat.com [10.36.117.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD8BD5D6D0;
 Tue,  6 Aug 2019 15:47:39 +0000 (UTC)
Date: Tue, 6 Aug 2019 16:47:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190806154737.GG3066@work-vm>
References: <20190806004648.8659-1-richardw.yang@linux.intel.com>
 <20190806004648.8659-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806004648.8659-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 06 Aug 2019 15:47:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/postcopy: use
 QEMU_IS_ALIGNED to replace host_offset
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Use QEMU_IS_ALIGNED for the check, it would be more consistent with
> other align calculations.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index d86661a015..dfbf71c580 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2956,14 +2956,12 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>      }
>  
>      while (run_start < pages) {
> -        unsigned long host_offset;
>  
>          /*
>           * If the start of this run of pages is in the middle of a host
>           * page, then we need to fixup this host page.
>           */
> -        host_offset = run_start % host_ratio;
> -        if (!host_offset) {
> +        if (QEMU_IS_ALIGNED(run_start, host_ratio)) {
>              /* Find the end of this run */
>              if (unsent_pass) {
>                  run_start = find_next_bit(unsentmap, pages, run_start + 1);
> @@ -2975,10 +2973,9 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>               * run doesn't finish at the end of a host page
>               * and we need to discard.
>               */
> -            host_offset = run_start % host_ratio;
>          }
>  
> -        if (host_offset) {
> +        if (!QEMU_IS_ALIGNED(run_start, host_ratio)) {
>              unsigned long page;
>              unsigned long fixup_start_addr = QEMU_ALIGN_DOWN(run_start,
>                                                               host_ratio);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

