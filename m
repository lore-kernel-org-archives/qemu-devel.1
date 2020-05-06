Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC95FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F651206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pBex4ISd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F651206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFna-0007j0-IR
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jWFmz-0007Er-Mi; Wed, 06 May 2020 04:52:25 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:41302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jWFmZ-0000jw-Su; Wed, 06 May 2020 04:52:23 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id E480E2E0978;
 Wed,  6 May 2020 11:51:51 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 HVVDxYXH2o-plAKpTI6; Wed, 06 May 2020 11:51:51 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588755111; bh=9jEctWQJXnju+PrJGZN8CX13p2n0yqSFKgem07NC9Vg=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=pBex4ISdsTNqe7psqKyYiuvfqG6CSWWgJeTj+JPz5XRn4uhWLLo+oWY1VnP/X7yHn
 J45z7C9S+hfUdORSieN3OxuiG/cmYeLKLVUPl288y6lNhqASeRAqy4h0Ijx31rV+IE
 us/NY81CnePBpfim5N1vgTFivkWtNbxkNryBs/jY=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1303::1:8])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 mRFohhGm89-plWu3Ssu; Wed, 06 May 2020 11:51:47 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Wed, 6 May 2020 11:51:46 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 3/5] vhost-user-blk: add mechanism to track the guest
 notifiers init state
Message-ID: <20200506085145.GA6213@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d20d6de600837aebbf644666be064f761f764832.1588252862.git.dimastep@yandex-team.ru>
 <CAFubqFsmXhB68FWEATmtat-VrANcRAdC2-YNwKiYiXvcMO15rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFsmXhB68FWEATmtat-VrANcRAdC2-YNwKiYiXvcMO15rQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 03, 2020 at 09:06:38PM -0400, Raphael Norwitz wrote:
> Apologies for mixing up patches last time. This looks good from a
> vhost-user-blk perspective, but I worry that some of these changes
> could impact other vhost device types.
> 
> I agree with adding notifiers_set to struct vhost_dev, and setting it in
> vhost_dev_enable/disable notifiers, but is there any reason notifiers_set
> can’t be checked inside vhost-user-blk?
Thanks for your review. I also have some concerns about changing current
API, but my idea was that these issues will be triggered for all
vhost-user/reconnect devices. But maybe you are right and first we
should fix vhost-user-blk issues.
I'll try to modify patch 2 and 3 in my patchset, so new notifiers_set
field will be added, but no API change will be made. Will see how it
looks.

