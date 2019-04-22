Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E8DC10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF0920859
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF0920859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hINKB-0001uE-I7
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 21:00:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINJN-0001Yi-4P
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINJM-000645-9P
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:59:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:25428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hINJM-00063d-20
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:59:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Apr 2019 17:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,379,1549958400"; d="scan'208";a="144560913"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 21 Apr 2019 17:59:53 -0700
Date: Mon, 22 Apr 2019 08:59:25 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190422005925.GA26676@richard>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190321082555.21118-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH 0/6] Refine exec
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
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422005925.FSvjr6QfLaW66XhQ6ITH0LPGQLx56IaLhiS3ViGqIUc@z>

Ping for this trivial series.

On Thu, Mar 21, 2019 at 04:25:49PM +0800, Wei Yang wrote:
>This serial refine exec a little.
>
>Wei Yang (6):
>  exec.c: replace hwaddr with uint64_t for better understanding
>  exec.c: remove an unnecessary assert on PHYS_MAP_NODE_NIL in
>    phys_map_node_alloc()
>  exec.c: get nodes_nb_alloc with one MAX calculation
>  exec.c: subpage->sub_section is already initialized to 0
>  exec.c: correct the maximum skip value during compact
>  exec.c: add a check between constants to see whether we could skip
>
> exec.c | 21 ++++++++++-----------
> 1 file changed, 10 insertions(+), 11 deletions(-)
>
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me

