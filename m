Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C67C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB7420734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="qBG8G3BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB7420734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizfK-0000R9-JU
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jizLV-0005oU-Fb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:56:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40362)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jizLU-0002Ih-8v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:56:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id r15so1557390wmh.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=YD53SHQKqAhtmrXI0k73MRS/gnTHDNJPaJbb/VfItVw=;
 b=qBG8G3BW3GoRbtyn9Hl7q5VJgD56K/GJGG6FC00+kmNqTKZatnPoOgXjKVL1AY6HYt
 tDJIQtqr9Eoe14aav21BRW3BLdyrhYtuZRDQCRNPmYKCq4uo5KpLEpEvrdNajVr/z2wU
 TvlUmJ+gqWcz7h/hntweLA7UBKaS2vCpkBQ3TStynq2D9SEO0+G4TMPeNmM9m0FXUe61
 fRP2Ycy2aZiVyIGPQk0jfr/iYQnhnAEhq8KfLoScRRALRIR2L7Rx3UHMFdvRO9Ijg02s
 RWpVQwpYRBgnJAmPiSBYUNOnFxzp555Rq0OhTO0gKx/2MZy+gDt1z1NZVdQIGRfcKQZZ
 +eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=YD53SHQKqAhtmrXI0k73MRS/gnTHDNJPaJbb/VfItVw=;
 b=iAM+tNaGqCiJ/83ltZGZKSmFowH8IitO2YyiTL7883P9F6NGMWpNnrFwNZKnBa596D
 d/QIWw/e66IWTT2xhCWGjN/B4KOQbDUq7AGP6ZkKKbkEhRvuirvMt2Rq23/2GcJdn1Q/
 0hDA051qiBLI7nw43Xjze86hhzrMsbrkx6nZxyE8h0ij6M/zHjd9LqIv7SpD/+h0c094
 3/vBQ8LmiLfyHVrOVetGKDo/CQgXBtGBGFRCtUIDInYgQ95jYMxQfjfHnbHGjlPuzeGf
 S44a5w7nZrBL5mV+2OEPQNesND1RFDmq2cMte30mvrrGJ6HBbEsxWxR3jyA3T2ob6Edy
 AQww==
X-Gm-Message-State: AOAM531Y0+/qt657WBElN/SHdyV6jrnxQOQCkl5HPbDflOcaArFnWeh8
 TZdHXIqSCnoH1CypMvRstrA6IA==
X-Google-Smtp-Source: ABdhPJzv9aotdCbH4GDihJV+jcqxz6HnrtKdZJfvSMkad2NNABRYk40nVCW/eEimWY6Z+l+qEhSQ6g==
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr2782316wmf.173.1591790198222; 
 Wed, 10 Jun 2020 04:56:38 -0700 (PDT)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [2001:8b0:bb71:7140:64::1])
 by smtp.gmail.com with ESMTPSA id z22sm6653383wmf.9.2020.06.10.04.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 04:56:37 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 6344c4b0;
 Wed, 10 Jun 2020 11:56:36 +0000 (UTC)
To: Sam Eiderman <sameid@google.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
In-Reply-To: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 10 Jun 2020 12:56:36 +0100
Message-ID: <m2imfz877v.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::331;
 envelope-from=dme@dme.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, Tony Zhang <tzz@google.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-06-10 at 08:28:29 +03, Sam Eiderman wrote:

> Hi,
>
> 168468fe19c8 ("qemu-img: Add --target-is-zero to convert") has added a
> nice functionality for cloud scenarios:
>
> * Create a virtual disk
> * Convert a sparse image (qcow2, vmdk) to the virtual disk using
> --target-is-zero
> * Use the virtual disk
>
> This saves many unnecessary writes - a qcow2 with 1MB of allocated
> data but with 100GB virtual size will be converted efficiently.
>
> However, does this pose a problem if the virtual disk is not zero initialized?

As Vladimir indicated, the intent of the flag is supposed to be clear
from the name :-) If your storage doesn't read zeroes absent any earlier
writes, you probably don't want to be using it.

> Theoretically - if all unallocated blocks contain garbage - this
> shouldn't matter, however what about allocated blocks of zero? Will
> convert skip copying allocated zero blocks in the source image to the
> target since it assumes that the target is zeroed out first thing?

So something like a "--no-need-to-zero" flag would do what you want,
presuming that it would write known zeroes but no longer clean the
device before use?

dme.
-- 
You can't hide from the flipside.

