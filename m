Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4194AC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CBF2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CBF2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4wn-0004rz-BR
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 09:36:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT4vN-0003hB-07
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT4vM-000251-05
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:35:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT4vL-00023o-Rz
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:35:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id z128so11045035qkb.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=bd2cBrB4rqXh585BShwkAE0hyQoIQwti3yRwoVbuI8E=;
	b=HczEYpw0E0mDSxStAVArt4hx1jTuAUGuAnmM4lMFJ98JgtHe842Surz4zruSRC89oS
	Iq9OB4XMVbfjqAvuXLYFmTab4RJnQbgrbiDolxz5ESNJuLqOLA83kVO+admk2jttG2aU
	xbq+ZvWu9BynvQFPGSx/1iAwdsObTEqIKPIL9ZZZr7WyQIR9PgRT8OAwrec0cB1l6JOU
	24k6eIwL4Wq2d2oWUbSM+jOK+z/PSa27Lk2dMv/kMOglHLCQooVwx7dxFmNX2GVwkjuS
	OlsPwBYS7zGDvYeg1If4NT7qNd8qrt4uwEO4x0qhWEMdystwFp3XIFG+qfaKaGU8Y8vh
	F9Pw==
X-Gm-Message-State: APjAAAVreCscxJCRlAEvg9XZypu3xgWFAkhFkPofULnDGmJj8+YzhkgD
	+NNOKh0sB0TUbuS9dRctoctdnA==
X-Google-Smtp-Source: APXvYqwfzxV6Fhyl+DMYzmuc1WQH0zf0rMWs713sx+KDfGPSpRSKXoqsl9YvSv5muuSWr7g7vK0ZxQ==
X-Received: by 2002:a37:4996:: with SMTP id
	w144mr43226879qka.346.1558445723186; 
	Tue, 21 May 2019 06:35:23 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	l127sm9046434qkc.81.2019.05.21.06.35.22
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 06:35:22 -0700 (PDT)
Date: Tue, 21 May 2019 09:35:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190521093328-mutt-send-email-mst@kernel.org>
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
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


OK for now I will just drop UEFI tests from ARM.
Igor will debug and re-add later on.

Igor, as you do this maybe start by adding the infrastructure
with the blacklist so we can formalize the current
"these tables need to be updated".


-- 
MST

