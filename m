Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8EDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DE420684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DE420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNarz-0006pm-8r
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNaqF-00049A-Ov
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNaqD-0003am-PI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:59:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNaqD-0003aa-JQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:59:41 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6992B37E79
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:59:40 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id d127so20413613qkc.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DyYUIfLK2hBSYRoMphgvgCQwDkgxE96s1Dxb90saGmo=;
 b=bFR/uOGArDZw3NCFS0qs3Uzch/X2zAxwTQkhYMgM39IBtW1JG+RR6QApnWSrctO1MZ
 nsE9giW0ehZYp7qYgTtmRH0TbD8htgHyQhx9hsF0AjtSaZh6np3oHmg7okUgsz0G8wnB
 oZhd+XuCzKdnHpX11/UFQEL5+fR4exrV9ZlhcSL69gXIU7k1KBWOi5DcZW8qHF4dKyoy
 T/uQII30dklOO2cRVKk83JCwotstusfMUXqSC5bPqases8l98LvmdDGAE5/wmkV++sZC
 59ZKZ7C7a4g1cV3pBTUkyWEFZlDcwDwCPpJfqPks4r0ClVZZRa7/P8SYsDXPsMzSlJv9
 bc5A==
X-Gm-Message-State: APjAAAX/oauhdHwMx2LnDqbXe3lfxVpBo3TG6QOsx9dGetccy7rx7pRu
 4b/tS5WONwBLVK1ExvFxqklgpDDWBsW+8Jyg0+lZsaDuyTUePz4d5PzNxudejgwAMDDxT0QxIzV
 WqSj/I189m8tD0t4=
X-Received: by 2002:a0c:efcd:: with SMTP id a13mr13595977qvt.94.1571914779710; 
 Thu, 24 Oct 2019 03:59:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaOsl5ABF08L3LOb+EhdpaTS551adpaBFZEJFO8To0+J6YJ0oinqx9sZ7RgI3lwvgSwZ5PWg==
X-Received: by 2002:a0c:efcd:: with SMTP id a13mr13595963qvt.94.1571914779416; 
 Thu, 24 Oct 2019 03:59:39 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v4sm12551280qkj.28.2019.10.24.03.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:59:38 -0700 (PDT)
Date: Thu, 24 Oct 2019 06:59:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191024065826-mutt-send-email-mst@kernel.org>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <157166664425.24734.3489596262271351160@37313f22b938>
 <20191021143357.GB5837@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021143357.GB5837@work-vm>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 03:33:57PM +0100, Dr. David Alan Gilbert wrote:
> * no-reply@patchew.org (no-reply@patchew.org) wrote:
> > Patchew URL: https://patchew.org/QEMU/20191021105832.36574-1-dgilbert@redhat.com/
> > 
> > 
> > 
> > Hi,
> > 
> > This series seems to have some coding style problems. See output below for
> > more information:
> > 
> > Subject: [PATCH 00/30] virtiofs daemon (base)
> > Type: series
> > Message-id: 20191021105832.36574-1-dgilbert@redhat.com
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> 
> Expecting checkpatch to be broken here; most of the files
> follow FUSE's formatting.
> 
> Dave

I wonder what do others think about this.
One problem with such inconsistencies is that people tend to copy code
around, which tends to result in a mess.

> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

