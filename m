Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65167C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A74F2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGSkmKny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A74F2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZSBt-0005E5-Ek
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 00:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jZSAq-0004hp-Gw
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:42:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jZSAp-0000L4-D2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589517733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5wcF/uXyRMzm37AJGvozKriaZ3MMr9zRUvzNaLolVM=;
 b=QGSkmKnyrFkJq88S30iNVF+JGBUliJttuxF+uGMF18po0Irh+nx7HePmx2sIN3TZoyoH/p
 h5l+aKJapF8ucqihhirIr47l+zp0qQdzewQS8FLpAmy904hSXas1XV3f3g9y2KFYadiGbX
 5BwdItkkWGcT7qm15xXS4D+31U/lWhg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-D3vJENDqO8Gwc2coJS4GRA-1; Fri, 15 May 2020 00:42:12 -0400
X-MC-Unique: D3vJENDqO8Gwc2coJS4GRA-1
Received: by mail-qt1-f197.google.com with SMTP id w12so1089374qto.19
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 21:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v5wcF/uXyRMzm37AJGvozKriaZ3MMr9zRUvzNaLolVM=;
 b=ftXdbddSN0Pji9AuTqmGYIam8Z+X4VSKJkY8iDQkQLeYIWFhZ2axO1uBjenPZjZ0Cv
 V979ZHSOdv6FchHTap/wLBxqZGC/7I5K8nACUQ9jmypR+mL/S1fw8CZ6zkEV8wDuITul
 ZiK3Kr8NMt0PT/N1NRzqnvpOiwkgX7nS4dqwSZULtnsf3b4mxQ88uUo4ZEWojF9a3seO
 EhzZHscoW+wS6+8ueFWjH/GYDNf/MCCvauQsaiUgqw377SlA5230gMAbNRciA0SRT7zg
 sJkP6ZqzWVr24qProWvzMt4Nr/HByIuAGtp0hpEVDgzcib6N+vpcDmJzDo8ePiu6kUJc
 OxgQ==
X-Gm-Message-State: AOAM533jGtoTpRiYW1wCncGlDn7Gc/iS4ehm8et/nqYOXKNCgOwKtQJk
 He0dSnMXBFOMMW7OK9Ah0HhAqn9JcG1OFTEL5OF8hlBI1yKTqhFSvRjkE8yEpbHlJrJ4bPea6ol
 ouz8TKhu0ZoZ6rrBX7g6+EcNSzjmruiU=
X-Received: by 2002:a0c:a90f:: with SMTP id y15mr1602038qva.211.1589517731476; 
 Thu, 14 May 2020 21:42:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtB923RueMkeHjKhzxSamVX7HpSH8oqKHQSqDFhjRY12jNZT7Whwf6QyY3JkD+p0UOBGPGxZJ18cpcPddjE0Y=
X-Received: by 2002:a0c:a90f:: with SMTP id y15mr1602023qva.211.1589517731242; 
 Thu, 14 May 2020 21:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200514140736.20561-1-mszeredi@redhat.com>
 <20200515034309.GA49087@rsjd01523.et2sqa>
In-Reply-To: <20200515034309.GA49087@rsjd01523.et2sqa>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 15 May 2020 06:42:00 +0200
Message-ID: <CAOssrKeLqOtsRXVwHBncyaWEW2ZP3T-rL+O7C3j8=Jp3DKpGXg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: remove symlink fallbacks
To: Liu Bo <bo.liu@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 5:43 AM Liu Bo <bo.liu@linux.alibaba.com> wrote:
>
> On Thu, May 14, 2020 at 04:07:36PM +0200, Miklos Szeredi wrote:
> > Path lookup in the kernel has special rules for looking up magic symlinks
> > under /proc.  If a filesystem operation is instructed to follow symlinks
> > (e.g. via AT_SYMLINK_FOLLOW or lack of AT_SYMLINK_NOFOLLOW), and the final
> > component is such a proc symlink, then the target of the magic symlink is
> > used for the operation, even if the target itself is a symlink.  I.e. path
> > lookup is always terminated after following a final magic symlink.
> >
>
> Hi Miklos,
>
> Are these mentioned special rules supported by a recent kernel version
> or are they there from day one linux?

Hi Liubo,

AFAICS, these rules have been there from day one.

Thanks,
Miklos


