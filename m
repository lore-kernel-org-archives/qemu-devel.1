Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73032C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C3B206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQXjBY0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C3B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAz7I-00041L-Ft
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAz6i-0003bu-DV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:21:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAz6g-0006k4-Ge
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598462465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z20/pak5feU2b+o3+dukIpQ3ZpiSQaEhnnel2tGGyT0=;
 b=SQXjBY0CpMai3BjrqpqhZBeiYa66ewFVq4Icqdj0Zw3gwykifyh0gs2kAUGctNART9Z2cu
 zRJFU2hFk5oeJo1xju2xZ7gIT09ypPzRRfChbjNmirIzrindBZKBK7Vl4nePlpX95UNPJF
 xFIO4z777WEQbXUzzpAC8HMWhYljhv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-1SLMQPPZNYG1z_DVw0zSXA-1; Wed, 26 Aug 2020 13:21:04 -0400
X-MC-Unique: 1SLMQPPZNYG1z_DVw0zSXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E75873081;
 Wed, 26 Aug 2020 17:21:02 +0000 (UTC)
Received: from work-vm (ovpn-112-133.ams2.redhat.com [10.36.112.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D554757C4;
 Wed, 26 Aug 2020 17:20:59 +0000 (UTC)
Date: Wed, 26 Aug 2020 18:20:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v5 12/12] migration/dirtyrate: Add trace_calls to make it
 easier to debug
Message-ID: <20200826172057.GE3932@work-vm>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-13-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1598319650-36762-13-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Add trace_calls to  make it easier to debug
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/dirtyrate.c  | 7 +++++++
>  migration/trace-events | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 08c46d3..3513ef3 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -23,6 +23,7 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "migration.h"
>  #include "ram.h"
> +#include "trace.h"
>  #include "dirtyrate.h"
>  
>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> @@ -55,6 +56,7 @@ static int64_t get_sample_page_period(int64_t sec)
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
>      assert(new_state < DIRTY_RATE_STATUS__MAX);
> +    trace_dirtyrate_set_state(DirtyRateStatus_str(new_state));
>      if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
>          return 0;
>      } else {
> @@ -78,6 +80,7 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>       * Only support query once for each calculation,
>       * reset as DIRTY_RATE_STATUS_UNSTARTED after query
>       */
> +    trace_query_dirty_rate_info(DirtyRateStatus_str(CalculatingState));
>      (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>                                DIRTY_RATE_STATUS_UNSTARTED);
>  
> @@ -129,6 +132,7 @@ static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
>  
>      crc = crc32(0, iov_array.iov_base, iov_array.iov_len);
>  
> +    trace_get_ramblock_vfn_hash(info->idstr, vfn, crc);
>      return crc;
>  }
>  
> @@ -246,6 +250,7 @@ static int skip_sample_ramblock(RAMBlock *block)
>       * want to sample.
>       */
>      if (ramblock_size < MIN_RAMBLOCK_SIZE) {
> +        trace_skip_sample_ramblock(block->idstr, ramblock_size);
>          return -1;
>      }
>  
> @@ -292,6 +297,7 @@ static int calc_page_dirty_rate(struct RamblockDirtyInfo *info)
>      for (i = 0; i < info->sample_pages_count; i++) {
>          crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
>          if (crc != info->hash_result[i]) {
> +            trace_calc_page_dirty_rate(info->idstr, crc, info->hash_result[i]);
>              info->sample_dirty_count++;
>          }
>      }
> @@ -317,6 +323,7 @@ static bool find_page_matched(RAMBlock *block, struct RamblockDirtyInfo *infos,
>      if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
>          infos[i].ramblock_pages !=
>              (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SHIFT_KB)) {
> +        trace_find_page_matched(block->idstr);
>          return false;
>      }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 4ab0a50..34569b9 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -312,3 +312,11 @@ dirty_bitmap_load_bits_zeroes(void) ""
>  dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
>  dirty_bitmap_load_enter(void) ""
>  dirty_bitmap_load_success(void) ""
> +
> +# dirtyrate.c
> +dirtyrate_set_state(const char *new_state) "new state %s"
> +query_dirty_rate_info(const char *new_state) "current state %s"
> +get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock name: %s, vfn: %"PRIu64 ", crc: %" PRIu32
> +calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
> +skip_sample_ramblock(const char *idstr, int64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
> +find_page_matched(const char *idstr) "ramblock %s addr or size changed"
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


