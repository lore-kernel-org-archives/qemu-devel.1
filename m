Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB836C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25E32067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25E32067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK8Q1-0006oJ-OP
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 18:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iK8OC-0005bO-Qs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iK8OA-0001ef-8Z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:00:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:21111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iK8OA-0001e6-02
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:00:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 15:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; d="scan'208";a="189157797"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga008.jf.intel.com with ESMTP; 14 Oct 2019 15:00:22 -0700
Date: Tue, 15 Oct 2019 06:00:07 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] refine memory_device_get_free_addr
Message-ID: <20191014220007.GC15059@richard>
References: <20190730003740.20694-1-richardw.yang@linux.intel.com>
 <20190913234746.jb5a5vlwl6cebudz@master>
 <20190914154026-mutt-send-email-mst@kernel.org>
 <20191012090209.GA6047@richard> <20191014150547.GR4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014150547.GR4084@habkost.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Wei Yang <richard.weiyang@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 12:05:47PM -0300, Eduardo Habkost wrote:
>On Sat, Oct 12, 2019 at 05:02:09PM +0800, Wei Yang wrote:
>> On Sat, Sep 14, 2019 at 03:40:41PM -0400, Michael S. Tsirkin wrote:
>> >On Fri, Sep 13, 2019 at 11:47:46PM +0000, Wei Yang wrote:
>> >> On Tue, Jul 30, 2019 at 08:37:38AM +0800, Wei Yang wrote:
>> >> >When we iterate the memory-device list to get the available range, it is not
>> >> >necessary to iterate the whole list.
>> >> >
>> >> >1) no more overlap for hinted range if tmp exceed it
>> >> >
>> >> >v2:
>> >> >   * remove #2 as suggested by Igor and David
>> >> >   * add some comment to inform address assignment stay the same as before
>> >> >     this change 
>> >> >
>> >> >Wei Yang (2):
>> >> >  memory-device: not necessary to use goto for the last check
>> >> >  memory-device: break the loop if tmp exceed the hinted range
>> >> >
>> >> > hw/mem/memory-device.c | 3 ++-
>> >> > 1 file changed, 2 insertions(+), 1 deletion(-)
>> >> >
>> >> 
>> >> Would someone take this patch set?
>> >
>> >yes looks good to me too.
>> >Eduardo?
>> >
>> 
>> Hmm... I don't see this any where. May I ask the status?
>
>Sorry, I hadn't seen Michael's message.  Queued on machine-next.
>Thanks!
>

Thanks~ have a nice day.

>-- 
>Eduardo

-- 
Wei Yang
Help you, Help me

