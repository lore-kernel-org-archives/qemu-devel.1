Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06AFC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C612E206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C612E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJp8w-0005q2-FW
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 20:55:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJp8B-0004gs-Kr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJp5v-0004mX-V4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:52:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:18636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJp5v-0004jR-Ku
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:52:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 17:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; d="scan'208";a="340874543"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2019 17:52:00 -0700
Date: Fri, 26 Apr 2019 08:51:33 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20190426005133.GB25513@richard>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
	<0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426005133.oq88w4Zcnqn2vTwF8emWkESToLeO7Mr6F_iA9nvNM8E@z>

On Thu, Apr 25, 2019 at 05:55:15PM -0300, Daniel Henrique Barboza wrote:
>
>
>On 4/23/19 9:46 PM, Wei Yang wrote:
>> migration_is_blocked() is used in migrate_prepare() and
>> save_snapshot(), this is more proper to use this instead of
>> qemu_savevm_state_blocked() in qemu_loadvm_state().
>
>
>migration_is_blocked() does an additional verification:
>
>"if (migration_blockers)"
>
>comparing to what was previously done in qemu_loadvm_state.
>
>I've checked what migration_blockers does and it is a GList used
>for callers to block the migration process. This is used via
>'migration_add_blocker', from migration.c.
>
>'migration_add_blocker' is called all over the place, most notably
>in  _realize() functions  and _open() functions from block.
>
>Thus, I am not sure if this change will impact the use of
>qemu_loadvm_state() from load_snapshot() (i.e. can load_snapshot
>be called with migration_blockers?). It's better to someone
>with a better understanding of this code to comment on that.
>

Well, when you look into the source side of migration:

qmp_migrate
  migrate_prepare
    migration_is_blocked

This means if migration_is_blocked fails, the source will not start migration.
And it is the same as save_snapshot.

From my understanding, when we load a vm, it should check the same
requirement.

-- 
Wei Yang
Help you, Help me

