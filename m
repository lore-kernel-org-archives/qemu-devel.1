Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05352C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EDE20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L4QnhZBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EDE20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmH5n-0001Eg-WF
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1jmD9k-0001EB-3V
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:17:52 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1jmD9i-0003YL-4t
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:17:51 -0400
Received: by mail-yb1-xb42.google.com with SMTP id 187so4616442ybq.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UTwzdRLymtwVn6UdnQK3PAdosv+ScKHHT1hAWduxwCc=;
 b=L4QnhZBOOHsZmIMqufwOZgXrl4NY0eN2CNPI+x/uHrT8+AvcEUYs7J1LsklMJyp+0J
 gqT9e0HC5bH0RGdKz0NOEAIIp6s+z2ZVXSH27z5F0HWDmvRLWAJzLe+rw5ZqKd1t+mip
 4WrWlfxktrmnumPevn/EeufvOzW82Q2u1X248=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UTwzdRLymtwVn6UdnQK3PAdosv+ScKHHT1hAWduxwCc=;
 b=m+btd3lfjGLrxe7nAYsbvkL4LfehOr+nrJBTdfZwM0qHrGHYniilKlbt3xQQD/Isc8
 Doa6c+f4+pTVQ61l0A08zknAhEJoKBu0qWRwY8C4s9iZztOGZz6qDPPsuIXl7PJhz7u1
 z68kzXQKm1SF677MuKnBAZkm3gVBimFnqtoF2qlFsq0Ef6IT9F6SCWBOOp/HFZBHRzxv
 dZRNhqEZLhhCR/5+cyzJax+ZqBQKw+kSQFsFMXy9WPdYFieObGWGtlnNyeRFqkQckT1q
 NXUE37ivbYbtVsC/cfj0qVhZg/STtjYAZ/mN62zy0iU8S0r9zFQZgkCL6ZHs1AuCYKm+
 OrKw==
X-Gm-Message-State: AOAM532/w70ABukdCkSePS0Ptv3ijtByiv7qSXkRoxsqAxzhK+k575bY
 mS14DQE0QfywpcAOM0FY+kuUiQJl9eoMSFnSlrGuXA==
X-Google-Smtp-Source: ABdhPJyF1hiGeFpX2FCa74q4gWj4hxw/oXzj6BBxFPQes7XAGsbIEoXyYtUNPzqL+7GovNMc/smSNdXUcYXYO+9NycM=
X-Received: by 2002:a25:ccd5:: with SMTP id l204mr4365141ybf.51.1592558268848; 
 Fri, 19 Jun 2020 02:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
 <20200618191655.GI2769@work-vm> <20200618192717.GE3814@redhat.com>
 <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
 <20200619083953.GB2690@work-vm>
In-Reply-To: <20200619083953.GB2690@work-vm>
From: Chirantan Ekbote <chirantan@chromium.org>
Date: Fri, 19 Jun 2020 18:17:37 +0900
Message-ID: <CAJFHJrpRGJ=myQzJtxjgQhHdbyhGXhz_N24=xJTKM4JqhhZG2g@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 5:40 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Chirantan Ekbote (chirantan@chromium.org) wrote:
>
> > We ended up working around it by prefixing "user.virtiofs." to the
> > xattr name[2], which has its own problems but there was pretty much no
> > chance that we would be able to give the fs device CAP_SYS_ADMIN in
> > the init namespace.
>
>
> What problems did you hit with that?  We should standardise the renaming
> so we make an on-disc format that's compatible.
>

I guess what I meant by problems is that it made what was previously a
simple and straightforward implementation into something more complex
and added some limitations.  For example, we now need to parse the
result of the listxattr system call and strip out the prefix from any
name in the list.  It also means that we cannot allow the guest to
directly set or remove any "user.virtiofs." xattr as this would allow
an unprivileged process in the vm to modify an xattr that it wouldn't
otherwise be allowed to modify.  On top of being a somewhat arbitrary
restriction this also means that you can't have stacked virtiofs
instances as the lower instance would reject attempts by the upper one
to set those xattrs.  These limitations aren't really a problem for us
but I can see how they might be a problem for others.

The change was also merged just yesterday so there may be other
problems with it that haven't surfaced yet.

I didn't mention it before because I figured this was something that
we brought upon ourselves as chrome os is a bit extreme about
sandboxing.  If we can come up with a standardized way to handle this
I think we'll gladly switch the chrome os implementation to use it.

Chirantan

