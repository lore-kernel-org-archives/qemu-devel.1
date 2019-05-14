Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C518C04AB7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5332A216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5332A216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYdY-0005KO-Fv
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:42:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQYch-0004xp-R0
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQYcd-0005vi-U5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:41:43 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hQYcd-0005tz-MG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:41:39 -0400
Received: by mail-wm1-f43.google.com with SMTP id f2so3096203wmj.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 07:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=wL1dNJrmEyk2DBNfOJgmIee0kdP0bPQo9TDo58Is5SU=;
	b=F7MvltGpgSZcNUA0xsfsIlxNYFOyXJdgj0Vb/S/Z9amjO7ogPSjJDUgp1kEGUaunEM
	62wF/TZIlWfcLck1fQT5izJWLJvKfd6pxp2qGKY0E2KzaOhGbasi1Dp2jG1IHAO5QGAc
	Isiy6ff7jGHGeJkD6V+XJPW5foVvTHNxUVAoC92EgbVCsTiydgF2IkWibaKblkRbQYD3
	Ha++xjQWHJqxp3ZbIBSWtWAUSU7lzzlFYlTux4khi4ZbpRRbxNC/iby28O5Ro0LyvMc/
	IbLXq7mP8XRMwHAAaUB6/hjHcfqlGbubHJa2KJ6qddOqr/ndGlSQDRXq16R4ODJZMHsv
	drqQ==
X-Gm-Message-State: APjAAAVq7ERkRur2ygj2kARREWf2Zlc0qYV7sDYSEXgIScHbpEjMZOFP
	lftxRtzwPYS/mS7FrU2T+VSXKQ==
X-Google-Smtp-Source: APXvYqyDwF0biV8Jy9ij0/fonv14jqsz3+kB2+3dLZFPdw0InlSDMHxg+s+Zy4ejwptabVO2Tap1Xg==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr5412230wmj.25.1557844898560;
	Tue, 14 May 2019 07:41:38 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151])
	by smtp.gmail.com with ESMTPSA id r3sm13124417wrn.5.2019.05.14.07.41.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 07:41:38 -0700 (PDT)
Date: Tue, 14 May 2019 16:41:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190514144135.ixndb7osljmbtppv@steredhat>
References: <20190514135735.14497-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514135735.14497-1-berto@igalia.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.43
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Use
 BDRV_REQUEST_MAX_BYTES instead of BDRV_REQUEST_MAX_SECTORS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 04:57:35PM +0300, Alberto Garcia wrote:
> There are a few places in which we turn a number of bytes into sectors
> in order to compare the result against BDRV_REQUEST_MAX_SECTORS
> instead of using BDRV_REQUEST_MAX_BYTES directly.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/io.c     | 6 +++---
>  qemu-io-cmds.c | 7 +++----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

