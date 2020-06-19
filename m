Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932CB20776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fZacZoMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932CB20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHrm-0000gm-QU
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miklos@szeredi.hu>) id 1jmHp1-00081r-1R
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:16:47 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <miklos@szeredi.hu>) id 1jmHoy-0005Yh-VO
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:16:46 -0400
Received: by mail-ej1-x643.google.com with SMTP id p20so10316894ejd.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=892xWMh1+vvidwxM0vd7W+Apqra00tDOkRAFYadbIlM=;
 b=fZacZoMW2LFP/V8rnrhWNwJ6hIRlvXIg3L1qB/qdpUZlDhCgAJZSPu9FQ6y3pLRPuY
 F7VFs/HPH35BRHVOW44BSIpLkfMqNI71xNb1UZhYDzjsYbgGlyiSqH0MCs8zoAEhDY4z
 F7uSWYZ8G3QWakRZpGSb2oEDXF+z3nhVveJ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=892xWMh1+vvidwxM0vd7W+Apqra00tDOkRAFYadbIlM=;
 b=XwT4o3tZWtoaP9v9g3YljyFe/sBgvNCjFySjVb4Q89TWacw/SnLyA6yo8PS5PDf05Z
 6PMI4AS7DcwsPPjPvsdcxYsPuAcu52E4+71TNCI8gxjhugTtMEvvEmUo4a7D0cxD+A+u
 TRPAzD4DavBKrn7MDVDR5wlzULd37C5x7J18befM9jsz00BdM3wT9YrticxHAC6qFFlK
 7IC5XVTElKD+Qkqhkh0q9NQq44CmbUS4ZYvvFR9cj6gc87Zk8z0GZSexzrShy6FLZ+U6
 YzzF0/Sk1GNM7uFyDweq8bYzn+ZyDZq9Asoth+F0F0levviojdkL15dAypNBbKB47kyP
 wo3A==
X-Gm-Message-State: AOAM533iIwzZ+PZz6s2e6ARX41pQu7xR9bDIpg1+1485O3xEBZ4MIq9G
 jpPMX7ykbcHEOFXeYjiJEdXOahpzWWg9wa8ZHbVOLA==
X-Google-Smtp-Source: ABdhPJzZ0eAD3k13iuMYKoiggiOmPLE3XH6AeIwXWJGJtKkrN66t7WJqUzZqSd1gVl6f7wwKeOs3hG1iUP990Ph0DQI=
X-Received: by 2002:a17:906:1947:: with SMTP id
 b7mr3746510eje.320.1592576201612; 
 Fri, 19 Jun 2020 07:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
In-Reply-To: <20200618190816.GD3814@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Jun 2020 16:16:30 +0200
Message-ID: <CAJfpegsfqADmK6foDyuQQnvMDh_jE0rNUCBRuxPchSSirrb04Q@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=miklos@szeredi.hu; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jun 2020 10:18:19 -0400
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 9:08 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > whitelisted set of capabilities that we require.  This improves security in
> > case virtiofsd is compromised by making it hard for an attacker to gain further
> > access to the system.
>
> Hi Stefan,
>
> I just noticed that this patch set breaks overlayfs on top of virtiofs.

How so?  Virtiofs isn't mounting overlayfs, is it?  Only the mounter
requires CAP_SYS_ADMIN, not the accessor.

Thanks,
Miklos

