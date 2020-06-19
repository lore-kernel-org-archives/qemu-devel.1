Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5918420771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVrKimvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5918420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmH7P-0004Oi-Io
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1jm8vE-0003Gb-I9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 00:46:36 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1jm8vC-0002Ow-GG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 00:46:36 -0400
Received: by mail-yb1-xb44.google.com with SMTP id b15so4276668ybg.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qkZMChTpjmpiircTNbleeFuFN4LWyjzVvy5YsQ4XKmc=;
 b=dVrKimvLFatJBdowK+kpP0T3C6/8ZmWCdkN7sSg8BnO+4Yh8EAcQsOnFOYpYLqe0VV
 cAzUF+rQaxHdW7RL4Yyn7dVRiPsSLfYWD5njQAGBFxKYPASPh4Aqyhb8bB2x724X5QhO
 0q+VYIGXcaM5dQePB2msEmlw6+4o8X7NGHDiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qkZMChTpjmpiircTNbleeFuFN4LWyjzVvy5YsQ4XKmc=;
 b=Lb+IN/7rAZjwyZ/qyhkTZOE/2pnmhYN9ol50TgizGcVParJaeenntSH7VlT2h6XVi0
 si+QaQxK1eCkLQTZuEXel7uXSrpvXSwVrTAPH8nVOUi03gEkXAf/VTFSW91TdnaoZXpo
 cY953h1SvhhG7H4627LJUY1efPrgxZl2+0UylTIyMhH38Pem9EBTQ05Xk2khdGVDNlNY
 ojxdELzawcHLfCCDuvLBVtg4rb1Ds3XgYZmRJhF8RnhAMMdUKOQyBucYL6oLDX3uOFJq
 yyJAEKFAp9Z7pGhwYJ97GJYWyHjsw+8gVRwgRht4mCjOli3lp/zOV05eH3PiEM+IOQBo
 qNNA==
X-Gm-Message-State: AOAM5332Vhq3l/18rHpNw2JEbZ8kMiPZXIvVDexawvYUXGHvU/0rSasX
 440TluI6Tz75yMGp00KnHt5MSWuRZ1Ijxk02yrQh3Q==
X-Google-Smtp-Source: ABdhPJyeczNPJF91xVM3Ki1O2RPBwo5qeGgdd/57BfRGMvjFrDbtmUetfj9e+Tp8Kiqso77KFqvpQ+NwcrEKQvb0Hak=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr3432821ybm.496.1592541991884; 
 Thu, 18 Jun 2020 21:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
 <20200618191655.GI2769@work-vm> <20200618192717.GE3814@redhat.com>
In-Reply-To: <20200618192717.GE3814@redhat.com>
From: Chirantan Ekbote <chirantan@chromium.org>
Date: Fri, 19 Jun 2020 13:46:20 +0900
Message-ID: <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=chirantan@google.com; helo=mail-yb1-xb44.google.com
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
X-Mailman-Approved-At: Fri, 19 Jun 2020 09:29:13 -0400
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

On Fri, Jun 19, 2020 at 4:27 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jun 18, 2020 at 08:16:55PM +0100, Dr. David Alan Gilbert wrote:
> > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > > whitelisted set of capabilities that we require.  This improves security in
> > > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > > access to the system.
> > >
> > > Hi Stefan,
> > >
> > > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> > >
> > > overlayfs sets "trusted.overlay.*" and xattrs in trusted domain
> > > need CAP_SYS_ADMIN.
> > >

Not just that but it needs CAP_SYS_ADMIN in the init namespace[1].  We
have the same problem.  Our virtiofs process has CAP_SYS_ADMIN in a
user namespace and it cannot set any trusted or security xattrs.  The
security xattrs check is at least namespace aware so you only need
CAP_SYS_ADMIN in the namespace that mounted the fs but that doesn't
help us much.

We ended up working around it by prefixing "user.virtiofs." to the
xattr name[2], which has its own problems but there was pretty much no
chance that we would be able to give the fs device CAP_SYS_ADMIN in
the init namespace.


[1]: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/5e857ce6eae7ca21b2055cca4885545e29228fe2/fs/xattr.c#116
[2]: https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/2243111

