Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0497CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A7A206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/aYoqRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A7A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnw1s-0004FY-16
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 23:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnw1H-0003ov-O8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:24:15 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:37687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnw1G-0007xx-3v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:24:15 -0400
Received: by mail-lj1-x22e.google.com with SMTP id e4so957524ljn.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zATyIOC89HCqUhnBoh+lwkWVcOVUh3I8uyFWbAFlEoM=;
 b=k/aYoqRJ6SpGM7scsWsZcHmoGIprlLyky0mNM0bxVvdwLKy7eXzAEQ9NkP3DtYw4nR
 TQdxap2VMFzlvJc7mxNU9NWuXuXo5x8vtFKx9/V4b3tNDZxagESQhGTJczG19Q8YY6pc
 uxKztahkcSYM4f6IttOB9q3iydH3d5QA7exX04t9tE3uHt0j4C3Kqcvsb55J4iaX+Qkk
 4M0nebTMRqMXKY7ztHXRVnjgh5uRdSx151SPeFLRE4pWVpI1TIVl8Dgqd+1LqN4gCOjn
 u1NnUMYIC9EmRj03AjoXYn0652bEEFgYbrJQB/4DvvFy3zS7yBXHKheNulZi3P4nzlpd
 jz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zATyIOC89HCqUhnBoh+lwkWVcOVUh3I8uyFWbAFlEoM=;
 b=gjU+nJQ57ASoxrZmbw3iIcE9TKFMoIYZgViFE5O1CNtIOv4FRGNrvTbYICXjrLE+9A
 oq/6rYH+ztG2hySYDnpxfNu4Q6ztu/pUzCJE2dQPAf0Ja2taXWyaNRjR3uRgOC6ANt53
 iznEBu1Y2czUwuQJw3H3h6dWiUmj5AC25lWp+XgE3r6C1ztVtiajqOexETzl4VZigoTK
 36LelzKA5mKM2oAk0udjC5jZ+ey5PtOy7LosWdSaZWCxhHB9tPWBD53FsgODF8WN11Qw
 sgIjg6uBc5b+wkzgAAnAsWw8NkB5D0qBCk2LX+zP+vXLFGwNgxrFq7FJXReIbDwjfkkC
 f/+Q==
X-Gm-Message-State: AOAM532P4mJOvyhVTG7h8f366I6mJLRE0tCyuz+Z8/2mZE08OkXkY9C+
 mVxuOrWVREIA1WmxafLWxqg3qdbUo6Z+NRZgAiI=
X-Google-Smtp-Source: ABdhPJy82cR6TDBLKeUrr7BsPQumqJX34a+ZGAf4Ewtmd6TzkP5ojuvgG5SLPlkHR12eACs2CaeuiXrWP9f+JXzNVZY=
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr13599176ljp.368.1592969051504; 
 Tue, 23 Jun 2020 20:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKf6xpuSD3NC2bLPQN75e2pR8asu9Ey1xTGxTNeCR_1MGsnPOg@mail.gmail.com>
 <ac4dfe3b-7981-49bb-25a2-08578da150d5@ilande.co.uk>
 <CAKf6xpvs6mNowsiAzbfQGLGp0aY0zKgUD=DVpSorWHycm--J8g@mail.gmail.com>
 <87k0zykwdl.fsf@dusky.pond.sub.org> <000001d64953$f67a1f00$e36e5d00$@xen.org>
In-Reply-To: <000001d64953$f67a1f00$e36e5d00$@xen.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 23 Jun 2020 23:23:59 -0400
Message-ID: <CAKf6xpt02SndxVkhqy52z7ZPCHtOhX1R5d7JQbeC8tVauBRm4Q@mail.gmail.com>
Subject: Re: sysbus failed assert for xen_sysdev
To: Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 7:46 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>
> > -----Original Message-----
> > From: Markus Armbruster <armbru@redhat.com>
> > Sent: 23 June 2020 09:41
> > To: Jason Andryuk <jandryuk@gmail.com>
> > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>; Anthony PERARD <anthony.perard@citrix.com>; xen-
> > devel <xen-devel@lists.xenproject.org>; Paul Durrant <paul@xen.org>; QEMU <qemu-devel@nongnu.org>
> > Subject: Re: sysbus failed assert for xen_sysdev
> >
> > Jason Andryuk <jandryuk@gmail.com> writes:
> > > Then it gets farther... until
> > > qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
> > > Assertion `dev->realized' failed.
> > >
> > > dev->id is NULL. The failing device is:
> > > (gdb) p *dev.parent_obj.class.type
> > > $12 = {name = 0x555556207770 "cfi.pflash01",
> > >
>
> Having commented out the call to xen_be_init() entirely (and xen_bus_init() for good measure) I also get this assertion failure, so
> I don't think is related.

Yes, this is something different.  pc_pflash_create() calls
qdev_new(TYPE_PFLASH_CFI01), but it is only realized in
pc_system_flash_map()...  and pc_system_flash_map() isn't called for
Xen.

Removing the call to pc_system_flash_create() from pc_machine_initfn()
lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
there since accelerators have not been initialized yes, I guess?

Regards,
Jason

