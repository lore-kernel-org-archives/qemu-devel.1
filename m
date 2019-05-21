Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C328C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6438A21479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6438A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5Mb-0008FJ-Mn
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:03:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT5DX-0000P3-HG
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT52R-0004ZV-0g
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:42:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT52Q-0004Yq-TH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:42:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id k24so20498744qtq.7
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=dTNyFHuH2EKIMK78fAWwlvAi/ly3eXI7flF+iJg1tKw=;
	b=YGe/BGCMCz3rTleF+eMbD62+TwTtY8E1jK7GBkiKvbLZTmxsidUE1fjENdr3VeBH+c
	1/Bx+y/EExzs8WlVbdmSvkptuyAYAsr0DI872znRLQOdaYqX6bmvzJWHZok+dW2mLfJr
	uCnMcIpWgicnb45aZYWeLFQWyCzHVtuO/fpkG3ucLNaHZb2nhJcVWMZoTs1OZ6Q1l7GC
	WTu9G2Vv+AKkCnh/5R/cHXsYI/QXKk19wZ5z9OJ6W1OyhTzYPxBKHpbIV2MtnOdhoTye
	HCSi4j9kTVdeT6wcCIAtcnlYg2uv9HuJNfP5zoR/+/W2XVInxRN7jniviMygAE5+xBVt
	OwVw==
X-Gm-Message-State: APjAAAVlJTQrrkpPg4Cc2YKOQEmF28WPayHFKdnUYXerhkC41hfFMVJa
	rb177I43FSCU0cfSUhICXuLxhw==
X-Google-Smtp-Source: APXvYqzEu9BHjuJbZeF9ZzElOutd5KyWnd8KSNAHrKegtYGQU+TVhtjtEC3FAexH2udRMnSSMrQrCg==
X-Received: by 2002:a0c:d909:: with SMTP id p9mr52742360qvj.42.1558446162297; 
	Tue, 21 May 2019 06:42:42 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	e133sm8039422qkb.76.2019.05.21.06.42.40
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 06:42:41 -0700 (PDT)
Date: Tue, 21 May 2019 09:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190521094218-mutt-send-email-mst@kernel.org>
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 12:49:48PM +0100, Peter Maydell wrote:
> On Tue, 21 May 2019 at 00:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
> >
> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 0c05ec64c388aea59facbef740651afa78e04f50:
> >
> >   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-20 18:40:02 -0400)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: features, fixes
> >
> > reconnect for vhost blk
> > tests for UEFI
> > misc other stuff
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> 
> Hi -- this failed 'make check' for 32-bit Arm hosts:
> 
> ERROR:/home/peter.maydell/qemu/tests/acpi-utils.c:145:acpi_find_rsdp_address_uefi:
> code should not be reached
> Aborted
> ERROR - too few tests run (expected 1, got 0)
> /home/peter.maydell/qemu/tests/Makefile.include:885: recipe for target
> 'check-qtest-aarch64' failed
> 
> thanks
> -- PMM

Dropped ARM and re-pushed.

-- 
MST

