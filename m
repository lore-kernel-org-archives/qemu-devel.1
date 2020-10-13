Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E55C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8E32080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUJHNXm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8E32080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHGy-00083m-N0
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSHG2-0007Wb-9M
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSHG0-0000UP-GF
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602583811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=20Tnhwv58I+CBp820CK39SUNm4kh2KWvpA7aQkNlgIY=;
 b=TUJHNXm5ofk0Ih9Zz9aVtnDVK0oRDT7xzNxpdW92R18sTSMc2EG/MKkizdCevDlQCMP0Hq
 0KrVp+TX5cb+RydAAboK6z8L4BV8xFFHHIn0IjMQb8GcnuybEyZHlYYaJ2aN4eW9mIX4ml
 V9EaiHoupudWc09aP8NXEvupuPgMeOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-8g-p5NIONciuG_CqfuPNjg-1; Tue, 13 Oct 2020 06:10:10 -0400
X-MC-Unique: 8g-p5NIONciuG_CqfuPNjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90B1886ABD2;
 Tue, 13 Oct 2020 10:10:08 +0000 (UTC)
Received: from work-vm (ovpn-114-238.ams2.redhat.com [10.36.114.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 569FF27BD2;
 Tue, 13 Oct 2020 10:10:06 +0000 (UTC)
Date: Tue, 13 Oct 2020 11:10:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v2 3/8] migration: Add spaces around operator
Message-ID: <20201013101003.GC2920@work-vm>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-4-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1602508140-11372-4-git-send-email-yubihong@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bihong Yu (yubihong@huawei.com) wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>

Yes that's OK, I'm a bit sturprised we need the space afte rthe * in the
VMStateDescription case, I wouldn't necessarily go and change them all.



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c    |  4 ++--
>  migration/postcopy-ram.c |  2 +-
>  migration/ram.c          |  2 +-
>  migration/savevm.c       |  2 +-
>  migration/vmstate.c      | 10 +++++-----
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0575ecb..e050f57 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2478,8 +2478,8 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
>       * Since we currently insist on matching page sizes, just sanity check
>       * we're being asked for whole host pages.
>       */
> -    if (start & (our_host_ps-1) ||
> -       (len & (our_host_ps-1))) {
> +    if (start & (our_host_ps - 1) ||
> +       (len & (our_host_ps - 1))) {
>          error_report("%s: Misaligned page request, start: " RAM_ADDR_FMT
>                       " len: %zd", __func__, start, len);
>          mark_source_rp_bad(ms);
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 0a2f88a8..eea92bb 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -403,7 +403,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
>                       strerror(errno));
>          goto out;
>      }
> -    g_assert(((size_t)testarea & (pagesize-1)) == 0);
> +    g_assert(((size_t)testarea & (pagesize - 1)) == 0);
>  
>      reg_struct.range.start = (uintptr_t)testarea;
>      reg_struct.range.len = pagesize;
> diff --git a/migration/ram.c b/migration/ram.c
> index 6ed4f9e..0aea78f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1563,7 +1563,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
>          rs->last_req_rb = ramblock;
>      }
>      trace_ram_save_queue_pages(ramblock->idstr, start, len);
> -    if (start+len > ramblock->used_length) {
> +    if (start + len > ramblock->used_length) {
>          error_report("%s request overrun start=" RAM_ADDR_FMT " len="
>                       RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
>                       __func__, start, len, ramblock->used_length);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d2e141f..9e95df1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -521,7 +521,7 @@ static const VMStateDescription vmstate_configuration = {
>          VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
>          VMSTATE_END_OF_LIST()
>      },
> -    .subsections = (const VMStateDescription*[]) {
> +    .subsections = (const VMStateDescription * []) {
>          &vmstate_target_page_bits,
>          &vmstate_capabilites,
>          &vmstate_uuid,
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index bafa890..e9d2aef 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -32,13 +32,13 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
>      if (field->flags & VMS_ARRAY) {
>          n_elems = field->num;
>      } else if (field->flags & VMS_VARRAY_INT32) {
> -        n_elems = *(int32_t *)(opaque+field->num_offset);
> +        n_elems = *(int32_t *)(opaque + field->num_offset);
>      } else if (field->flags & VMS_VARRAY_UINT32) {
> -        n_elems = *(uint32_t *)(opaque+field->num_offset);
> +        n_elems = *(uint32_t *)(opaque + field->num_offset);
>      } else if (field->flags & VMS_VARRAY_UINT16) {
> -        n_elems = *(uint16_t *)(opaque+field->num_offset);
> +        n_elems = *(uint16_t *)(opaque + field->num_offset);
>      } else if (field->flags & VMS_VARRAY_UINT8) {
> -        n_elems = *(uint8_t *)(opaque+field->num_offset);
> +        n_elems = *(uint8_t *)(opaque + field->num_offset);
>      }
>  
>      if (field->flags & VMS_MULTIPLY_ELEMENTS) {
> @@ -54,7 +54,7 @@ static int vmstate_size(void *opaque, const VMStateField *field)
>      int size = field->size;
>  
>      if (field->flags & VMS_VBUFFER) {
> -        size = *(int32_t *)(opaque+field->size_offset);
> +        size = *(int32_t *)(opaque + field->size_offset);
>          if (field->flags & VMS_MULTIPLY) {
>              size *= field->size;
>          }
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


