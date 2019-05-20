Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84B5C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E15321743
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E15321743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrGX-0003iJ-0q
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:00:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrFW-00039Y-9R
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrFV-0001yC-AS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:59:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrFV-0001xj-5m
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:59:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id d10so9928148qko.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 15:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=XHBGDvzFdPwABgwqLQ0BcvgLI95qPHNgD7nw6sbP+d8=;
	b=P7wVMKuS8gca/ojpgV4xVg2IvrWOOk9QmH+Ot0vrxU0zLyHaskkVrXYjJOjDv5+Zjk
	ujpG9RinosvUvwTgF3Ycl6XA+9dtU36Vsx99YJNEQeSuOeha18mXuj5+0K8ZbGhdI437
	k2A/Pf7U6O32Y9XkbjsSw4iXOsGEgstrplvZa/aFa5ltG1kOdgP/qgvkHEG1HuwyIa/e
	gMe8npVaSKxc24avXILtLz7aXlhcPr1N0GE68iGU+oRfL585fRzVn52PoB2ZcF+wdGlY
	77uRoA5wRmrGebRgdaOQReS63BOywEnfFwK12g7O+04vOde5Kg9NTHJ5kMTot553qkqw
	MIgw==
X-Gm-Message-State: APjAAAW1TTKtdS6ZgCQ4lnVEyMEDAL6dGfUmxOknZ20BnDlS9AQ9TohR
	K2H4Kzr9L4szCZJpfaD8D5nNFA==
X-Google-Smtp-Source: APXvYqwZ+aSqJiFC/MocrnGiIe6OrQ7psAIAq4Ml7Xtfn1NkSik6DUz7E30zve6uzPRdpvJt4M082Q==
X-Received: by 2002:a37:7982:: with SMTP id u124mr60418500qkc.79.1558393156741;
	Mon, 20 May 2019 15:59:16 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	r16sm6497247qkk.36.2019.05.20.15.59.15
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 15:59:15 -0700 (PDT)
Date: Mon, 20 May 2019 18:59:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190520185902-mutt-send-email-mst@kernel.org>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 08:33:13PM +0200, Philippe Mathieu-Daudé wrote:
> On 5/16/19 6:04 PM, Peter Maydell wrote:
> > On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
> >>
> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >>
> >> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
> >>
> >>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
> >>
> >> ----------------------------------------------------------------
> >> pci, pc, virtio: features, fixes
> >>
> >> reconnect for vhost blk
> >> tests for UEFI
> >> misc other stuff
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> >> ----------------------------------------------------------------
> > 
> > Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
> > because the conversion of arm to Kconfig has landed in master.
> > Could you rebase and fix up to use whatever the Kconfig
> > equivalent of these changes is, please?
> 
> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
> 
> The conflict doesn't look trivial to resolve (to me) so I'd rather see
> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(
> 
> Regards,
> 
> Phil.

Yea, that's what I did.

-- 
MST

