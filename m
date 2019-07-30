Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28EEC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931ED20651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931ED20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGDP-0005aJ-Pm
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hsGCo-000597-5x
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hsGCn-0002Mg-1N
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:41:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:22186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hsGCm-0002Ks-Nc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:41:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jul 2019 17:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; d="scan'208";a="182953253"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 29 Jul 2019 17:41:25 -0700
Date: Tue, 30 Jul 2019 08:41:03 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190730004103.GA17604@richard>
References: <1564387281-12321-1-git-send-email-ivanren@tencent.com>
 <1564387281-12321-2-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564387281-12321-2-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: add
 qemu_file_update_transfer interface
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 04:01:19PM +0800, Ivan Ren wrote:
>Add qemu_file_update_transfer for just update bytes_xfer for speed
>limitation. This will be used for further migration feature such as
>multifd migration.
>
>Signed-off-by: Ivan Ren <ivanren@tencent.com>

Well I have reviewed this patch, suppose you need add my Reviewed-by.

>---
> migration/qemu-file.c | 5 +++++
> migration/qemu-file.h | 1 +
> 2 files changed, 6 insertions(+)
>
>diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>index 0431585502..18f480529a 100644
>--- a/migration/qemu-file.c
>+++ b/migration/qemu-file.c
>@@ -615,6 +615,11 @@ void qemu_file_reset_rate_limit(QEMUFile *f)
>     f->bytes_xfer = 0;
> }
> 
>+void qemu_file_update_transfer(QEMUFile *f, int64_t len)
>+{
>+    f->bytes_xfer += len;
>+}
>+
> void qemu_put_be16(QEMUFile *f, unsigned int v)
> {
>     qemu_put_byte(f, v >> 8);
>diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>index 13baf896bd..5de9fa2e96 100644
>--- a/migration/qemu-file.h
>+++ b/migration/qemu-file.h
>@@ -147,6 +147,7 @@ int qemu_peek_byte(QEMUFile *f, int offset);
> void qemu_file_skip(QEMUFile *f, int size);
> void qemu_update_position(QEMUFile *f, size_t size);
> void qemu_file_reset_rate_limit(QEMUFile *f);
>+void qemu_file_update_transfer(QEMUFile *f, int64_t len);
> void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
> int64_t qemu_file_get_rate_limit(QEMUFile *f);
> void qemu_file_set_error(QEMUFile *f, int ret);
>-- 
>2.17.2 (Apple Git-113)
>

-- 
Wei Yang
Help you, Help me

