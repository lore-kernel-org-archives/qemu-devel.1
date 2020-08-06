Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7DF22D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2Ehr12b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7DF22D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3YoR-0004UL-3U
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3Ynb-00043j-BY
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 01:50:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3YnY-0006Zm-8J
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 01:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+UWy6YbzIzTy9p++YdtHLleUwLNWANJZ+zCFcBQT9QY=;
 b=F2Ehr12bwoqhqDGRa7mS8DvKPYB4IwGfoVg7g+lotctovMV/wF1H50EPyghPHTrYic2bVT
 PXsHBypXhjKQQMwGWnNk2schPo3IzOxwHMv2ttlOSlZ6v9cqWr/R558KZkiB3vWkovbkoZ
 h0udJEQa+K+SdSu5P3hWGv/d2bo/nwE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-n6249_6GPRSAaot4PWfd2g-1; Thu, 06 Aug 2020 01:50:33 -0400
X-MC-Unique: n6249_6GPRSAaot4PWfd2g-1
Received: by mail-wr1-f70.google.com with SMTP id r29so9988770wrr.10
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 22:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+UWy6YbzIzTy9p++YdtHLleUwLNWANJZ+zCFcBQT9QY=;
 b=ObDePmo4HxF4nR2auRzPBRF4Cj5Bq2ODiaAhwN1CbTwuh4gmb24Fd4sc7YXrBs2+xt
 BQ8rJtanfCanu0m1mzOaMa03st+3ysJhMLJ7jtTex9akLo2n8zzP1hktdDQ1YQ8rMWcE
 FwMaPfM86YF55nFprlPNs3bqjjIMelupbqKiCYONf6jSFrOm8YtMzTlZ4AOvTcZ4WlQD
 IFwv6RJ2SJNXMp1WeAkOxWzX7F0/RHWY8k+celkwrMulb5gAyLUG6CQB2/+1crX1w5ug
 22W9O0wg/BRiCs9PKamgDBn/Vf056loKajVNXq+hCt8bVFQwwLRbcTGdRMgRWM64fa2L
 Hxbg==
X-Gm-Message-State: AOAM532lYe3oZgrx9SeW0GL0VdRuv0QgKEg6vgGR7EroL1O4witRpkrv
 kCH9r3zqobHuwvSmq8B/wgYir5Zvg2jUkTmWOttAuP93c9LcH2SnDKCSICoU5LKs41506RXy/JA
 84Zsvh4pVSx+9RWI=
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr6702816wmd.121.1596693032760; 
 Wed, 05 Aug 2020 22:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPm1GhWSLbmZ5ig9NqmOBkVYLXDGNzanJ+hFMRd3uRC21GE8GEiI/YBOoChr5UjS96jqcEuQ==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr6702796wmd.121.1596693032481; 
 Wed, 05 Aug 2020 22:50:32 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id o124sm5257698wmb.2.2020.08.05.22.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 22:50:31 -0700 (PDT)
Date: Thu, 6 Aug 2020 01:50:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
Message-ID: <20200806014525-mutt-send-email-mst@kernel.org>
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
 <20200729101851-mutt-send-email-mst@kernel.org>
 <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bit verbose. I shortened it to

A new feature, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, has been
added to the vhost-user protocol.
VMs with vhost-user device backends which support this feature will
not be subject to the current max RAM slots limit of 8 and will be able to
hot-add memory as many times as the target platform supports.

Peter, can you pls allow Raphael wiki access? I don't remember how it's done ...

On Wed, Jul 29, 2020 at 09:17:27PM -0600, Raphael Norwitz wrote:
> How about something like:
> "A new feature, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, has been
> added to the vhost-user protocol which, when negotiated, changes the
> way QEMU transmit memory regions to backend devices. Instead of
> sending all regions in a single VHOST_USER_SET_MEM_TABLE message, QEMU
> will send supporting backends individual VHOST_USER_ADD_MEM_REG and
> VHOST_USER_REM_MEM_REG messages to update the devices memory tables.
> VMs with vhost-user device backends which support this feature will
> not be subject to the max RAM slots limit of 8 and will be able to
> hot-add memory as many times as the target platform supports. Backends
> which do not support VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are
> unaffected."
> 
> I don't have permission to edit the wiki. How can I get permission? Or
> can someone post it for me?
> 
> On Wed, Jul 29, 2020 at 8:19 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 09:16:10PM -0600, Raphael Norwitz wrote:
> > > Hi mst,
> > >
> > > Looking at the current changelog
> > > https://wiki.qemu.org/ChangeLog/5.1#virtio, I don't see any mention of
> > > the VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS protocol feature. It is a
> > > user visible change so shouldn't we add a note?
> > >
> > > Thanks,
> > > Raphael
> >
> > I didn't look at updating the changelog yet.
> > Would be great if you could write up new vhost user things.
> >
> > --
> > MST
> >


