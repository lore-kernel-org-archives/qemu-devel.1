Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C88AC73C66
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 02:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244BE20868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 02:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmqT6-0004YB-54
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 22:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hmqSw-00049s-Dk
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 22:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hmqSv-0007l9-Fi
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 22:11:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:48610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hmqSv-0007kc-6F
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 22:11:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jul 2019 19:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; d="scan'208";a="365732998"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2019 19:11:42 -0700
Date: Mon, 15 Jul 2019 10:11:16 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190715021116.GA15947@richard>
References: <20190715020549.15018-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715020549.15018-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH v2] migration/postcopy: fix document of
 postcopy_send_discard_bm_ram()
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 10:05:49AM +0800, Wei Yang wrote:
>Commit 6b6712efccd3 ('ram: Split dirty bitmap by RAMBlock') changes the
>parameter of postcopy_send_discard_bm_ram(), while left the document
>part untouched.
>
>This patch correct the document and fix two typo by hand.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Oops, I missed this. Sorry Philippe :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>---
>v2: fix typo in function name, pointed by Dave
>---
> migration/ram.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/migration/ram.c b/migration/ram.c
>index 246efe6939..e019c925b2 100644
>--- a/migration/ram.c
>+++ b/migration/ram.c
>@@ -2763,8 +2763,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>  *
>  * @ms: current migration state
>  * @pds: state for postcopy
>- * @start: RAMBlock starting page
>- * @length: RAMBlock size
>+ * @block: RAMBlock to discard
>  */
> static int postcopy_send_discard_bm_ram(MigrationState *ms,
>                                         PostcopyDiscardState *pds,
>@@ -2961,7 +2960,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
> }
> 
> /**
>- * postcopy_chuck_hostpages: discrad any partially sent host page
>+ * postcopy_chunk_hostpages: discard any partially sent host page
>  *
>  * Utility for the outgoing postcopy code.
>  *
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me

