Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F9C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E862148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E862148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ6JE-0007Ve-FB
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 21:02:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6IF-0007CV-6T
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6IE-0003PI-07
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:01:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:12614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ6ID-0003Lx-Mw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:01:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Apr 2019 18:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; d="scan'208";a="138267874"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 23 Apr 2019 18:01:32 -0700
Date: Wed, 24 Apr 2019 09:01:05 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190424010105.GA12824@richard>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-2-richardw.yang@linux.intel.com>
	<20190423092518.GD32465@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423092518.GD32465@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com,
	yu.c.zhang@linux.intel.com, Wei Yang <richardw.yang@linux.intel.com>,
	Haozhong Zhang <haozhong.zhang@intel.com>, imammedo@redhat.com,
	pbonzini@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424010105.HeG1_cHsnZz_O-h9laCMIqmnsaGrA9hLr6OBYDe8AEA@z>

On Tue, Apr 23, 2019 at 10:25:18AM +0100, Stefan Hajnoczi wrote:
[...]
>> +#ifdef CONFIG_LINUX
>> +#include <linux/mman.h>
>> +#else  /* !CONFIG_LINUX */
>> +#define MAP_SYNC              0x0
>> +#define MAP_SHARED_VALIDATE   0x0
>> +#endif /* CONFIG_LINUX */
>
>MAP_SHARED_VALIDATE is is from 2017:
>
>  commit 1c9725974074a047f6080eecc62c50a8e840d050
>  Author: Dan Williams <dan.j.williams@intel.com>
>  Date:   Wed Nov 1 16:36:30 2017 +0100
>
>    mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags
>
>This code fails to compile on Linux hosts with pre-4.15 headers.
>

Ok, qemu build will fail on pre-4.15 linux.

>Instead you could use the following (even on Linux!):
>
>  #ifndef MAP_SYNC
>  #define MAP_SYNC 0
>  #endif
>  #ifndef MAP_SHARED_VALIDATE
>  #define MAP_SHARED_VALIDATE 0
>  #endif
>
>Either way:

You mean replace the above code to:

#ifdef CONFIG_LINUX
#include <linux/mman.h>
#endif /* CONFIG_LINUX */

#ifndef MAP_SYNC
#define MAP_SYNC 0
#endif
#ifndef MAP_SHARED_VALIDATE
#define MAP_SHARED_VALIDATE 0
#endif

>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



-- 
Wei Yang
Help you, Help me

