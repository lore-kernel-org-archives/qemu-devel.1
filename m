Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE82C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 01:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3BB2238C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 01:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3BB2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq5gv-0001Hq-Et
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 21:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hq5gj-0000te-IH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hq5gi-0001Zm-I4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:03:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:22611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hq5gi-0001Wu-9C
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 21:03:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2019 18:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; d="scan'208";a="369095099"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2019 18:03:16 -0700
Date: Wed, 24 Jul 2019 09:02:52 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190724010252.GA15432@richard>
References: <20190710081111.10302-1-richardw.yang@linux.intel.com>
 <20190719174128.GI3000@work-vm> <20190722063941.GA2602@richard>
 <20190723154212.GL2719@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723154212.GL2719@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: use static
 PostcopyDiscardState instead of allocating it for each block
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 04:42:12PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Fri, Jul 19, 2019 at 06:41:28PM +0100, Dr. David Alan Gilbert wrote:
>> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> Even we need to do discard for each RAMBlock, we still can leverage the
>> >> same memory space to store the information.
>> >> 
>> >> By doing so, we avoid memory allocation and deallocation to the system
>> >> and also avoid potential failure of memory allocation which breaks the
>> >> migration.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  migration/postcopy-ram.c | 16 +++++++---------
>> >>  1 file changed, 7 insertions(+), 9 deletions(-)
>> >> 
>> >> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> >> index 9faacacc9e..2e6b076bb7 100644
>> >> --- a/migration/postcopy-ram.c
>> >> +++ b/migration/postcopy-ram.c
>> >> @@ -1377,8 +1377,7 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
>> >>   *   asking to discard individual ranges.
>> >>   *
>> >>   * @ms: The current migration state.
>> >> - * @offset: the bitmap offset of the named RAMBlock in the migration
>> >> - *   bitmap.
>> >> + * @offset: the bitmap offset of the named RAMBlock in the migration bitmap.
>> >>   * @name: RAMBlock that discards will operate on.
>> >>   *
>> >>   * returns: a new PDS.
>> >> @@ -1386,13 +1385,14 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
>> >>  PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
>> >>                                                   const char *name)
>> >>  {
>> >> -    PostcopyDiscardState *res = g_malloc0(sizeof(PostcopyDiscardState));
>> >> +    static PostcopyDiscardState res = {0};
>> >
>> >Do you think it would be better to make this a static at the top of
>> >migration/postcopy-ram.c and then we could remove the pds parameters
>> >from postcopy_discard_send_range and friends?
>> 
>> Just took a look into this one. One problem is not all its friends are in
>> migration/postcopy-ram.c
>> 
>> For example, postcopy_chunk_hostpages_pass() is in migration/ram.c.
>
>But doesn't that just pass teh pds back to postcopy_discard_send_range
>which is in postcopy-ram ?

You are right, I didn't notice this.

>
>Dave
>

