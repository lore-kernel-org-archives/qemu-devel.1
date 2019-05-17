Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D7C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFBC20833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFBC20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYdo-0007Ne-OF
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:55:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRYc8-0006Te-FO
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRYc6-0004Kb-FX
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:53:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hRYc4-0004Gu-GC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:53:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id c77so4647386wmd.1
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 01:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=oOd5lsW+s33mNgpgerYCMx4ubO3sCKAzqMa2TV10bNU=;
	b=B47I9kHJIRG8P22FFJjp+IzM9j+tKXFuOMfrHgNR6nixUdNsZ5qRggx/EthYTvY5t+
	C2k0LbjGHUOqpOiYXQcXuZsxS+rb6DUIgsmNFQc+5epEQfGMBT1Bdb39KBxqBafD3K6W
	wmnKOJPT5tzXCBJirFm/BLA0hwrn7ne3hLOKgr/ur35eHva/DDCW7Qrov+RZGLtBgDmO
	RBqpvS7yqlxy92EvERu7ZAXS+hDQyqOKIbUtzRDjOJhBMTCPSj6y5MgQ/phr/kUsLEXG
	6Nlm+VStenxctGaK0VxhMrGsFfLE0r37LUKsi0/ybZwQWhC/IW7vo+6J/kv0EPwmf8RY
	YVUQ==
X-Gm-Message-State: APjAAAU+RzgvHdRFL0dFu/JdZesieu6gUKWrBomhgLJuQABZTNFLITgs
	jLE8RMvM/Cq4khSc+KDbhCMYGw==
X-Google-Smtp-Source: APXvYqyjVqz2FfzbmCAlv/7tKNJa/P9Q0tGUzW+xTFHy7vQPGLlpX6QkqqT559R09cHQAEn2tXBHYg==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr1420480wmd.55.1558083188151;
	Fri, 17 May 2019 01:53:08 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	y132sm12976137wmd.35.2019.05.17.01.53.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 17 May 2019 01:53:07 -0700 (PDT)
Date: Fri, 17 May 2019 10:53:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190517085305.l5hjm4zd5qys3grs@steredhat>
References: <155800428514.543845.17558475870097990036.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155800428514.543845.17558475870097990036.stgit@bahia.lan>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] migration: Fix typo in
 migrate_add_blocker() error message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Juan Quintela <quintela@redhat.com>,
	qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 12:58:05PM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  migration/migration.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 609e0df5d0c0..c15e75e0eebe 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1714,7 +1714,7 @@ int migrate_add_blocker(Error *reason, Error **errp)
>      if (only_migratable) {
>          error_propagate_prepend(errp, error_copy(reason),
>                                  "disallowing migration blocker "
> -                                "(--only_migratable) for: ");
> +                                "(--only-migratable) for: ");
>          return -EACCES;
>      }

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

