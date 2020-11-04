Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E26C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0107820735
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6wV+9Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0107820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaS5J-0007wp-OP
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1kaS4S-0007QV-Hu
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:20:06 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1kaS4P-0002rq-0f
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 18:20:04 -0500
Received: by mail-qt1-x842.google.com with SMTP id g17so284088qts.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 15:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=+Sp7CJUWmE0wbQglmZS/ehP1S+HYix3XN1ZxDsI0fR8=;
 b=h6wV+9QyQ+9zIMA16ePtvycvoW7Zia3fQVGB53YOUEoPXNyZw1AGPUkiynS3HCTtqA
 I0II3ES5BPu/9GvU0GO9eWuiRd1OY2e/aq0PIKzXX/rFl8DP1sv7Rq+bKo/IByPt3bl+
 H23BgnQS/Hee2oJBgQAq7cJO4hBvwLUntM/Wb1GdtblsGM4fxDEpb2hoEWJCo6crJJmA
 610wVMnAL17aYmwnw3XgDjOJEu0tdsOp+k5VpT6OYeVb8hSaqSBDv77k/bZptAzt+d8I
 tXXQ+7Pki25zCB0TMKN3kMuKcIXK5zvSLyCUKrjWsykCxkTuhPEaGMR1D/3gO/ibFIl1
 1J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+Sp7CJUWmE0wbQglmZS/ehP1S+HYix3XN1ZxDsI0fR8=;
 b=mFoor/WsDqdZ3uBPGtApDyTCmsdja19Xdmvcbw/jPywHUJ/+EJ7jH41/otVeQ1EEGd
 FlfXkdgy4NtfAPbgaAmt+XHb/xETd0T6LKBg30W6eI42QJcI7Jz+HIzm7AODmxyo/msh
 3giZ9eJ28ATPQ/UzkyH2z6ZTsTZklwvm/9YkAMFCfpRxMlUwqy5JuHT5DiLZ7DxpBrBw
 ZV9u6wdbcb4qZ2aPVMz1jPpQku3Xq5YyeiMFqMiVCWLfDRHef/9BBNNXZQc3gxz1CmIb
 PvT/KEOJ9Ygah9slKSzRpWahznvnUeZhWuxH7vTvwyAzaPcyX32LxuW0QFVAgNTGN4Ea
 BKEw==
X-Gm-Message-State: AOAM5327wKCI5HAgM+BR1BbNr4R+vPZTZknKs4/zy1NvETHcl/17Yj+U
 Bg/1SzR9Gqm30jq+IK02qg==
X-Google-Smtp-Source: ABdhPJz1mX2DAH1qmvB43NkWJzU2SgP9tJ4T7qV6iq46uiCcm3Ogygk4L8OqPNXLJZeILbjbySutAw==
X-Received: by 2002:aed:27dc:: with SMTP id m28mr483528qtg.12.1604531999966;
 Wed, 04 Nov 2020 15:19:59 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id d188sm3953504qkb.10.2020.11.04.15.19.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 04 Nov 2020 15:19:59 -0800 (PST)
Date: Wed, 4 Nov 2020 18:19:57 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: locking option doesn't work as expected
Message-ID: <20201104231957.57a7oxibollskstg@gabell>
References: <20201104163556.ifevmhkj4bw6iuc2@gabell>
 <20201104164853.GM565323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104164853.GM565323@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=msys.mizuma@gmail.com; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 04, 2020 at 04:48:53PM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 04, 2020 at 11:35:56AM -0500, Masayoshi Mizuma wrote:
> > Hello,
> > 
> > It seems that locking option doesn't work as expected.
> > When I run qemu as following options, then I got an error and failed to
> > boot the guest:
> > 
> >   qemu-system-x86_64 \
> >     -machine pc \
> >     -enable-kvm \
> >     -cpu host \
> >     -smp 1 -m 4G \
> >     -nographic \
> >     -serial telnet::1235,server,nowait \
> >     -blockdev driver=qcow2,node-name=disk,file.driver=file,file.filename=/mnt/guest.qcow2,file.locking=auto \
> >     -device virtio-blk-pci,scsi=off,drive=disk,id=virtio-disk0,bootindex=1
> > 
> >   qemu-system-x86_64: -blockdev driver=qcow2,node-name=disk,file.driver=file,file.filename=/mnt/guest.qcow2,file.locking=auto: Failed to lock byte 100
> > 
> > The error happens when the filesystem doesn't support OFD lock.
> > qemu_probe_lock_ops() judges whether qemu can use OFD lock or not with doing
> > fcntl(F_OFD_GETLK) to /dev/null, so the error happens if /dev/null supports OFD lock,
> > but the filesystem doesn't support the lock.
> > 
> > I'm thinking how to fix the error. My idea is to add locking=posix option to use posix
> > lock to the file, but I'm not sure the idea is good way to fix the error...
> > 
> > I would appreciate it if you could give me some advises to fix the error.
> 
> Ideally we would not attempt to probe it on /dev/null at all. Instead just
> attempt to lock the actual file using F_OFD_SETLK and if that fails, then
> falback to F_SETLK.  We can do similar when checking whether the lock
> currently exists. AFAIK, the locking code isn't so performance critical
> that the extra syscall would hurt us in the case where OFD doesn't exist
> or isn't supported by the FS.

Thank you for your comments! I'll fix the error to lock the file using
F_OFD_SETLK and if that fails, then falback to F_SETLK.

Thanks!
Masa

> 
> > 
> > BTW, locking=off may be useful for the workaround so far, however, locking=off
> > doesn't work on the splitting blockdev configs as followings...
> > I split the blockdev option as libvirt doing.
> > 
> >    -blockdev driver=file,filename=/mnt/guest.qcow2,node-name=storage,auto-read-only=on,locking=off \
> >    -blockdev node-name=format,read-only=off,driver=qcow2,file=storage \
> > 
> > Thanks,
> > Masa
> > 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

