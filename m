Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E940C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 23:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB2820820
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 23:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB2820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPFLJ-0003pd-75
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 19:54:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hPFKT-0003Th-5d
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hPFKS-0008Mm-7h
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:53:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hPFKS-0008Lo-2R
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA7373082E20;
	Fri, 10 May 2019 23:53:25 +0000 (UTC)
Received: from xz-x1 (ovpn-12-65.pek2.redhat.com [10.72.12.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D11A96013A;
	Fri, 10 May 2019 23:53:20 +0000 (UTC)
Date: Sat, 11 May 2019 07:53:18 +0800
From: Peter Xu <peterx@redhat.com>
To: Li Qiang <liq3ea@163.com>
Message-ID: <20190510235318.GO18465@xz-x1>
References: <20190510164349.81507-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510164349.81507-1-liq3ea@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 10 May 2019 23:53:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] hw: edu: some fixes
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
Cc: pbonzini@redhat.com, liq3ea@gmail.com, jslaby@suse.cz,
	qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 09:43:46AM -0700, Li Qiang wrote:
> Recently I am considering write a driver for edu device.

I don't know why you wanted to write it, but there's one (though I
don't even remember whether it's working or not)...

https://github.com/xzpeter/clibs/blob/master/gpl/linux_kernel/edu_device_driver/edu.c

Regards,

-- 
Peter Xu

