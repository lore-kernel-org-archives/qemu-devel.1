Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3746AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019B72068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bo5KGrvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019B72068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuEu-0002hf-5Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1juuEN-0002JD-1O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:54:35 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1juuEL-000294-De
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:54:34 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 133so6046778ybu.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2zr3G2whJ2dYSC9oe3BTN0sDp3h6IsEmVrP5S8XUwHA=;
 b=Bo5KGrvy/Qb+MDrk/9R7pPrs9xyo7BeDDpRrgspaSzNMlp3+5YqUQKsLZs/aNMiIh2
 GJzIhXsfpz+i1PAYAxwRZVwfv5zGOuCkgtgyrYxbX6Xxlm3PKK7ProvTWmWr7Nh5Iri1
 Rua345MWk8R/zxemnIWNMTOSTirUh6lakDccA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2zr3G2whJ2dYSC9oe3BTN0sDp3h6IsEmVrP5S8XUwHA=;
 b=CiLU8Cw9lInnUG34eY6lIOfDgraNh7efv4sf6ZLLI9YkC4OottwxsgsMbtCKuBgIKo
 YwNB5TcIxzu8VIGiXbPXWzCt0XkyE35gkwq6aNvDkxyJYgHZDA+9bW8YDLt/M0R3KVHJ
 Ro/YhdMyuUZBh0+9UFzL3XMkuKj3U8gbLnXMYI4pZRXFao/yHKd8vmiifC+SXd0ea21+
 7+izYnhtP8A43kykaljCKLbwrVD51JBQI79O6968ZKiXnLiF0i3ekF9sKo6qU6xAJYd2
 FIxVDLRQkJxULkVfmrzFzD1qbD8yVYTRnf6RlE+yDQzSfWaGuI6PnuIpW0sur+fgZRWL
 F3AQ==
X-Gm-Message-State: AOAM533M46tzkPa+0Conp1ZfUfK2Gt/BHDN+22bhmlM0gPoVzgfpSCYB
 4AFQSOfKzsX+PQh2RYW4DHGPQ8jP/QsYZSClkF0pIg==
X-Google-Smtp-Source: ABdhPJwon9gF1a5O+EQ4B5FQTSLdOKPPuV73ZY20NRkocU4R6p9hBGYQaXdLdH2HUQT4Go4gox/1l5pul7HzclAfMdA=
X-Received: by 2002:a25:df81:: with SMTP id
 w123mr129770269ybg.428.1594630470970; 
 Mon, 13 Jul 2020 01:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
 <20200618191655.GI2769@work-vm> <20200618192717.GE3814@redhat.com>
 <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
 <20200619191540.GI3154@redhat.com>
 <CAJFHJroGNbfO-tXqrod_snCHcnN4NKjX8t9LTeroyiNEwjtVcQ@mail.gmail.com>
 <20200625125508.GB149340@redhat.com>
In-Reply-To: <20200625125508.GB149340@redhat.com>
From: Chirantan Ekbote <chirantan@chromium.org>
Date: Mon, 13 Jul 2020 17:54:19 +0900
Message-ID: <CAJFHJrpwvEMa_OkxRg3XHXp+=Wuzwwc8shhCZd3xDsmVVJG7aw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=chirantan@google.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jun 25, 2020 at 12:19:39PM +0900, Chirantan Ekbote wrote:
> [..]
> > > Chirantan,
> > >
> > > So you ended up renaming all "trusted", "security" and "system" xattrs?
> > > Only "user" xattrs are complete passthrough?
> > >
> >
> > No, we only rename "security" xattrs (except for selinux).
> >
> > >
> > > IOW, security.selinux will be renamed to user.virtiofs.security.selinux
> > > on host?
> > >
> >
> > We don't relabel security.selinux because it only requires CAP_FOWNER
> > in the process's user namespace and it also does its own MAC-based
> > checks.  Also we have some tools that label files beforehand so it
> > seemed easier to leave them unchanged.
>
> If we rename selinux xattr also, then we can support selinux both in
> guest and host and they both can have their own independent policies.
>

This works as long as you don't need to support setfscreatecon, which
exists to guarantee that an inode is atomically created with the
correct selinux context.  It's kind of possible for files with
O_TMPFILE + fsetxattr + linkat but there is no equivalent for
directories.  You're basically forced to create the directory and then
set the xattr and while it's possible to prevent other threads in the
server from seeing the unfinished directories with a rwlock or similar
there is no protection against power loss.  If the machine loses power
after the directory is created but before the selinux xattr is set
then that directory will have the wrong selinux context and the guest
would need to run restorecon at boot to assign the correct label.

> Otherwise we either have to disable selinux on host (if we want to
> support it in guest) or somehow guest and how policies will have
> to know about each other and be able to work together (which will
> be hard for a generic use case).

Yes, I agree this is hard to do for a generic case but unfortunately
the more I understand how selinux works the less I feel that it works
well with a passthrough style file system.  As you said it either
needs to be turned off on the host or the host and guest need to work
together.

Chirantan

