Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EBF2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URvptElp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EBF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8ft-00041w-A1
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 16:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1jb8eo-0002qa-Cj; Tue, 19 May 2020 16:16:10 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836]:44687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1jb8en-0000K4-EK; Tue, 19 May 2020 16:16:10 -0400
Received: by mail-qt1-x836.google.com with SMTP id d7so697666qtn.11;
 Tue, 19 May 2020 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ohRjIDaIbdm4P+k27fxUHbPnyTMLLeLbcg/2Kj481/s=;
 b=URvptElp3wDblAoX2OOzvLgR+zJqrolf9RNnhJCyMVK5gwJrul0gbZ+QcvA1XkFfG5
 QJlix4eTQTfs7pULWASKsstqzz41/7nsYIe3uoTFRM/K7p4zbA4Y0K/Ciz2B8ydNeN6D
 e73IsQQ+qTJLPgBHBrcrZXxAO1nQRRv7Jmp51ssxAUKyHvTi8FBTOsDKtJaR4JmmV4h5
 xgqAhlfr8x4A+ZxlU/vhkM47TXbIdVVrvwm+Dbhg7s4l/yx1dxQtGAneUnhT6chxR1di
 XvuhmnvXFT1QROxFiHS/Fzvs48BauQYoiPeHeSaKAhtO58K6tUEo88GTBSFOm2nklKTs
 U6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ohRjIDaIbdm4P+k27fxUHbPnyTMLLeLbcg/2Kj481/s=;
 b=HkAfTTD3+MEcO4mA/LJ+w/WDhOzDb5MBsaCX5mAAJkAj+2GLQHaLhJU73fDwa16RSw
 BKWgI+FepjznjLr3FUfo6ZsS/odmAZNiLBcnwU/ib6nF7wW3g4njXUxOKx3V7NkBpP2Z
 giOcXVpl+31Nz4CGBsqMyuBQbV0ZgUmsPj908/6QZHi/Euwxa3xgq03uGbPD7rvFJKlj
 Slr7k0rK+44q/erKfyyYjISLz3kyh3QnX80bUuK7uZL+2EsfYeWW7oAt1UjhxcTrhl2j
 7Csu0WGGOsIcKjsRnrYBpNzlqcekVUn44jIfMw8WWtkENpFX+K+XadnKr7CzOIKkHT0Q
 a4gA==
X-Gm-Message-State: AOAM5300NxEQTiUN1D86YLTOjC0z52ixizuIZ7DEj/Vsu+OjgLvJoOs5
 fv6STrzfBdga6rDpYAT95g==
X-Google-Smtp-Source: ABdhPJxn163fi/WhKHHbSRswoK5bmj8Yc4L4XA0PCLZClsCqL9MtOi3jghCWiTy1B+pY6JgmSx1zZw==
X-Received: by 2002:ac8:4311:: with SMTP id z17mr1639400qtm.316.1589919367355; 
 Tue, 19 May 2020 13:16:07 -0700 (PDT)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id c26sm450005qkm.98.2020.05.19.13.16.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 May 2020 13:16:06 -0700 (PDT)
Date: Tue, 19 May 2020 16:16:05 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Question: How do I discard any changes for the device which is
 set by blockdev option?
Message-ID: <20200519201605.7xlostisrjitesny@gabell>
References: <20200519175659.4poxgjmp4xoufl7h@gabell>
 <efeb1594-589b-3f0a-9295-da55f92970b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efeb1594-589b-3f0a-9295-da55f92970b2@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=msys.mizuma@gmail.com; helo=mail-qt1-x836.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 01:41:08PM -0500, Eric Blake wrote:
> On 5/19/20 12:56 PM, Masayoshi Mizuma wrote:
> > Hello,
> > 
> > I would like to discard any changes while the qemu guest OS is done.
> > I can do that with snapshot and drive option.
> > However, snapshot option doesn't work for the device which set by
> > blockdev option like as:
> > 
> > $QEMU --enable-kvm \
> >        -m 1024 \
> >        -nographic \
> >        -serial mon:stdio \
> >        -blockdev driver=file,node-name=mydisk,filename=/mnt/fedora.qcow2 \
> >        -blockdev driver=qcow2,node-name=vda,file=mydisk \
> >        -device virtio-blk-pci,drive=vda,bootindex=1 \
> >        -snapshot
> > 
> > I would like to use blockdev option to set the device because
> > libvirt uses blockdev option for disk element.
> > 
> > If there's no way to do so, does that make sense to get available
> > snapshot option to blockdev as well? If that makes sense, I'll try to
> > implement that.
> > 
> > As for qcow2, I think we can do such things to use qemu-img snapshot
> > command, for example save the original image and restore the image
> > after the qemu guest OS is shutdowned. However, it may be complecated
> > for user. I would like the simple way like as snapshot/drive option...
> > 
> > If I'm missing something, let me know.
> > 
> 
> Sounds like a repeat of this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06144.html
> 
> where the consensus is yes, -blockdev and -snapshot are incompatible,
> libvirt has plans to use the <transient/> tag to behave the same as what
> -snapshot does (but no one has implemented it yet), and in the meantime, it
> is possible to force libvirt to avoid -blockdev if you still need to supply
> -snapshot behind libvirt's back.

Thank you for the info! I didn't notice the thread.
I got we should implement that feature for libvirt side, not qemu.

Thanks!
Masa

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 

