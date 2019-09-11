Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E0C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F3C20872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F3C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85vd-0005jX-S8
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i85uz-0004um-Vs
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i85ux-0008Le-Ox
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i85ux-0008L9-Jw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:56:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6960BC08C33F
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 16:56:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B9C19C6A;
 Wed, 11 Sep 2019 16:56:29 +0000 (UTC)
Date: Wed, 11 Sep 2019 17:56:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190911165627.GG24295@redhat.com>
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911164202.31136-2-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 11 Sep 2019 16:56:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
 rcu_read_lock variant
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 05:42:00PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> RCU_READ_LOCK_AUTO takes the rcu_read_lock  and then uses glib's
> g_auto infrastrcture (and thus whatever the compilers hooks are) to
> release it on all exits of the block.
> 
> Note this macro has a variable declaration in, and hence is not in
> a while loop.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/qemu/rcu.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 22876d1428..6a25b27d28 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -154,6 +154,18 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
>        }),                                                                \
>        (RCUCBFunc *)g_free);
>  
> +typedef char rcu_read_auto_t;
> +static inline void rcu_read_auto_unlock(rcu_read_auto_t *r)
> +{
> +  rcu_read_unlock();
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(rcu_read_auto_t, rcu_read_auto_unlock)
>
> +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
> +    _rcu_read_auto = 'x'; \
> +    rcu_read_lock();
> +

Functionally this works, but my gut feeling would be to follow
the design of GMutexLocker as-is:

  https://developer.gnome.org/glib/stable/glib-Threads.html#g-mutex-locker-new

so you get a use pattern of

  g_autoptr(rcu_read_locker) locker = rcu_read_locker_new();

This makes it explicit that the code is creating a variable here, which
in turns means it is clear to force unlock early with

  g_clear_pointer(&locker, rcu_read_locker_free)


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

