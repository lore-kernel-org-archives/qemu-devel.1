Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8A1C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABAD2067D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqRyAcW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABAD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXwr-0005Ke-DD
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 04:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1huXwO-0004mJ-KM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1huXwN-0000Vv-Jx
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:02:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1huXwN-0000VQ-BP
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:01:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so71998213wme.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dhDgHNG5a9/PpetauAfy6fD41aZHq7Bf07H9DI6pC7w=;
 b=HqRyAcW6sGrfgKtLqDanxOuXs5lhIkYyC286FlpSEVYqrlXza33sWimrCQuaeH9Re6
 LFQwhY3tbENbGuoEmIw8EKBsyojgCJ7g9mV9ndF+qU5ZTrlTcsq8uGkQ2tffFrL5Z0dF
 B8PEJdOT2nJU/ZA9jF3FU3wFlofcrdX9bT9UqJHKyURTn7elktzHQSpJuPwM3TkSd2Xy
 VybumEVxhCM87UQnzf/le6tbgh89yPQWqGGpNl7fk9ySrL9uuqbC0fgUHP84+t+mmYmO
 tQ4QHq95+HvDHUzbQZbEb9svaT7JfncvXi158C5HpMG+87JURmN1z16c11mHr61nH3o7
 rUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dhDgHNG5a9/PpetauAfy6fD41aZHq7Bf07H9DI6pC7w=;
 b=mMZ3Qoj2J5e8lH3SuvcpnQGBa2UzBBAVHKZMrUlDM8hc8S+CvyGj12dlZGD5XUA8Ef
 eVPLySsHEGHkPSLgRyBVN48+ZI3Py4WFHWgKq4pCr8/m+lMn7ybaUQ6m6ufEn8sHf/yk
 SEkdlFzl39hot4mEg0mNeP3mqFLk4F/8g74Vx4lcdNrGIyJ6ypSddGLzn5aCrOykN57l
 WwDL4yE26tsdE1JUl0IGWwGNgnboavCt4/JEP3yHKcwTKeMz4T5INXi7rOO6Kse4M0c4
 AXrLbNNM2iHFHremZW3gVuERm75C59ODTc3cgmElP0wLrYYoeeCxM3kulSkEr5wJKndx
 HyhQ==
X-Gm-Message-State: APjAAAXjImnIy0a26KIgQBm1sdJvBpPS8Pe/1t9Sq4E8Xf3EanBpnzEU
 TQLbkyopxthxhQCHh4+Wxkg=
X-Google-Smtp-Source: APXvYqyd+1xxO6gEkLZx0RbAycmvyFZFqeVHVbO4a94wx/BSiYWCWhVarHB+/nm0DOJep7ckg9XmJg==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr15255021wmi.142.1564992117710; 
 Mon, 05 Aug 2019 01:01:57 -0700 (PDT)
Received: from localhost ([5.148.65.242])
 by smtp.gmail.com with ESMTPSA id k63sm102382744wmb.2.2019.08.05.01.01.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 01:01:57 -0700 (PDT)
Date: Mon, 5 Aug 2019 09:01:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190805080156.GA22337@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <5D4799E5.6020006@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D4799E5.6020006@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 05, 2019 at 10:52:21AM +0800, piaojun wrote:
> # fio -direct=1 -time_based -iodepth=1 -rw=randwrite -ioengine=libaio -bs=1M -size=1G -numjob=1 -runtime=30 -group_reporting -name=file -filename=/mnt/9pshare/file

This benchmark configuration (--iodepth=1 --numjobs=1) cannot benefit
from virtiofsd multithreading.  Have you measured a regression when this
patch series is applied?

If your benchmark is unrelated to this patch series, let's discuss it in
a separate email thread.  fuse_buf_copy() can be optimized to use
pwritev().

Thanks,
Stefan

