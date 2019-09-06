Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB5EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 21:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E74021670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 21:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E74021670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6LW4-0000Wd-Bf
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 17:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i6LUk-0008NR-GY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i6LUh-0006Gp-Sb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i6LUh-0006FY-Kb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:10:11 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD743C054907
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 21:10:09 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so2588748wmd.9
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 14:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uzCnzpitkViVP50jnSowNzrHl8ZB4OJLECl+4agqSf0=;
 b=V+M08hfT5sLItR0wPPB4C5EhkrbDJMA9FUFvrRTWKZ7qocM7UlSY8ihthJT4qLdJf6
 DrgQ/hOHNCyEU7Il99ynVabJSayZ+Z1Ya7+uT5uj8QSRmDhycf6vZGkjHkTG3SjDOyzi
 YqGI22N30u6WiLImyBHJYRJtfYVyquxqpdiPypzXkQqirBJTcQB96Cq7oWmGAkueusMM
 +aV1+1IBkq4V9ly8v8fDFcK9/Ht0+3c996FwyIfFebh3/O+OVFEkrkRkvPVBkw+V8Z4Z
 rGk8h7i328kM3JBdoDQ2Toc1kaPQmhWGRBLOqueUcL0+h+60EK3XPTn15mYuwKiKl497
 /QOQ==
X-Gm-Message-State: APjAAAVRDfgmL9Ib0jcu15NlkenMNMjyYE8amubJW1LPxLXt6TJBxoCB
 KeApJiYriQU+kRtCRKX87sMc0zvMGI6hFaO2xtF0Sv2Eznivh5uV1+q4++5mKIwXX7YGrXB4aiB
 Ls5BuvBoy0xKnJIY=
X-Received: by 2002:adf:f846:: with SMTP id d6mr8991962wrq.67.1567804208437;
 Fri, 06 Sep 2019 14:10:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzG9vDSZtgRzxy5Qk8CFkvBCTJWO0N+bp52vKGrgPAZJdokeH/lgfhyrWVqF8Ryigj72R78+A==
X-Received: by 2002:adf:f846:: with SMTP id d6mr8991938wrq.67.1567804208156;
 Fri, 06 Sep 2019 14:10:08 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
 (host170-61-dynamic.36-79-r.retail.telecomitalia.it. [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id b3sm4985653wrw.4.2019.09.06.14.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 14:10:07 -0700 (PDT)
Date: Fri, 6 Sep 2019 23:10:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Message-ID: <20190906211005.kspfcs725lpadozg@steredhat.homenet.telecomitalia.it>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
 <20190904210100.10501-2-dmitry.fomichev@wdc.com>
 <20190906081117.asr67hq26eqqooxd@steredhat>
 <412e2d4dacac702f443ebe0b8b0871460a953b70.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412e2d4dacac702f443ebe0b8b0871460a953b70.camel@wdc.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model
 property
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 04:17:12PM +0000, Dmitry Fomichev wrote:
> On Fri, 2019-09-06 at 10:11 +0200, Stefano Garzarella wrote:
> > On Wed, Sep 04, 2019 at 05:00:57PM -0400, Dmitry Fomichev wrote:
> > > This commit adds Zoned Device Model (as defined in T10 ZBC and
> > > T13 ZAC standards) as a block driver property, along with some
> > > useful access functions.
> > > 
> > > A new backend driver permission, BLK_PERM_SUPPORT_HM_ZONED, is also
> > > introduced. Only the drivers having this permission will be allowed
> > > to open host managed zoned block devices.
> > > 
> > > No code is added yet to initialize or check the value of this new
> > > property, therefore this commit doesn't change any functionality.
> > > 
> > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > ---
> > >  block.c                   | 15 +++++++++++++++
> > >  include/block/block.h     | 19 ++++++++++++++++++-
> > >  include/block/block_int.h |  3 +++
> > >  3 files changed, 36 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block.c b/block.c
> > > index 874a29a983..69f565e1e9 100644
> > > --- a/block.c
> > > +++ b/block.c
> > > @@ -4679,6 +4679,21 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
> > >      *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
> > >  }
> > >  
> > > +BdrvZonedModel bdrv_get_zoned_model(BlockDriverState *bs)
> > > +{
> > > +    return bs->bl.zoned_model;
> > > +}
> > > +
> > > +bool bdrv_is_hm_zoned(BlockDriverState *bs)
> > > +{
> > > +    /*
> > > +     * Host Aware zone devices are supposed to be able to work
> > > +     * just like regular block devices. Thus, we only consider
> > > +     * Host Managed devices to be zoned here.
> > > +     */
> > > +    return bdrv_get_zoned_model(bs) == BDRV_ZONED_MODEL_HM;
> > > +}
> > > +
> > >  bool bdrv_is_sg(BlockDriverState *bs)
> > >  {
> > >      return bs->sg;
> > > diff --git a/include/block/block.h b/include/block/block.h
> > > index 124ad40809..28d065ed80 100644
> > > --- a/include/block/block.h
> > > +++ b/include/block/block.h
> > > @@ -271,18 +271,33 @@ enum {
> > >       */
> > >      BLK_PERM_GRAPH_MOD          = 0x10,
> > >  
> > > +    /**
> > > +     * This permission is required to open host-managed zoned block devices.
> > > +     */
> > > +    BLK_PERM_SUPPORT_HM_ZONED   = 0x20,
> > > +
> > >      BLK_PERM_ALL                = 0x1f,
> > 
> > Should we update BLK_PERM_ALL to 0x3f?
> > 
> Stefano, good catch! Will update and resend...
> 

Good!

Looking better, if we update it, maybe we should also change something in
xdbg_graph_add_edge() since there is this line:

    QEMU_BUILD_BUG_ON(1UL << (ARRAY_SIZE(permissions) - 1) != BLK_PERM_ALL + 1);

We should extend the permissions array or change this check.

Thanks,
Stefano

