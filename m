Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE7C10F11
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 02:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1371206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 02:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1371206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIlOx-0002Bj-Qz
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 22:43:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hIlOA-0001ov-Cy
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 22:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hIlO9-0001zO-5z
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 22:42:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:43349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hIlO8-0001wZ-UZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 22:42:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Apr 2019 19:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; d="scan'208";a="151518380"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2019 19:42:18 -0700
Date: Tue, 23 Apr 2019 10:41:51 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190423024151.GA10783@richard>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422083013-mutt-send-email-mst@kernel.org>
	<20190422182255.GV25134@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422182255.GV25134@habkost.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v14 0/2] support MAP_SYNC for
 memory-backend-file
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	Wei Yang <richardw.yang@linux.intel.com>, stefanha@redhat.com,
	imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423024151.r7GydGnU87pOsceVqhXFypVs3mpRk8NBfm1D764RuLU@z>

On Mon, Apr 22, 2019 at 03:22:55PM -0300, Eduardo Habkost wrote:
>On Mon, Apr 22, 2019 at 08:34:51AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Apr 22, 2019 at 08:48:47AM +0800, Wei Yang wrote:
>> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
>> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
>> > files on ext4/xfs file system mounted with '-o dax').
>> > 
>> > A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
>> >     https://patchwork.kernel.org/patch/10028151/
>> > 
>> > In order to make sure that the file metadata is in sync after a fault 
>> > while we are writing a shared DAX supporting backend files, this
>> > patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.
>> > 
>> > As the DAX vs DMA truncated issue was solved, we refined the code and
>> > send out this feature for the v5 version.
>> > 
>> > We will pass MAP_SYNC to mmap(2); if MAP_SYNC is supported and
>> > 'share=on' & 'pmem=on'. 
>> > Or QEMU will not pass this flag to mmap(2)
>> 
>> OK this is in a good shape. As we are in freeze anyway,
>> there's still a bit more time to polish it. I have a couple of
>> suggestions:
>> 
>> - squash docs in same patch with code, no need for two patches
>> - mmap errors are not silently ignored as the doc says,
>>   a warning is produced
>
>Note that a warning is produced only if both share=on and pmem=on
>is specified.  If using pmem=on without share=on, no warning is
>printed at all.
>
>I agree we could squash the docs in the same patch, but I don't
>want to prevent the code from being merged and require v15 to be
>sent just because we are still polishing the documentation.
>
>If there are no objections, I plan to apply this version of the
>series including the following fixup (just removing the word
>"silently"), and I suggest further improvements to be sent as
>follow up patches.
>

If my understanding is correct, the following up patch is:

"send the warnings to an errp object and not stderr"

-- 
Wei Yang
Help you, Help me

