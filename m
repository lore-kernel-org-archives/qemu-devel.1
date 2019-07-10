Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D882C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7964320844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7964320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlEX7-0002ea-Nn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hlEW4-0001rk-I2
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hlEW2-0008Hf-Lq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:28:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hlEW1-0008FB-HI
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:28:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id a10so2924390wrp.9
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=wjg6uka/qdYs+kgByh83SXdL6VqHhbqagArd0pwvxzg=;
 b=jjObKTfOF3eIPmwIKDxTc8Mw7oL1KsuWGRBkLsabHVMVRV+XRMT/GiA06DlGgEoAaJ
 ujHHC9koR5dNfBf+OmhDyOfMTW/du2xHDSs1pFCo7Z2Q0CxS+j518U/mw6m2gK1kRAgX
 7FAgTDMbIfTHWF6HHr9uK75ykCJo0zIuI/m0NedWmLPtQ+C6IHdGfp7QZOZxA86ktDIx
 yAdwDwE2dSn/YCdbNdAvWr9LFSszAF48mbpuzNe8aNb+MruT/Dv59XAFagPCSk2cPsR+
 HkVAIM80atExi3JlVSAU61EMjL2ZEeGbB1PvhJeMziFA3odM5Pkxvkg6FS4GKBXGWVxi
 83gw==
X-Gm-Message-State: APjAAAXM4ZQH6g1JSQMO1NfoIA8regoefteKOKE1ulPLajl+cJvLKVpb
 hl5U/D4H8KnI1aFQzhjFbNIoOg==
X-Google-Smtp-Source: APXvYqy6XT5Wyie9uLyuHxSQscHaLbPT1V7LeAJYGZ7fIuoXTCTBj9nBfJiCGQ6KU1GVvWcdt89nLQ==
X-Received: by 2002:adf:db07:: with SMTP id s7mr30834563wri.10.1562772495629; 
 Wed, 10 Jul 2019 08:28:15 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id r21sm5745919wrc.83.2019.07.10.08.28.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 08:28:14 -0700 (PDT)
Date: Wed, 10 Jul 2019 17:28:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com
Message-ID: <20190710152812.mtufcgjp6hfhosik@steredhat>
References: <20190705093258.47856-1-sgarzare@redhat.com>
 <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
 <20190705104318.dngmmu3lpuvbe2nh@steredhat>
 <CA+aFP1AgNGJMdAG_E23Q-rf2Gt1rpeKjDfrk1PLA3f4XiUkGtw@mail.gmail.com>
 <754459cc-08c7-6cce-02c6-10f765cb9d00@redhat.com>
 <9438ac63-949b-9e08-42a2-4b4ff2c778f8@redhat.com>
 <CA+aFP1AW9yv+_4H6M4Pq-E2ehP7KHvULm3xogqnvvZUzDdEw0g@mail.gmail.com>
 <20190709130948.ivvncgyu2wp35s3n@steredhat>
 <ac488740-6026-e98f-f702-a9d7808d5d41@redhat.com>
 <CA+aFP1A9J3L5aPwm9rQtEqHHrUT0JQ+Py0KUqmhWU9eY=_FWXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+aFP1A9J3L5aPwm9rQtEqHHrUT0JQ+Py0KUqmhWU9eY=_FWXg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 09, 2019 at 09:42:14PM -0400, Jason Dillaman wrote:
> On Tue, Jul 9, 2019 at 11:32 AM Max Reitz <mreitz@redhat.com> wrote:
> > On 09.07.19 15:09, Stefano Garzarella wrote:
> > >
> > > Max, Jason, thanks for the details!
> > >
> > > If you agree, I'll try to implement something similar, iterating on all
> > > snapshots.
> >
> > Yes, that should work.
> >
> > > What about metadata?
> > > I saw some APIs (e.g. rbd_metadata_list()) that allow us to get the metadata.
> > > An idea could be to iterate over them and sum the keys-values size returned,
> > > but I'm not sure they are returned in the same format as they are stored.
> >
> > I wouldn’t mind ignoring metadata too much.  If you can get something to
> > work, even better, but I don’t consider that too important.
> 
> I don't think it's a good idea to attempt to estimate it. If there is
> enough desire, we can always add a supported "disk-usage" API method
> that takes into account things like the image metadata, object-map,
> journaling, etc overhead. However, I wouldn't expect it to be anywhere
> near the actual block usage (unless something has gone terribly wrong
> w/ journaling and it fails to trim your log).

Okay, so for now, I'll skip the metadata and if you think can be useful
to add "disk-usage" API in RBD, I'll use it later.

Thanks,
Stefano

