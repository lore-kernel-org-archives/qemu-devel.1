Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FEFC10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 00:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C8320833
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 00:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C8320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIN3j-0006MH-7h
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 20:43:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hIN2t-00065V-KZ
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hIN2s-0008Hy-N2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:42:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:46237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hIN2s-0008GN-EL
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:42:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Apr 2019 17:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,379,1549958400"; d="scan'208";a="339503332"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2019 17:37:44 -0700
Date: Mon, 22 Apr 2019 08:37:16 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190422003716.GA1570@richard>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
	<5d07bf7e9a3e576f5a87e81d786e8886fb2bb551.1549555521.git.yi.z.zhang@linux.intel.com>
	<20190418220516.GP25134@habkost.net>
	<20190418223301.GQ25134@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418223301.GQ25134@habkost.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH V13 4/5] util/mmap-alloc: support MAP_SYNC
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
	Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, "Zhang,
	Yi" <yi.z.zhang@linux.intel.com>, yu.c.zhang@linux.intel.com,
	richardw.yang@linux.intel.com, stefanha@redhat.com,
	imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422003716.77cjNOJol2jOUCaYdz7X-Pb0r9zVmuoFeL5qUfqbY38@z>

On Thu, Apr 18, 2019 at 07:33:01PM -0300, Eduardo Habkost wrote:
>On Thu, Apr 18, 2019 at 07:05:16PM -0300, Eduardo Habkost wrote:
>> Hi,
>> 
>> I found out that this series missed QEMU 4.0 and I was going to
>> queue for 4.1, but unfortunately this patch conflicts with:
>> 
>> commit 2044c3e7116eeac0449dcb4a4130cc8f8b9310da
>> Author: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>> Date:   Wed Jan 30 21:36:04 2019 -0200
>> 
>>     mmap-alloc: unfold qemu_ram_mmap()
>[...]
>> On Fri, Feb 08, 2019 at 06:11:11PM +0800, Zhang, Yi wrote:
>> > From: Zhang Yi <yi.z.zhang@linux.intel.com>
>> > 
>> > When a file supporting DAX is used as vNVDIMM backend, mmap it with
>> > MAP_SYNC flag in addition which can ensure file system metadata
>> > synced in each guest writes to the backend file, without other QEMU
>> > actions (e.g., periodic fsync() by QEMU).
>> > 
>> > Current, We have below different possible use cases:
>> > 
>> > 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>> >    a: backend is a dax supporting file.
>> >     - MAP_SYNC will active.
>> >    b: backend is not a dax supporting file.
>> >     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
>> > 
>> > 2. The rest of cases:
>> >    - we will never pass the MAP_SYNC to mmap2
>> > 
>> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>
>Untested patch rebase is below.  Can Intel help test it and
>submit v14?
>

Thanks Eduardo, the patch looks good to me and I have tested it.

-- 
Wei Yang
Help you, Help me

