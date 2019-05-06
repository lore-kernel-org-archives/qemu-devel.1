Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 04:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC892082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 04:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctMdWdn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC892082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50131 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNVCR-0004yn-LD
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 00:25:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1hNVBc-0004Z4-DY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 00:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1hNVBb-0006kY-AV
	for qemu-devel@nongnu.org; Mon, 06 May 2019 00:25:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liliang.opensource@gmail.com>)
	id 1hNVBY-0006j6-EE; Mon, 06 May 2019 00:25:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id c6so850358pfa.10;
	Sun, 05 May 2019 21:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=1V2FeC5CLv7neN3SiemIA1QrjgBL8tCKrSSvjqO2ykE=;
	b=ctMdWdn9wIt/2xQ8jK4/wwedSCIUVVbNOyyaMCNg453CyWcXybYBOkQ36e96z2Tx4E
	hYn3rkwplh/KRHZkDjZ2gTjnqCovRus356eqOk1DnsDX5dK1iMRAfsTd5IymdkgGjSlg
	8kiVc41gADdP1wEDRh5CVLqz88wrsMt2wkWkEPO1Zzgsbup0ogpbR4hMFcjc3vy1dY1Y
	wsItqHhaWMU5OkI+bh0J2g54Rql8Cvxepv0Z4OrtdEJ4gLmgk6kGh/wWqDSVaL5duDld
	1B27VhqXw6c9rD+QIpdL2fGDDvPwgES1DmdVBIAhd2kD/CSyk15tTyh0/HlMHW5t3L/z
	CkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=1V2FeC5CLv7neN3SiemIA1QrjgBL8tCKrSSvjqO2ykE=;
	b=lMXbgAefqpPYPiz4+Ev+iZs4vZMky9To/L83p1r9q4DHXoQfleg6y19I6yZ8PqnxES
	yB++VhJvQw37iv5QcvZM/9VfAU4B3WlfdYjNCMUv13K5DGcKmhayBdSo4BURkLrd2W4R
	mPuMBFWuEHip9O+fnYDeijGSlU2JyVBofJqOcvhw67IgESyeP7nMOYUG9lgK30ayNXdW
	JVxXq9aTu5XWi6YkNRKs7uuiKF9qQSBjObSAEN769+ftn5xoJ3C7zJaVHaA45fRW3vGf
	lPgiNBtvp0eiN8Eea83lhNiUml4SlQnvzjdxrVH41UTKyHEaaOG6q7Ipv+Vqhuc62gLE
	3exg==
X-Gm-Message-State: APjAAAVhnmsxWcWyqSJe+epY72JLMHaYrLlIAX6OIDLwBy+xut2xpXjL
	hCPkiR1Q2G1cq9NLkFRPhho=
X-Google-Smtp-Source: APXvYqxVwqBMTY1t3aMrOhST9LF+NLmySyNn6aPaV4HZUaqTz55xwxvw7y9F72XV0MnwbTrtbn1+GQ==
X-Received: by 2002:a63:1160:: with SMTP id 32mr29893315pgr.106.1557116702622; 
	Sun, 05 May 2019 21:25:02 -0700 (PDT)
Received: from liangdeMacBook-Pro.local ([203.100.54.194])
	by smtp.gmail.com with ESMTPSA id
	r24sm11556435pfd.120.2019.05.05.21.24.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 21:25:02 -0700 (PDT)
From: Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date: Mon, 6 May 2019 12:24:52 +0800
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190506042448.GA10991@liangdeMacBook-Pro.local>
References: <20190428100052.GA63525@localhost>
	<b9adec87-7818-02e0-518f-50d25130c093@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9adec87-7818-02e0-518f-50d25130c093@virtuozzo.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 0/2] buffer and delay backup COW write
 operation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Wen Congyang <wencongyang2@huawei.com>,
	Xie Changlong <xiechanglong.d@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Liang Li <liliangleo@didiglobal.com>,
	John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 30, 2019 at 10:35:32AM +0000, Vladimir Sementsov-Ogievskiy wrote:
> 28.04.2019 13:01, Liang Li wrote:
> > If the backup target is a slow device like ceph rbd, the backup
> > process will affect guest BLK write IO performance seriously,
> > it's cause by the drawback of COW mechanism, if guest overwrite the
> > backup BLK area, the IO can only be processed after the data has
> > been written to backup target.
> > The impact can be relieved by buffering data read from backup
> > source and writing to backup target later, so the guest BLK write
> > IO can be processed in time.
> > Data area with no overwrite will be process like before without
> > buffering, in most case, we don't need a very large buffer.
> > 
> > An fio test was done when the backup was going on, the test resut
> > show a obvious performance improvement by buffering.
> 
> Hi Liang!
> 
> Good thing. Something like this I've briefly mentioned in my KVM Forum 2018
> report as "RAM Cache", and I'd really prefer this functionality to be a separate
> filter, instead of complication of backup code. Further more, write notifiers
> will go away from backup code, after my backup-top series merged.
> 
> v5: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06211.html
> and separated preparing refactoring v7: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04813.html
> 
> RAM Cache should be a filter driver, with an in-memory buffer(s) for data written to it
> and with ability to flush data to underlying backing file.
> 
> Also, here is another approach for the problem, which helps if guest writing activity
> is really high and long and buffer will be filled and performance will decrease anyway:
> 
> 1. Create local temporary image, and COWs will go to it. (previously considered on list, that we should call
> these backup operations issued by guest writes CBW = copy-before-write, as copy-on-write
> is generally another thing, and using this term in backup is confusing).
> 
> 2. We also set original disk as a backing for temporary image, and start another backup from
> temporary to real target.
> 
> This scheme is almost possible now, you need to start backup(sync=none) from source to temp,
> to do [1]. Some patches are still needed to allow such scheme. I didn't send them, as I want
> my other backup patches go first anyway. But I can. On the other hand if approach with in-memory
> buffer works for you it may be better.
> 
> Also, I'm not sure for now, should we really do this thing through two backup jobs, or we just
> need one separate backup-top filter and one backup job without filter, or we need an additional
> parameter for backup job to set cache-block-node.
> 

Hi Vladimir,

   Thanks for your valuable information. I didn't notice that you are already working on
this,  so my patch will conflict with your work. We have thought about the way [2] and
give it up because it would affect local storage performance.
   I have read your slice in KVM Forum 2018 and the related patches, your solution can
help to solve the issues in backup. I am not sure if the "RAM cache" is a qcow2 file in
RAM? if so, your implementation will free the RAM space occupied by BLK data once it's
written to the far target in time? or we may need a large cache to make things work.
   Two backup jobs seems complex and not user friendly, is it possible to make my patch
cowork with CBW?

Liang

