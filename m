Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83EC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1899D2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caaRwXUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1899D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1BZT-0005BN-5p
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1BYT-0003ce-Rj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1BYS-00019o-KU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:05:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1BYS-000193-GI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581350699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34RIxkxpBoTPoqvMocx2Ectb6O+UdVXCYCZ8rJhSlwY=;
 b=caaRwXUfOz/CSrqPe3h8+IUajmPMul1UvGz33u2SvYaRvey0QUOntpw0r88sRER9jsZo4h
 rBifHAK2XEVa1XP0rUbbGBl+O5G+QvFwVb1bxbL41fiSUMmu/cn6+t76Z95eFxbb+I+ooI
 8qUaonsOEytrqScU5J8Lsb+zJmDwZOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-kwOJe7xCP6WSvko1X8de2A-1; Mon, 10 Feb 2020 11:04:32 -0500
Received: by mail-wm1-f71.google.com with SMTP id n17so3399581wmk.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 08:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eLFyI3VORtpOUV6GICPIYqBzs5fFnO6XF3iRlIaU+8Q=;
 b=OE1tkEuAWhbgQfZcUzWt87RzmpvjZkKhPpf/C61EBpO8/FvnC4EpKMdU3/V9ACjvi1
 ETqKTsOq1h4OSECqknuMeeWwMcv7rczhLkVCfhDuOy/N7y4GZ8KPCn815JUGJFhIUKdZ
 gZ4pD9/p2sAqxxPyWbkbII9ORPQRltS/CbnTVQNO2/zag4yo3yFLdAVcQWa+A3VC/qz5
 RVNp1sG6XP7PIDO9T2UoW9gJVYxL8wm/h8vKLGz4G7avfhacO7ZJy4eR+d+TLOr05bQO
 EqboAMY4t0Sm/VlbjjLWi5IXht3qjo1zLHeYuIfyJFrxV9I6AJengAtQqiRxVkGWj8xH
 sTDw==
X-Gm-Message-State: APjAAAXlCcbs7wxlE6niHeymfe0x2naiVsI3CAwxkrcRpmBWfBLQ7RBs
 yFx9PKC5j3YVo43UpVNC3fHbcaJ+4emZikncmPUx48gpWf62htNpCT44pKlvcZaHPL7LLjqMoRj
 zeRpBK//cGyrU7rk=
X-Received: by 2002:a7b:c774:: with SMTP id x20mr15863748wmk.67.1581350671572; 
 Mon, 10 Feb 2020 08:04:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvwLrkEQR0eNlMkOydxZFqlCLIEelJUxiABKVW2SDGAV2txNtCNhoCsFvqUmHnf4Vh+bjpiw==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr15863730wmk.67.1581350671371; 
 Mon, 10 Feb 2020 08:04:31 -0800 (PST)
Received: from redhat.com (bzq-155-47.red.bezeqint.net. [62.219.155.47])
 by smtp.gmail.com with ESMTPSA id y12sm1133427wrw.88.2020.02.10.08.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 08:04:30 -0800 (PST)
Date: Mon, 10 Feb 2020 11:04:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 0/3] vhost-user: Lift Max Ram Slots Limitation
Message-ID: <20200210110330-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <20200206033248-mutt-send-email-mst@kernel.org>
 <20200209171442.GA14809@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200209171442.GA14809@localhost.localdomain>
X-MC-Unique: kwOJe7xCP6WSvko1X8de2A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 09, 2020 at 12:14:42PM -0500, Raphael Norwitz wrote:
> On Thu, Feb 06, 2020 at 03:33:13AM -0500, Michael S. Tsirkin wrote:
> >=20
> > On Wed, Jan 15, 2020 at 09:57:03PM -0500, Raphael Norwitz wrote:
> > >=20
> > > Changes since V1:
> > >     * Kept the assert in vhost_user_set_mem_table_postcopy, but moved=
 it
> > >       to prevent corruption
> > >     * Made QEMU send a single VHOST_USER_GET_MAX_MEMSLOTS message at
> > >       startup and cache the returned value so that QEMU does not need=
 to
> > >       query the backend every time vhost_backend_memslots_limit is ca=
lled.
> >=20
> > I'm a bit confused about what happens on reconnect.
> > Can you clarify pls?
> >=20
> >From what I can see, backends which support reconnect call vhost_dev_ini=
t,
> which then calls vhost_user_backend_init(), as vhost-user-blk does here:
> https://github.com/qemu/qemu/blob/master/hw/block/vhost-user-blk.c#L315. =
The
> ram slots limit is fetched in vhost_user_backend_init() so every time the
> device reconnects the limit should be refetched.=20

Right. Point is, we might have validated using an old limit.
Reconnect needs to verify limit did not change or at least
did not decrease.

--=20
MST


