Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487C82086A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV51POx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487C82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Wjm-00043S-H4
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 23:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k3Wj9-0003dY-1M
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:37:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k3Wj6-0007Pz-8e
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:37:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id 93so24963922otx.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EJj9fcg261x+BsL9KIQMu8dbe5mSD5Tf+HDlhMkSLCc=;
 b=uV51POx1tXeOzzLX5aZVkZQEzmBscV+tV72twSyocxgm6mrRIx7pvOqMhRSHpdVgFh
 3HsXwWV6HKDkITteDomz7xWlS9jOkwBf35UnGsQkqRYObee/pkhRnF8bfzkaHMxaBjzF
 CGuLHFeshuxKUuOTfipihojbVcD3ZDdGvojefLj8dtMEiSSluMCptrH+KTUMeK0NfgPU
 +2wR+E7TbhB0PtAROO51IVCdiIag9qAvxPg1VncK4aPB6oUGoo4dhOVuikUZlJ7m/rmd
 zfRPYn+Ru7H57SClXnJ2X7m9MDvrV3Ul6qVqcC2HWZfaQywhABggOX2RHL4jtaytGx0z
 xiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EJj9fcg261x+BsL9KIQMu8dbe5mSD5Tf+HDlhMkSLCc=;
 b=TOlcn8PrfbMTHHsZJsyUrjfo4lTvMDf/Xox7cKZzPoDjIAeMNqOKoUGSFvb4LmclCj
 +8tVK7TngXx/8wJXR9TSsstPiV92u0I97JEIO31hw6r7yy8k/HVa2dqtTuVx8R/jBTFv
 o2zrGzII4s138LdAJ6K1FdjJRm4mcSXyJZCooH33flT7S9LawWfWpbASq5RBRlQcxgHM
 ndHrzUbbQ5t/Vzz948bgqcodSI2N8aKwi73nX5kMOgC6eznPJnHylJZxITS9Gdpf1pYd
 OVkmXzZr6Naidgw8U0iwcrAcDvDonJTKKUMtXYfOh56+5c2n5JUFmVtbnaoBtANSauNQ
 8uiA==
X-Gm-Message-State: AOAM532pd6WUhw0NbEBVxfGgO9/dsZIR0w6/BTZdR5pqjMXYFuUJ3tOa
 yIJvvaNKrbmXHvTc4gn+7/XQ2Q9z3rZRkkTAcAI=
X-Google-Smtp-Source: ABdhPJz/a59h6SSmECz1glrWYMXYD9NfOw2XhP+owhsOKGwCY6BtJb3SUMSkXVLg01kKyQ3bHH1d15vgEJuhg+PGUWg=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr5528176oth.262.1596685073677; 
 Wed, 05 Aug 2020 20:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
 <20200729101851-mutt-send-email-mst@kernel.org>
 <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
In-Reply-To: <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 5 Aug 2020 21:37:42 -0600
Message-ID: <CAFubqFvuk8234kP6H+5+HWrhkiqcF0__z8=WEU7FxuR2WZ2vnA@mail.gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Wed, Jul 29, 2020 at 9:17 PM Raphael Norwitz
<raphael.s.norwitz@gmail.com> wrote:
>
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

