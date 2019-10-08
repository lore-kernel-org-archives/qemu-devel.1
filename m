Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2305C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A788620673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A788620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqNN-0004Wj-S5
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iHqGR-0005xC-Ke
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iHqGO-0007UW-VJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iHqGO-0007Tf-Mb
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:14:56 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1C7D7EBAE
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 14:14:54 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id m17so12602495pgh.21
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vCM826/hcszwoC+8Ph2qTvE7N4HbQ/LvwAoWRfkeuwk=;
 b=DGmBrr/21I2pd83l5PKCfBKnuL1zUNhMKtcx/TxiBQ+15dup5dovBsbLpI/NJT8HDh
 p0fSkw71l+7DNeIY/iRcbfhMbri6ZtN5g/BnHQ8rV/unfvYY4IvevB1sgEiXi3/V/ajm
 PpTzH8Lkx+mSbjh6z7Tke02falqqpi5BGs6rgXYCRe1ZzX7D7g1VXOviv77UWxqre+zD
 zvDO8h6D3ajzSsDHo1vVHwEevE9e8mLHSHPf/RMRWuvlAKtlUUvGrSA6LWZ5QJ1HNxeF
 TQ1cPKEaYu4wBiELemoxeGm0b1Qj7P9/Kmq30uGk5MNXQ/kinc1jvezUsT4rGfIDwOQK
 TDkw==
X-Gm-Message-State: APjAAAXQts6snyzZ4xTDaNAr0TRIUPBCY0ySd8U7kMr/L8SfK5WUgV7i
 MTsTdEhYqUmYjCgIUi/6YBX7rmlAAVgfdy4Im53A6m7zAib50IabXvoDXLTM5Y8D9T363/021xE
 TXi3yRepCu7Z7RTY=
X-Received: by 2002:a65:6407:: with SMTP id a7mr14671226pgv.123.1570544094201; 
 Tue, 08 Oct 2019 07:14:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypSNGmWImwmUxxVxYt4/ivdFx9XdRcKTuCUJZrDLpqAXNhhTOu7ZTBI2Kbueeyx3WgzWs/ew==
X-Received: by 2002:a65:6407:: with SMTP id a7mr14671178pgv.123.1570544093822; 
 Tue, 08 Oct 2019 07:14:53 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d19sm2243140pjz.5.2019.10.08.07.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 07:14:53 -0700 (PDT)
Date: Tue, 8 Oct 2019 22:14:42 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration: Don't try and recover return path in
 non-postcopy
Message-ID: <20191008141442.GC10750@xz-x1>
References: <20191007103507.31308-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007103507.31308-1-dgilbert@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: groug@kaod.org, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 11:35:07AM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> In normal precopy we can't do reconnection recovery - but we also
> don't need to, since you can just rerun migration.
> At the moment if the 'return-path' capability is on, we use
> the return path in precopy to give a postiive 'OK' to the end
> of migration; however if migration fails then we fall into
> the postcopy recovery path and hang.  This fixes it by only
> running the return path in the postcopy case.
> 
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5f7e4d15e9..d5d9b31bb7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2481,7 +2481,7 @@ retry:
>  out:
>      res = qemu_file_get_error(rp);
>      if (res) {
> -        if (res == -EIO) {
> +        if (res == -EIO && migration_in_postcopy()) {

Makes sense!  I saw that in qemu_loadvm_state_main() we're using
(postcopy_state_get() == POSTCOPY_INCOMING_RUNNING) to check.  That
also makes sense because I think we can't really do the recover if the
migration stream failed at status like POSTCOPY_INCOMING_DISCARD even
if it switched to POSTCOPY_ACTIVE... However that should really be a
very corner case even if it's true, and afaict it's nowhere worse...

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

