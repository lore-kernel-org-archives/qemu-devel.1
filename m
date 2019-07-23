Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A0FC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FBD223A0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FBD223A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpxwj-0006wP-F9
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hpxwX-0006Y4-NB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hpxwV-0002s1-NO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hpxwT-0002n5-KM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:47:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 048803084242;
 Tue, 23 Jul 2019 16:47:07 +0000 (UTC)
Received: from work-vm (ovpn-117-202.ams2.redhat.com [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B3919C67;
 Tue, 23 Jul 2019 16:47:05 +0000 (UTC)
Date: Tue, 23 Jul 2019 17:47:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190723164703.GN2719@work-vm>
References: <20190722075339.25121-1-richardw.yang@linux.intel.com>
 <20190722075339.25121-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722075339.25121-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 23 Jul 2019 16:47:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: extract ram_load_precopy
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
> After cleanup, it would be clear to audience there are two cases
> ram_load:
> 
>   * precopy
>   * postcopy
> 
> And it is not necessary to check postcopy_running on each iteration for
> precopy.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/ram.c | 73 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 27 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 6bfdfae16e..5f6f07b255 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4200,40 +4200,26 @@ static void colo_flush_ram_cache(void)
>      trace_colo_flush_ram_cache_end();
>  }
>  
> -static int ram_load(QEMUFile *f, void *opaque, int version_id)
> +/**
> + * ram_load_precopy: load a page in precopy case

This comment is wrong - although I realise you copied it from the
postcopy case; they don't just load a single page; they load 'pages'

Other than that, I think it's OK, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> + * Returns 0 for success or -errno in case of error
> + *
> + * Called in precopy mode by ram_load().
> + * rcu_read_lock is taken prior to this being called.
> + *
> + * @f: QEMUFile where to send the data
> + */
> +static int ram_load_precopy(QEMUFile *f)
>  {
> -    int flags = 0, ret = 0, invalid_flags = 0;
> -    static uint64_t seq_iter;
> -    int len = 0;
> -    /*
> -     * If system is running in postcopy mode, page inserts to host memory must
> -     * be atomic
> -     */
> -    bool postcopy_running = postcopy_is_running();
> +    int flags = 0, ret = 0, invalid_flags = 0, len = 0;
>      /* ADVISE is earlier, it shows the source has the postcopy capability on */
>      bool postcopy_advised = postcopy_is_advised();
> -
> -    seq_iter++;
> -
> -    if (version_id != 4) {
> -        return -EINVAL;
> -    }
> -
>      if (!migrate_use_compression()) {
>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>      }
> -    /* This RCU critical section can be very long running.
> -     * When RCU reclaims in the code start to become numerous,
> -     * it will be necessary to reduce the granularity of this
> -     * critical section.
> -     */
> -    rcu_read_lock();
> -
> -    if (postcopy_running) {
> -        ret = ram_load_postcopy(f);
> -    }
>  
> -    while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> +    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
>          uint8_t ch;
> @@ -4390,6 +4376,39 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          }
>      }
>  
> +    return ret;
> +}
> +
> +static int ram_load(QEMUFile *f, void *opaque, int version_id)
> +{
> +    int ret = 0;
> +    static uint64_t seq_iter;
> +    /*
> +     * If system is running in postcopy mode, page inserts to host memory must
> +     * be atomic
> +     */
> +    bool postcopy_running = postcopy_is_running();
> +
> +    seq_iter++;
> +
> +    if (version_id != 4) {
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * This RCU critical section can be very long running.
> +     * When RCU reclaims in the code start to become numerous,
> +     * it will be necessary to reduce the granularity of this
> +     * critical section.
> +     */
> +    rcu_read_lock();
> +
> +    if (postcopy_running) {
> +        ret = ram_load_postcopy(f);
> +    } else {
> +        ret = ram_load_precopy(f);
> +    }
> +
>      ret |= wait_for_decompress_done();
>      rcu_read_unlock();
>      trace_ram_load_complete(ret, seq_iter);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

