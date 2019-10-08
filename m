Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03237C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD572070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD572070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHupP-0000OQ-Ux
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 15:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iHuoF-0007ug-5c
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iHuoD-0002ai-AA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iHuoD-0002aM-4O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23A664E83E;
 Tue,  8 Oct 2019 19:06:08 +0000 (UTC)
Received: from work-vm (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA1160BE2;
 Tue,  8 Oct 2019 19:06:06 +0000 (UTC)
Date: Tue, 8 Oct 2019 20:06:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/3] migration/postcopy: postpone setting PostcopyState
 to END
Message-ID: <20191008190604.GM3441@work-vm>
References: <20191006000249.29926-1-richardw.yang@linux.intel.com>
 <20191006000249.29926-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006000249.29926-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 08 Oct 2019 19:06:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
> There are two places to call function postcopy_ram_incoming_cleanup()
> 
>     postcopy_ram_listen_thread on migration success
>     loadvm_postcopy_handle_listen one setup failure
> 
> On success, the vm will never accept another migration. On failure,
> PostcopyState is transited from LISTENING to END and would be checked in
> qemu_loadvm_state_main(). If PostcopyState is RUNNING, migration would
> be paused and retried.
> 
> Currently PostcopyState is set to END in function
> postcopy_ram_incoming_cleanup(). With above analysis, we can take this
> step out and postpone this till the end of listen thread to indicate the
> listen thread is done.
> 
> This is a preparation patch for later cleanup.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Yes, I think that's OK - I couldn't see anywhere that's currently
checking the state in between.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/postcopy-ram.c | 2 --
>  migration/savevm.c       | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a394c7c3a6..5da6de8c8b 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -577,8 +577,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>          }
>      }
>  
> -    postcopy_state_set(POSTCOPY_INCOMING_END, NULL);
> -
>      if (mis->postcopy_tmp_page) {
>          munmap(mis->postcopy_tmp_page, mis->largest_page_size);
>          mis->postcopy_tmp_page = NULL;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index eaa4cf58ef..dcad8897a3 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1837,6 +1837,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>  
>      rcu_unregister_thread();
>      mis->have_listen_thread = false;
> +    postcopy_state_set(POSTCOPY_INCOMING_END, NULL);
> +
>      return NULL;
>  }
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

