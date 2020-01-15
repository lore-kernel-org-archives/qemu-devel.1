Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B897C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAB92075B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNfBNif0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAB92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrjr-0004nX-0l
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1irrj9-0003sY-HI
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1irrj8-0006Uy-CP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:05:31 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1irrj8-0006US-5v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:05:30 -0500
Received: by mail-qv1-xf44.google.com with SMTP id n8so8202155qvg.11
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=e6awgHvNmW4jZPHeB8bifVPRebmgbFlbCUDBhqY35QU=;
 b=ZNfBNif03lqRu/n/tKLQVBBiUWF+uVflcAuPTmupBYFg2YNG8P7q+D+Hee2mCsONw2
 7yNHEiKfAwlr2zhDLfArrHax6xxVz7g671jwpKF/hvAvVieIXodJCh8pM+hanbSeY0j/
 82aU7+4w4bxFjBOjSDhm9SNtm2lavmHDDaJqmgvnzVK8VjHj/5x5MzWPK+Iisjnl8FT9
 0oUQkV61Ob5pl3EsNRKJFAzP0Ug9DT6OZN7Fg1xatjWsfSkZcOrQygjW3WNr2rzsb4F6
 /WQ6LQSzK1Ljo+/Mo5Fp6I2Wx+hI8zjBwvybJDwSKqxYWuLk6nj5p5a471cvqVtOdjRV
 dyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e6awgHvNmW4jZPHeB8bifVPRebmgbFlbCUDBhqY35QU=;
 b=S14CVEv733JDH/7THtVswBKmHE1R2Av9pbYEMD3NzKA6bs24gaYZ/ZnCmNx4cdxWnv
 V0qYSZlTIEHFoQM/PuIVei46hD644haakNbEdbmCLO5FK18wdp9r7LIGQHClLOV5guA0
 eX1d2JxcE7pBwRzQC/Fmaql6BDlwmxnETywLfn7OJJ6z0vGN7jqldnoxg9R2AkjSzkWp
 Bxxmotl7NnpOTJfkYnePJt997Dh7cM2ege60W85lwyxE4jFUwxzWGjptJDAYwmB11zDv
 w9KEaiQOFIJxrizxtKOXf1b8L0K/xJ3yzPxlhlI0MahsGtjCqYHws6snesRS5ayATToe
 L4OQ==
X-Gm-Message-State: APjAAAXNOL3vq4pgrtNDqSBQHikxdJGepVtgmLKwArOyqod0+5pci0qf
 A4JqHbJRPWHqkJoP1+GJmA==
X-Google-Smtp-Source: APXvYqzc/JfSL0yllbAblZCXvVFjzV3kekdI5nIHIO3sszhj+p0N8Ft0/grw84V+HP+Kk3QTyeldwg==
X-Received: by 2002:ad4:58f2:: with SMTP id
 di18mr24115476qvb.112.1579129529033; 
 Wed, 15 Jan 2020 15:05:29 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id e3sm10177781qtb.65.2020.01.15.15.05.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Jan 2020 15:05:28 -0800 (PST)
Date: Wed, 15 Jan 2020 18:05:22 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 101/104] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
Message-ID: <20200115230522.hslcfqplmzthglvv@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-102-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-102-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:39:01PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> When running with multiple threads it can be tricky to handle
> FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
> parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
> malicious clients cannot trigger race conditions.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/fuse_i.h        |  1 +
>  tools/virtiofsd/fuse_lowlevel.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index d0679508cd..8a4a05b319 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -61,6 +61,7 @@ struct fuse_session {
>      struct fuse_req list;
>      struct fuse_req interrupts;
>      pthread_mutex_t lock;
> +    pthread_rwlock_t init_rwlock;
>      int got_destroy;
>      int broken_splice_nonblock;
>      uint64_t notify_ctr;
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index 10f478b00c..9f01c05e3e 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2431,6 +2431,19 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>      req->ctx.pid = in->pid;
>      req->ch = ch ? fuse_chan_get(ch) : NULL;
>  
> +    /*
> +     * INIT and DESTROY requests are serialized, all other request types
> +     * run in parallel.  This prevents races between FUSE_INIT and ordinary
> +     * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, and
> +     * FUSE_DESTROY and FUSE_DESTROY.
> +     */
> +    if (in->opcode == FUSE_INIT || in->opcode == CUSE_INIT ||
> +        in->opcode == FUSE_DESTROY) {
> +        pthread_rwlock_wrlock(&se->init_rwlock);
> +    } else {
> +        pthread_rwlock_rdlock(&se->init_rwlock);
> +    }
> +
>      err = EIO;
>      if (!se->got_init) {
>          enum fuse_opcode expected;
> @@ -2488,10 +2501,13 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>      } else {
>          fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
>      }
> +
> +    pthread_rwlock_unlock(&se->init_rwlock);
>      return;
>  
>  reply_err:
>      fuse_reply_err(req, err);
> +    pthread_rwlock_unlock(&se->init_rwlock);
>  }
>  
>  #define LL_OPTION(n, o, v)                     \
> @@ -2538,6 +2554,7 @@ void fuse_session_destroy(struct fuse_session *se)
>              se->op.destroy(se->userdata);
>          }
>      }
> +    pthread_rwlock_destroy(&se->init_rwlock);
>      pthread_mutex_destroy(&se->lock);
>      free(se->cuse_data);
>      if (se->fd != -1) {
> @@ -2631,6 +2648,7 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
>      list_init_req(&se->list);
>      list_init_req(&se->interrupts);
>      fuse_mutex_init(&se->lock);
> +    pthread_rwlock_init(&se->init_rwlock, NULL);
>  
>      memcpy(&se->op, op, op_size);
>      se->owner = getuid();

Looks good to me.

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

> -- 
> 2.23.0
> 
> 

