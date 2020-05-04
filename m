Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A4C28CBC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 00:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FF9206F0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 00:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5RL0VPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FF9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVP6z-0005ah-B7
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 20:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jVP6R-0005A0-Nb; Sun, 03 May 2020 20:36:59 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:35166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jVP6Q-0000mX-Oz; Sun, 03 May 2020 20:36:59 -0400
Received: by mail-il1-x142.google.com with SMTP id b18so9737373ilf.2;
 Sun, 03 May 2020 17:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CE5zIqN0CneabRoPFy0MqFFJnCMbDb0GZifPTEB8pac=;
 b=P5RL0VPDdNAUegvGWkXHTQiP79hWufpH242EJ/71iZUIlp3tH94EGiBfPv5Pbv7gdx
 XtuCRx3HjIOKdt1/gx0rcdqmBy/FpdHOSXNe/PKvaxrgzRriWel357LFnbeNH5ljpNjP
 UuC5zS0DeZvD3a4y5wT5lu0W45FGd7XpDpVQ4+KXtgqCnaChsO69GYwL+06sqUjtHVHg
 7Yu5ygDQ3uCD/+Tk5nFIP+VaUKjUAbxl4Fh7+JSpU/Z6bTdXvWrLzIgR4glRStijErOD
 e1ekMOsN8Xo6/dse4SVMLojtdk57uF9s8GMRG8p/0Jx0tMTyeu7AouHeuaLWjIkheQ/C
 /tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CE5zIqN0CneabRoPFy0MqFFJnCMbDb0GZifPTEB8pac=;
 b=VM94Rm3+yQ1wQdDTleqFZcAxddqT2u0jz+oipBWIMvAcf1xj9zlVTgSWWEC9Egt82F
 mQ8c9ngoRRiguIHBMyuqZt3Xvbcsfnwqhuv+zJfEin1FVevYVEd48TnwUp74nuLd0ntJ
 vY3pY15X4eNbf4B9R+PWn3bwwws29FYVyzo+jPT0qXbeNQeaN9ixcjYxDxpyJLda0Vh1
 INduJjHE1sU4jyDzCjxVI7mx20ESZWnPuat5eneKMrFZHJIrlf1IXkkbBTrYyxEDNlIt
 IFEhe85K4aC2kaRymoHpSxGqbDVUl63MFUu/6mAf+qNCD3W+NvTUWjj6sEOXoitCijV+
 SrYQ==
X-Gm-Message-State: AGi0Pub6Ho0whJ2dm56MWA98zIgjE9hegdxnR/8NYuZnmuBs8g5+i4sv
 ZLqXjLP537fjvnr97i9hifXEYhzBQV9GlTJ+MV8=
X-Google-Smtp-Source: APiQypIovlH227jMUMXEatLOEwxePgsLUlSfvALXCydl/pUig4esAKsG1F/oN2aZwirnmUhqN9kGdBxwIEJoWCs96mg=
X-Received: by 2002:a92:cb4c:: with SMTP id f12mr14552609ilq.263.1588552617043; 
 Sun, 03 May 2020 17:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <70215284d3e5e39a7f195fac2af97963b00f8173.1588252862.git.dimastep@yandex-team.ru>
In-Reply-To: <70215284d3e5e39a7f195fac2af97963b00f8173.1588252862.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sun, 3 May 2020 20:36:45 -0400
Message-ID: <CAFubqFsYZpAVDWSyF85mgGh_+nVJERYC0p1fcFRPcx5m-P+YgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vhost: introduce wrappers to set guest notifiers
 for virtio device
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I=E2=80=99m happy from the vhost, vhost-user-blk and vhost-user-scsi side. =
For
other device types it looks pretty straightforward, but their maintainers
should probably confirm.

Since you plan to change the behavior of these helpers in subsequent
patches, maybe consider sending the other device types separately
after the rest of the series has been merged? That way the changes to
individual devices will be much easier to review.

On Thu, Apr 30, 2020 at 9:48 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> Introduce new wrappers to set/reset guest notifiers for the virtio
> device in the vhost device module:
>   vhost_dev_assign_guest_notifiers
>     ->set_guest_notifiers(..., ..., true);
>   vhost_dev_drop_guest_notifiers
>     ->set_guest_notifiers(..., ..., false);
> This is a preliminary step to refactor code, so the set_guest_notifiers
> methods could be called based on the vhost device state.
> Update all vhost used devices to use these wrappers instead of direct
> method call.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  backends/cryptodev-vhost.c  | 26 +++++++++++++++-----------
>  backends/vhost-user.c       | 16 +++++-----------
>  hw/block/vhost-user-blk.c   | 15 +++++----------
>  hw/net/vhost_net.c          | 30 +++++++++++++++++-------------
>  hw/scsi/vhost-scsi-common.c | 15 +++++----------
>  hw/virtio/vhost-user-fs.c   | 17 +++++++----------
>  hw/virtio/vhost-vsock.c     | 18 ++++++++----------
>  hw/virtio/vhost.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio.c          | 13 +++++++++++++
>  include/hw/virtio/vhost.h   |  4 ++++
>  include/hw/virtio/virtio.h  |  1 +
>  11 files changed, 118 insertions(+), 75 deletions(-)
>

