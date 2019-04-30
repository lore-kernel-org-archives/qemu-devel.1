Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 22:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351182087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k65TvjD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351182087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54533 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLbNU-0006dH-8D
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 18:37:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hLbMb-0006IY-KF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hLbMZ-0003mO-MM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:36:37 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hLbMX-0003hK-KG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:36:33 -0400
Received: by mail-ed1-x544.google.com with SMTP id g57so7112118edc.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ZI6NY/moh0xs2zYQrUW+IOs8uUF/+dw8ZjA7O8snpZ4=;
	b=k65TvjD87P7qdEQR772wEIy+NCVdDAVw/f82WtJPHngs81FMdxJxA2SLIHQu/PmTbS
	SUQzKQUwvY3JZesTerNJ5ovnEZDmSRChDf2G6pEyxG+TMxpwTfcxHSwZqL8D+WoRnlkQ
	UwownE0ram6MbnIapXm3s52X+X1QlnQCLY8Q5GF0H66zmtt0cvqeWSinuQRw6BZxCEpf
	Rz7hRM0rJZrhKfEj0/cMrKZL77kYbB4G3EcUlFTg+IoP87uxcFdTGGAu5TwuoZ4bLwvo
	tPk5aa2OkrbuOoq3PTv8DOSBlTNbENm7OVf1YxZkISalldg+4AgxAmR8YVAnuurybK+l
	WLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ZI6NY/moh0xs2zYQrUW+IOs8uUF/+dw8ZjA7O8snpZ4=;
	b=oBHWJ3bt77WxOVUKApcXK7m1h7pidsWEOgn3DpFTsoCaakBMlARk07KU82apT/V9L5
	g4MiIz8nLRisQMUcQWIv/1yvyJSTfsrvHzATPfMjSRE+Ui+14oh3J4NWtPuGn+25m0qB
	VafPZ10w9w3YZS8lt4/cXBnjRg99vbtWZKL0ek8qlh5CdbeN+PXeMoa7Jwms5aRZu7uE
	X4QoTrkgcLjXSQWLdJGr0Fs29UmV6F7yfxlihwVY7Qi/G0DAewNdMKiou5mPSMbkErpJ
	HS5AgRsSP9emkUn07zOtVAS8Z+8UklXU6dzI1BouEKWrdFeLh/6PoRuw69uR9SdjOykT
	P6Ag==
X-Gm-Message-State: APjAAAXruaa0vd5GFAQHPeDy8Za2UpzCJb4YHWZY/z+vLfhQXiXA6lho
	CZIdDheCE46DubwkPiS7+HM=
X-Google-Smtp-Source: APXvYqxKd5t6dSG/lo3FRr7o/1lSxu+hHYoAB1Mjte5I9QmZBCmsXcoz1jhrLThEY0kpL9Cg/ZvD2Q==
X-Received: by 2002:a50:8b24:: with SMTP id l33mr44293516edl.235.1556663780471;
	Tue, 30 Apr 2019 15:36:20 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	i41sm8778555ede.36.2019.04.30.15.36.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 15:36:19 -0700 (PDT)
Date: Tue, 30 Apr 2019 22:36:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190430223618.lyl3ribm7gg5haa5@master>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430204636.GK28722@habkost.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v15 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	stefanha@redhat.com, qemu-devel@nongnu.org,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	Wei Yang <richardw.yang@linux.intel.com>,
	Haozhong Zhang <haozhong.zhang@intel.com>, pbonzini@redhat.com,
	imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430223618.7c7siTc1rbXgxuU_FHlMl8QEjXGrdst6JhcXKUKgl68@z>

On Tue, Apr 30, 2019 at 05:46:36PM -0300, Eduardo Habkost wrote:
>Hi,
>
>On Fri, Apr 26, 2019 at 08:36:51AM +0800, Wei Yang wrote:
>> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>> 
>> When a file supporting DAX is used as vNVDIMM backend, mmap it with
>> MAP_SYNC flag in addition which can ensure file system metadata
>> synced in each guest writes to the backend file, without other QEMU
>> actions (e.g., periodic fsync() by QEMU).
>> 
>> Current, We have below different possible use cases:
>> 
>> 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>>    a: backend is a dax supporting file.
>>     - MAP_SYNC will active.
>>    b: backend is not a dax supporting file.
>>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
>> 
>> 2. The rest of cases:
>>    - we will never pass the MAP_SYNC to mmap2
>> 
>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> [ehabkost: Rebased patch to latest code on master]
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Tested-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> 
>> ---
>> v15: fix compile issue on pre-linux4.15
>> v14: rebase on top of current upstream
>
>Note that v14 was already merged, so the build fix would need to
>be submitted separately.  However:
>

Sure, I would spin a separate patch.

>[...]
>> +#ifdef CONFIG_LINUX
>> +#include <linux/mman.h>
>> +#endif /* CONFIG_LINUX */
>> +
>> +#ifndef MAP_SYNC
>> +#define MAP_SYNC 0
>> +#endif
>> +#ifndef MAP_SHARED_VALIDATE
>> +#define MAP_SHARED_VALIDATE 0
>> +#endif
>
>Why would we need this, if we added copies of mman.h to
>linux-headers?

This is reported by Stefan.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg612168.html

>
>-- 
>Eduardo

-- 
Wei Yang
Help you, Help me

