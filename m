Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D6FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 22:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F522207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 22:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov+qj9Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F522207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlKMh-00040l-Fz
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 18:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlKLk-0003Rg-P5; Tue, 16 Jun 2020 18:46:36 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlKLi-0002SU-W3; Tue, 16 Jun 2020 18:46:36 -0400
Received: by mail-oi1-x244.google.com with SMTP id 25so20779070oiy.13;
 Tue, 16 Jun 2020 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=ayOem+4lU+iH977x8hUB19AKucI4twc82MFywwwxQTA=;
 b=Ov+qj9IaACJGHQVKdfHJ+XbjPddScbVgXavSC4N0MlKR4Z2xge6pL5P+4J9HL43iTF
 ZCkCsXzBVJAsHRlkGZnaCEcXkTjp+g7Y9lnOLVY1fT4mvfEmBhdOSGNRjOZCngWbdlRW
 /VyEwD6vimGnQdsa/WJ0reC4lYmTEd2z7Rmt4WbRoUBpERAbHehJplfiBdYIht/WiP5x
 OJvbvp5GcDWyaocQdx9ttx3R7I1O8HSiqZZ3VX+2op7t5goLqUmNoE19WXSE03/Z/ii+
 o2MRbQMKFZBaBT8sT5FePG5P4xctvFH0b5en9DyTPjDo/uRUy/M38mXkc0qj+11rAhXA
 Bwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=ayOem+4lU+iH977x8hUB19AKucI4twc82MFywwwxQTA=;
 b=qWYb3PvkgKOKmJFDPB/xDS8IGlZkZ1GlGm+etKe9GdqZK5oV2Q47RUr9JPXpV0oKiN
 mbi7pztRPhWYHbi3k6u0iyWgRK2MecJKZnQvpX9jyYUNcTmQEZ1tXZAM/hFzc2/gVb6W
 oT+/UlLGkd+iDezeY0ZiYXZTMZc19tg4ceM0p45g4vP9v0PgnKLQlnT3+5vR4nTj4m8v
 2colz2N79ray3YXkPAqf9TTv8NRQxn+g0FkfjOI0GKnO0nHiE5dHpAOxIQTQr1YQld4y
 Aiq7vy9tSlbmM+C82apPC7uLWJ8ndKZYQY7ExkO599kAsQcgSxVPsXMPrMQVOWxZiYsG
 fhLA==
X-Gm-Message-State: AOAM5314rWCLskzsIrwKcOVzRwiQmVqq9L7s/9lSsMmNhj3u+wFhx2dq
 cF9Ja7Ra+aD9JlJMrNVLlug=
X-Google-Smtp-Source: ABdhPJxssDwdQ3PsS/n23at4b9IfHpohWX3Gvu1xeD1y7qB+LPGtWs8Yzhx7SikHbgrvXeomnuh4Gw==
X-Received: by 2002:aca:4b88:: with SMTP id y130mr5232322oia.36.1592347593156; 
 Tue, 16 Jun 2020 15:46:33 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id h18sm4484757oti.27.2020.06.16.15.46.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 15:46:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200616184136.27463d2e@bahia.lan>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
 <20200616141547.24664-73-mdroth@linux.vnet.ibm.com>
 <20200616171440.172f1173@bahia.lan> <2182702.l5DGtSyN0k@silver>
 <20200616184136.27463d2e@bahia.lan>
Message-ID: <159234758691.15440.17375965710878676458@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 72/78] 9p: Lock directory streams with a CoMutex
Date: Tue, 16 Jun 2020 17:46:26 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Greg Kurz (2020-06-16 11:41:36)
> On Tue, 16 Jun 2020 18:09:04 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> =

> > On Dienstag, 16. Juni 2020 17:14:40 CEST Greg Kurz wrote:
> > > Cc'ing co-maintainer Christian Schoenebeck.
> > > =

> > > Christian,
> > > =

> > > If there are some more commits you think are worth being cherry picked
> > > for QEMU 4.2.1, please inform Michael before freeze on 2020-06-22.
> > =

> > Indeed, for that particular stable branch I would see the following 9p =
fixes
> > as additional candidates (chronologically top down):
> > =

> > 841b8d099c [trivial] 9pfs: local: Fix possible memory leak in local_lin=
k()
> > 846cf408a4 [maybe] 9p: local: always return -1 on error in local_unlink=
at_common
> > 9580d60e66 [maybe] virtio-9p-device: fix memleak in virtio_9p_device_un=
realize
> > 659f195328 [trivial] 9p/proxy: Fix export_flags
> > a5804fcf7b [maybe] 9pfs: local: ignore O_NOATIME if we don't have permi=
ssions
> > 03556ea920 [trivial] 9pfs: include linux/limits.h for XATTR_SIZE_MAX
> > a4c4d46272 [recommended] xen/9pfs: yield when there isn't enough room o=
n the ring
> > =

> > What do you think Greg?
> > =

> =

> AFAIK, only regressions and fixes to severe bugs (QEMU crashes, hangs, CV=
Es) go
> to stable QEMU releases. It doesn't seem to be the case for any of the co=
mmits
> listed above but I had only a quick look.

That's the main focus, but if memory leaks and other minor fixes get tagged
for stable I'll generally pull those in as well if the backport is fairly
straightforward. As that was the case with the patches above I went
ahead and pull those in.

> =

> > What's the recommended way for me to keep track of imminent stable pick=
s/
> > freezes in future?
> > =

> =

> Hmm good question. I'm usually notified when Michael posts the patch roun=
d-up
> and a 9p patch is already in the list, like for the present patch. Other =
than
> that I watch qemu-stable from time to time or the planning pages in the w=
iki.
> =

> Michael, anything better to suggest to Christian ?

I think that about covers it. You can also subscribe to the planning
pages, e.g. https://wiki.qemu.org/Planning/5.0 (by clicking the
star/"add to watchlist" icon), then you'll get notifications when
additional release/freeze dates are added. Generally it will be updated
shortly before the patch round-up gets posted to qemu-stable.

> =

> > Best regards,
> > Christian Schoenebeck
> > =

> > =

>=20

