Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E25C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B43221479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B43221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrFg-00036c-NO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:59:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrDn-0001vF-FC
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrDm-000148-IJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:57:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrDm-00013k-EJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:57:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id z6so9880329qkl.10
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 15:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=g4e0G69Ibxp7FhZH4b8cAZbRMCd92r0gkEUdaX7gkaA=;
	b=NxP5XQ5vAF6SZViyJYMdLvYbADilDdEDTbgSfy05+6VumRX2Csfkb5TplAazzFPVnF
	3SoYlhjtPdoUvpjU8Z/4vCzsHYdmPDSeOlx04jGINtDhbEecXwLNnBbsMJeMZmcfR5Kv
	tUsE2FoBz+gyQWN0UnvxrihzNSRhg2aCZoauikEQErrlxX7a32B07nMDACyGqUMtUoue
	BT11bSnhPmjfNSb/akEatbY3xM84Phk9jaB6ZqDSNTFLN0FIY0LWpzD1g0t7ujE/ybxj
	rPkUqRak/GYeEpLysNfpYKJeb+iRK4dW+/3M6yPHZsOK2bZJy9EN6YQF5guEWoCNXtEl
	WrNw==
X-Gm-Message-State: APjAAAUrjkZtfA1IKMY3c31hPGwYv47sSSzauAz50Bm4kAqstMPHJosZ
	h3gEsR3Djo/AjDAW0n6dHYXEIA==
X-Google-Smtp-Source: APXvYqyR41Fl0H2h9koOWXwplc5KUKaev+5pNBycmNIIWAFrvIGdO6G3t+7GrG9zx1OeVFxTWkfs4g==
X-Received: by 2002:a37:8dc1:: with SMTP id
	p184mr41310297qkd.226.1558393049738; 
	Mon, 20 May 2019 15:57:29 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	l40sm12356213qtc.32.2019.05.20.15.57.28
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 15:57:28 -0700 (PDT)
Date: Mon, 20 May 2019 18:57:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190520185657-mutt-send-email-mst@kernel.org>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
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

On Thu, May 16, 2019 at 05:04:42PM +0100, Peter Maydell wrote:
> On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
> >
> >   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
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
> Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
> because the conversion of arm to Kconfig has landed in master.
> Could you rebase and fix up to use whatever the Kconfig
> equivalent of these changes is, please?
> 
> thanks
> -- PMM


Rebased and dropped the conflicting patch.
Pls re-pull.

-- 
MST

