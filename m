Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47081C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B345216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Bt4w3JDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B345216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4VCy-0007jd-Vy
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 15:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4V1R-0003lb-LX
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 14:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4V1Q-00064d-GG
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 14:56:21 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:43671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i4V1Q-00062Y-58
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 14:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X5dSO7lPdktg7bnCc3bzU/VNQ1t3hOQErNbkr0eziLA=; b=Bt4w3JDAHHkIrt9xUSOXizyi5V
 rFS6zLNNqiKwDMn0ef3elkwp5TxxfBwULLCNiK//TWPIvmFbkr9XyCUdDTsgL8KMotUl6zubDZxGQ
 VBppBxc8r8xmTxfAPbYdKggXLygnw9/d/yPYfpvgZpZRnuw3rz9mNAOwPNKNuOIET3zEP2WVgSKG6
 lxyTRugosphRQhvMaZ6bgE8GxYmdRHmUDPpLhsCigmLDNy8DJxhMTTV9m+IbJuZwqpZgpZLshd0dy
 YxSG8hSpQ5PkyDAKwg/Ojxo9fHHWr4HdKb/5J3K6A2H0Z2s6MZH/SHF1OuH/2VYgnJ/w+Ndd56ie+
 G7dEltSKA09Nv4ih06AOpX1BBb6nv3JVFV9dxYhI9Ni8ZlAkBkXOA8rrUDtPAsHRD4/Xsa4SePIG+
 /SnzanNbhYBrl04gYMT+eWPJ45BiR444VuVNN5Y4J4RQBOisOjvwC+I9662HyrWZ0TI+2cNSoy7ld
 W+3swuVjyLW39JC9DlUpM1mOIJnKKP7KKhtExrtVSaa1dmM0pMR4W4YNtZbI+eih15t86aAxdXObs
 cIkO4cSNPwG7SjkviY2KFgNBkarH4X+S1dIOj7kQili/Dqq9SPBTfft2r0CTlyI0Occ4iZZCTBuli
 TyJ6OtS8KR/qLeeOJWB89q2NjvmvmwOn2q+wq+6iw=;
To: qemu-devel@nongnu.org
Date: Sun, 01 Sep 2019 20:56:16 +0200
Message-ID: <1985382.8LBUmpxoXr@silver>
In-Reply-To: <20190830142238.4dbf65c8@bahia.lan>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <50fc6fbbfd80c25d2ad1752fb945cdfc7d847f20.1566503584.git.qemu_oss@crudebyte.com>
 <20190830142238.4dbf65c8@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v6 2/4] 9p: Added virtfs option
 'multidevs=remap|forbid|warn'
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 30. August 2019 14:22:38 CEST Greg Kurz wrote:
> Some more comments below.
[snip]
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 8cc65c2c67..c96ea51116 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -25,6 +25,7 @@
> > 
> >  #include "trace.h"
> >  #include "migration/blocker.h"
> >  #include "sysemu/qtest.h"
[snip]
> > @@ -3672,8 +3807,13 @@ int v9fs_device_realize_common(V9fsState *s, const
> > V9fsTransport *t,> 
> >          goto out;
> >      
> >      }
> > 
> > +    s->root_ino = stat.st_ino;
> 
> This isn't used anywhere. It looks like a leftover of the readdir fix
> in v5.

Yes, both correct. I intentionally left it though, since I found it a natural 
complement always capturing the root inode along to the root device.

> >      s->dev_id = stat.st_dev;
> > 
> > +    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
> > +    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
> > +    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
> > +
> > 
> >      s->ctx.fst = &fse->fst;
> >      fsdev_throttle_init(s->ctx.fst);
> > 
> > @@ -3687,6 +3827,7 @@ out:
> >          }
> >          g_free(s->tag);
> >          g_free(s->ctx.fs_root);
> > 
> > +        qpp_table_destroy(&s->qpp_table);
> > 
> >          v9fs_path_free(&path);
> >      
> >      }
> >      return rc;
> > 
> > @@ -3699,6 +3840,7 @@ void v9fs_device_unrealize_common(V9fsState *s,
> > Error **errp)> 
> >      }
> >      fsdev_throttle_cleanup(s->ctx.fst);
> >      g_free(s->tag);
> > 
> > +    qpp_table_destroy(&s->qpp_table);
> > 
> >      g_free(s->ctx.fs_root);
> >  
> >  }
> > 
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index 5e316178d5..a283b0193e 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -8,6 +8,7 @@
> > 
> >  #include "fsdev/9p-iov-marshal.h"
> >  #include "qemu/thread.h"
> >  #include "qemu/coroutine.h"
> > 
> > +#include "qemu/qht.h"
> > 
> >  enum {
> >  
> >      P9_TLERROR = 6,
> > 
> > @@ -235,6 +236,15 @@ struct V9fsFidState
> > 
> >      V9fsFidState *rclm_lst;
> >  
> >  };
> > 
> > +#define QPATH_INO_MASK        ((1ULL << 48) - 1)
> > +
> > +/* QID path prefix entry, see stat_to_qid */
> > +typedef struct {
> > +    dev_t dev;
> > +    uint16_t ino_prefix;
> > +    uint16_t qp_prefix;
> > +} QppEntry;
> > +
> > 
> >  struct V9fsState
> >  {
> >  
> >      QLIST_HEAD(, V9fsPDU) free_list;
> > 
> > @@ -256,7 +266,10 @@ struct V9fsState
> > 
> >      Error *migration_blocker;
> >      V9fsConf fsconf;
> >      V9fsQID root_qid;
> > 
> > +    ino_t root_ino;
> 
> Thinking again, I'm wondering if root_ino and dev_id could be used
> instead of root_qid in v9fs_walk()... Would you have a look at that
> if you decide to fix the readdir issue ?

I keep it in mind when looking at the postponed readdir() issue again.

> >      dev_t dev_id;
> > 
> > +    struct qht qpp_table;
> > +    uint16_t qp_prefix_next;
> > 
> >  };
> >  
> >  /* 9p2000.L open flags */
> > 


