Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F2C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49E3206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="H3hpmrPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49E3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFq2-0000hA-Pb
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jWFpM-0008MQ-OI; Wed, 06 May 2020 04:54:52 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jWFpL-0007Ay-8v; Wed, 06 May 2020 04:54:52 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 4909D2E150B;
 Wed,  6 May 2020 11:54:48 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 ZhCCeIzzpu-siWCe0S5; Wed, 06 May 2020 11:54:48 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588755288; bh=AKb14IwK/hcws7M/b+BhMDtXY4aWVp6lFdcge+qrnXc=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=H3hpmrPzRFJOo9bLkJaOzuhBM9kLgjN405rDbXKTk+8gAavrm5B2rbY8iYPOmkXv9
 k/Zv94T3aBqVZZn6vY43/1cQ3iTELdo28YDJ7uyo7iTyF6iRhMOOTb6V1MzoN2l+Lo
 obm+BAktBQEkNB8kzRaA3O+lOuBMhcrRH1jqwVrw=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1303::1:8])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 IyCW3YZKzh-siWaWHJE; Wed, 06 May 2020 11:54:44 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Wed, 6 May 2020 11:54:43 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 2/5] vhost: introduce wrappers to set guest notifiers
 for virtio device
Message-ID: <20200506085443.GB6213@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <70215284d3e5e39a7f195fac2af97963b00f8173.1588252862.git.dimastep@yandex-team.ru>
 <CAFubqFsYZpAVDWSyF85mgGh_+nVJERYC0p1fcFRPcx5m-P+YgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFsYZpAVDWSyF85mgGh_+nVJERYC0p1fcFRPcx5m-P+YgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:54:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
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

On Sun, May 03, 2020 at 08:36:45PM -0400, Raphael Norwitz wrote:
> I’m happy from the vhost, vhost-user-blk and vhost-user-scsi side. For
> other device types it looks pretty straightforward, but their maintainers
> should probably confirm.
> 
> Since you plan to change the behavior of these helpers in subsequent
> patches, maybe consider sending the other device types separately
> after the rest of the series has been merged? That way the changes to
> individual devices will be much easier to review.

Thanks for comments.
Agree, will make a more straightforward fix only for vhost-user-blk.
After it we can figure out how to propogate this change to other
devices.

> 
> On Thu, Apr 30, 2020 at 9:48 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > Introduce new wrappers to set/reset guest notifiers for the virtio
> > device in the vhost device module:
> >   vhost_dev_assign_guest_notifiers
> >     ->set_guest_notifiers(..., ..., true);
> >   vhost_dev_drop_guest_notifiers
> >     ->set_guest_notifiers(..., ..., false);
> > This is a preliminary step to refactor code, so the set_guest_notifiers
> > methods could be called based on the vhost device state.
> > Update all vhost used devices to use these wrappers instead of direct
> > method call.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  backends/cryptodev-vhost.c  | 26 +++++++++++++++-----------
> >  backends/vhost-user.c       | 16 +++++-----------
> >  hw/block/vhost-user-blk.c   | 15 +++++----------
> >  hw/net/vhost_net.c          | 30 +++++++++++++++++-------------
> >  hw/scsi/vhost-scsi-common.c | 15 +++++----------
> >  hw/virtio/vhost-user-fs.c   | 17 +++++++----------
> >  hw/virtio/vhost-vsock.c     | 18 ++++++++----------
> >  hw/virtio/vhost.c           | 38 ++++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio.c          | 13 +++++++++++++
> >  include/hw/virtio/vhost.h   |  4 ++++
> >  include/hw/virtio/virtio.h  |  1 +
> >  11 files changed, 118 insertions(+), 75 deletions(-)
> >

