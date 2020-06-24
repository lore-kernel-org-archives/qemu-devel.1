Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65265C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0E920656
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cifhl5Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0E920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo76s-0004Lv-G1
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo75Q-0002Pr-9U
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:13:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo75O-0002s1-PA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593011593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F02eg/lPoU/UZDLI5IrWuLli6NFDVQKwSm7yRup67Ts=;
 b=cifhl5YcA2q8mCUnemkklnLt82aOidDSNL4/2xNzjnqeI4eRm3Gxb94TmYMOGxQ2LfloAJ
 1yGWtcerkzua3yNLio6cWuIMVGv6Pctsjse/ZxG3X3qFN9IfmKdC23dJWfxdyv+7U9P+mu
 zFnX0T6ZTkt5V5sDWdBZ2H2Zw5TsMrw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-ZK_qeNM8N76hZAm2Ar8Y2A-1; Wed, 24 Jun 2020 11:13:11 -0400
X-MC-Unique: ZK_qeNM8N76hZAm2Ar8Y2A-1
Received: by mail-wm1-f69.google.com with SMTP id h25so4977231wmb.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F02eg/lPoU/UZDLI5IrWuLli6NFDVQKwSm7yRup67Ts=;
 b=tVRISHgsk/3vgH0GzSc0yC8kC9zguy0+qLrCU0nLDdaYK5wRcG7iWuzeTtKyEKEPeP
 mLFqvLsJ+8FOQ4RV5e2nRf785h6VVSDLzqUNwzfnJMrVDHa06SSdyK/0etenebGd15A0
 oVz0Kl190yeJAcsE/vkTYt2kMTFrU5Mo4Wic9sAZ/NopKoeaADzx4S91GCVBbbeltcXx
 s+QysWvSos0HAyVlIEYAuFN32x/KTDNCfEAhxJJuS18Umxn9rblNFMN/m/4pOgs0NCJz
 tHGLEudM+Td38UzZbe1A8aGLdDxouXUPwF8zsc9YCb3FfY79JsZip5HZZbm2o65SNSg+
 d1ag==
X-Gm-Message-State: AOAM531Hne0uyVS+ptx5cXEakjrTv5KsUHobRgyiDFRButAjaUjAnJe+
 0MbgqY/iqXmTZ8nj+Try8jmIH2DZ2JKJSQM+R4lKjGVWTGMt7GZS/ashhKSkEYi7VaGIKEInkn0
 vRvsTjfy5lpL8Wq4=
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr18570498wrx.50.1593011590515; 
 Wed, 24 Jun 2020 08:13:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKkrJCSX1JKOQhejhJde06raps2uYfjplKhtom52vdezwjW/v5ZrFoHI783uabKaQ/bRNBfQ==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr18570475wrx.50.1593011590258; 
 Wed, 24 Jun 2020 08:13:10 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id j14sm27468738wrs.75.2020.06.24.08.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 08:13:09 -0700 (PDT)
Date: Wed, 24 Jun 2020 11:13:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 02/22] pci: Delete useless error_propagate()
Message-ID: <20200624111248-mutt-send-email-mst@kernel.org>
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-3-armbru@redhat.com>
 <20200622212622.GE18041@jenstp.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200622212622.GE18041@jenstp.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 11:26:22PM +0200, Jens Freimann wrote:
> On Mon, Jun 22, 2020 at 12:42:30PM +0200, Markus Armbruster wrote:
> > Cc: Jens Freimann <jfreimann@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> > hw/pci/pci.c | 3 ---
> > 1 file changed, 3 deletions(-)
> > 
> 
> Reviewed-by: Jens Freimann <jfreimann@redhat.com>
> 
> Thanks!
> 
> regards,
> Jens

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Are you merging this? Or want me to?


