Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A6AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 03:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB28E20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 03:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLzehYXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB28E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joIRE-0001cP-8g
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 23:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1joIQd-00018J-58
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 23:19:55 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:34813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1joIQb-0001r3-6O
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 23:19:54 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a80so2052357ybg.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 20:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P/0wT5AVlfJU51+aOXmXuOFRQiK5GOEuvWtw0JpdSQw=;
 b=HLzehYXPr5Tyja0osk+SAA7sNvb+Fab+4kapFvH+KvWSEWJ5IGg6C32MSsPtS4lK1Z
 uGqttIPjgSVUZvOkrpuSB32efRB83q1Z5Dew/wxxREWuwJ+lauvG4LmgB3eZKk6MsdUw
 bEL4IU0r1uDnDHLT+SJmA0E/Fp3mMUuAEAaLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P/0wT5AVlfJU51+aOXmXuOFRQiK5GOEuvWtw0JpdSQw=;
 b=VZeCS163Cqyrhi5zgvNKWa7JCzJ8KfXYo2NeC6faNsP/22Lt4y/p+HJugbEYfkpXcQ
 rq/A+tVjiwlZBXjOkX1fX4h/hxv8Ldmt3skPeYQkEbvJTaBsqnvmytAkLzAk+IzDbyAu
 ZENkAzAlVCefOOji90srC3REm80e9Y/E52gOpeGrC9rWiDOHLWQr282U+gwXMcYISU1E
 lnGh7g2BBmzT1XWD4adsNtjqaVyNzeV2dExlzG827u9tar3pMStL/095xas1x5eqZri2
 toX2OvIR6Xa+jDlyjf+++wUrY3cQhbooklJJLnnSF1O6//ajD8OI/ChsKFUiRo3/JXlU
 lKYw==
X-Gm-Message-State: AOAM533q13J5Z2ZJ794leubpMdyTaywnRenzSvABM1N1WaqGiyNP1931
 D9/Mva5fpCj9Y9phqVZZkaxf7KPqQuuXUs7Vz9+Gdg==
X-Google-Smtp-Source: ABdhPJxOI2fK9y/k2WkcPq882SYyIsC2sJOLvkYjbPix6M6XdiWsN8n1J/jIsJVcum82+cSgYTjPTMdR1UYrDogyUmw=
X-Received: by 2002:a25:b8c:: with SMTP id 134mr52632321ybl.428.1593055190376; 
 Wed, 24 Jun 2020 20:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
 <20200618191655.GI2769@work-vm> <20200618192717.GE3814@redhat.com>
 <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
 <20200619191540.GI3154@redhat.com>
In-Reply-To: <20200619191540.GI3154@redhat.com>
From: Chirantan Ekbote <chirantan@chromium.org>
Date: Thu, 25 Jun 2020 12:19:39 +0900
Message-ID: <CAJFHJroGNbfO-tXqrod_snCHcnN4NKjX8t9LTeroyiNEwjtVcQ@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=chirantan@google.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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

On Sat, Jun 20, 2020 at 4:15 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 01:46:20PM +0900, Chirantan Ekbote wrote:
> > On Fri, Jun 19, 2020 at 4:27 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Thu, Jun 18, 2020 at 08:16:55PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > > > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > > > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > > > > whitelisted set of capabilities that we require.  This improves security in
> > > > > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > > > > access to the system.
> > > > >
> > > > > Hi Stefan,
> > > > >
> > > > > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> > > > >
> > > > > overlayfs sets "trusted.overlay.*" and xattrs in trusted domain
> > > > > need CAP_SYS_ADMIN.
> > > > >
> >
> > Not just that but it needs CAP_SYS_ADMIN in the init namespace[1].  We
> > have the same problem.  Our virtiofs process has CAP_SYS_ADMIN in a
> > user namespace and it cannot set any trusted or security xattrs.  The
> > security xattrs check is at least namespace aware so you only need
> > CAP_SYS_ADMIN in the namespace that mounted the fs but that doesn't
> > help us much.
> >
> > We ended up working around it by prefixing "user.virtiofs." to the
> > xattr name[2], which has its own problems but there was pretty much no
> > chance that we would be able to give the fs device CAP_SYS_ADMIN in
> > the init namespace.
>
> Chirantan,
>
> So you ended up renaming all "trusted", "security" and "system" xattrs?
> Only "user" xattrs are complete passthrough?
>

No, we only rename "security" xattrs (except for selinux).

>
> IOW, security.selinux will be renamed to user.virtiofs.security.selinux
> on host?
>

We don't relabel security.selinux because it only requires CAP_FOWNER
in the process's user namespace and it also does its own MAC-based
checks.  Also we have some tools that label files beforehand so it
seemed easier to leave them unchanged.

Chirantan

