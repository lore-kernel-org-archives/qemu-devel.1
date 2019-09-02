Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD20CC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 11:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B032168B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 11:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B032168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4kr4-0001Dy-R8
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 07:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i4kqA-0000co-ST
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i4kq9-0007dS-8E
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:49:46 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:33576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i4kq9-0007d0-2g
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:49:45 -0400
Received: from player787.ha.ovh.net (unknown [10.108.35.185])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 02B95141371
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 13:49:42 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id F2F67970D587;
 Mon,  2 Sep 2019 11:49:36 +0000 (UTC)
Date: Mon, 2 Sep 2019 13:49:34 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190902134934.6b013f1a@bahia.lan>
In-Reply-To: <1985382.8LBUmpxoXr@silver>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <50fc6fbbfd80c25d2ad1752fb945cdfc7d847f20.1566503584.git.qemu_oss@crudebyte.com>
 <20190830142238.4dbf65c8@bahia.lan> <1985382.8LBUmpxoXr@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 132293241500113216
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.60
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 01 Sep 2019 20:56:16 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 30. August 2019 14:22:38 CEST Greg Kurz wrote:
> > Some more comments below.
> [snip]
> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index 8cc65c2c67..c96ea51116 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > > @@ -25,6 +25,7 @@
> > > 
> > >  #include "trace.h"
> > >  #include "migration/blocker.h"
> > >  #include "sysemu/qtest.h"
> [snip]
> > > @@ -3672,8 +3807,13 @@ int v9fs_device_realize_common(V9fsState *s, const
> > > V9fsTransport *t,> 
> > >          goto out;
> > >      
> > >      }
> > > 
> > > +    s->root_ino = stat.st_ino;
> > 
> > This isn't used anywhere. It looks like a leftover of the readdir fix
> > in v5.
> 
> Yes, both correct. I intentionally left it though, since I found it a natural 
> complement always capturing the root inode along to the root device.
> 

Fair enough. The local backend opens an fd to the root directory, to be used by
any access to the 9p share. I think root_dev/root_ino should be obtained with fstat()
on this fd, to be sure they are consistent. Maybe add an extra struct stat * argument
to the init function ? I'd rather see this done as a preparatory "backend to cache
9p root device/inode during init" patch.

> > >      s->dev_id = stat.st_dev;
> > > 
> > > +    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
> > > +    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
> > > +    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
> > > +
> > > 
> > >      s->ctx.fst = &fse->fst;
> > >      fsdev_throttle_init(s->ctx.fst);
> > > 
> > > @@ -3687,6 +3827,7 @@ out:
> > >          }
> > >          g_free(s->tag);
> > >          g_free(s->ctx.fs_root);
> > > 
> > > +        qpp_table_destroy(&s->qpp_table);
> > > 
> > >          v9fs_path_free(&path);
> > >      
> > >      }
> > >      return rc;
> > > 
> > > @@ -3699,6 +3840,7 @@ void v9fs_device_unrealize_common(V9fsState *s,
> > > Error **errp)> 
> > >      }
> > >      fsdev_throttle_cleanup(s->ctx.fst);
> > >      g_free(s->tag);
> > > 
> > > +    qpp_table_destroy(&s->qpp_table);
> > > 
> > >      g_free(s->ctx.fs_root);
> > >  
> > >  }
> > > 
> > > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > > index 5e316178d5..a283b0193e 100644
> > > --- a/hw/9pfs/9p.h
> > > +++ b/hw/9pfs/9p.h
> > > @@ -8,6 +8,7 @@
> > > 
> > >  #include "fsdev/9p-iov-marshal.h"
> > >  #include "qemu/thread.h"
> > >  #include "qemu/coroutine.h"
> > > 
> > > +#include "qemu/qht.h"
> > > 
> > >  enum {
> > >  
> > >      P9_TLERROR = 6,
> > > 
> > > @@ -235,6 +236,15 @@ struct V9fsFidState
> > > 
> > >      V9fsFidState *rclm_lst;
> > >  
> > >  };
> > > 
> > > +#define QPATH_INO_MASK        ((1ULL << 48) - 1)
> > > +
> > > +/* QID path prefix entry, see stat_to_qid */
> > > +typedef struct {
> > > +    dev_t dev;
> > > +    uint16_t ino_prefix;
> > > +    uint16_t qp_prefix;
> > > +} QppEntry;
> > > +
> > > 
> > >  struct V9fsState
> > >  {
> > >  
> > >      QLIST_HEAD(, V9fsPDU) free_list;
> > > 
> > > @@ -256,7 +266,10 @@ struct V9fsState
> > > 
> > >      Error *migration_blocker;
> > >      V9fsConf fsconf;
> > >      V9fsQID root_qid;
> > > 
> > > +    ino_t root_ino;
> > 
> > Thinking again, I'm wondering if root_ino and dev_id could be used
> > instead of root_qid in v9fs_walk()... Would you have a look at that
> > if you decide to fix the readdir issue ?
> 
> I keep it in mind when looking at the postponed readdir() issue again.
> 
> > >      dev_t dev_id;
> > > 
> > > +    struct qht qpp_table;
> > > +    uint16_t qp_prefix_next;
> > > 
> > >  };
> > >  
> > >  /* 9p2000.L open flags */
> > > 
> 


