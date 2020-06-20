Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE98C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 13:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946F923B8B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 13:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XucwHUZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946F923B8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmdd2-0001rC-To
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 09:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmdbj-0000I8-Kn
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 09:32:31 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmdbi-0003H7-5b
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 09:32:31 -0400
Received: by mail-ej1-x642.google.com with SMTP id n24so13314191ejd.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6A70r10UqwNPv6j5EPw/nw3u2xwDuBB18TdeRszHq/8=;
 b=XucwHUZYA6/iTLoKLs7Sxf8+ww8cJpFMBFIrzSSx4V4Q5DFFg6CdC9YP+smdvj/mnI
 FdcOimzvRcvr7szzEjBaD2IJ6DUz5pXw424eHHHYOh9Z0/IqvIH8cFbGjo0M3AuSmETM
 cDe4MogCk2AFeGZ0FiFvQ0lTMMrh2aNCrQ9EOWO4pCq7ZeOPwSD8NPUWBboIozvrx01G
 MmAZssbdoQpndg5/nN6N9ZG7U2jjJyoI0ZPggUvOgFL4jjheiAh2/NacbprcAjR6OxCj
 cyjkuW+kHtLIoINFSJY+edEc7IjFXckKXkgoH4N6BdwwX9nGc2aWdzXbdt51FkVCsZx1
 TVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6A70r10UqwNPv6j5EPw/nw3u2xwDuBB18TdeRszHq/8=;
 b=IalScX3x1Beg7loeJq2Pu/2l+PUCmdD6cP7Nqbjkb5Xf2U6fJ4/E7FqYTVv6huCBgL
 B4N+yIEEE900wu/tZyT595q2aA9/vRIIYrCEPvM1WvINugfR4RbzEsGYzs9+gf/hZbPV
 9LKQJR623CA6PJfKMxe5REkhFfRDDTMaswx4OwYk9xqK+AtZz7TEyJjX94zk5CLfmi3K
 M0dOwNgMpMFxGepjK32dGwzt9Yudah0ceuIXUVH9rrCkhOCLqYdSKrDF6X+6AAP7BvTU
 Y/lCl50FWWHr3/5zvbmHTlZ7oya49EascalMcrPmAZ+aQU9Z0kty5kSlH4cnzKkAmQdn
 gpNw==
X-Gm-Message-State: AOAM5306tFcZ7PCpB+/RG7QUk5IYdypPvv9O0rhpTROxWyU0LslyHVbQ
 Ay2iRoVnoZ5FVnvis03mU/Vnmlu4
X-Google-Smtp-Source: ABdhPJzaxVj3XG71RJZHmmNJgbVc2lPvYYRfa/t0Bd8rBO6Y86NXDV6ZXSaykhMNG/47W2KNkwJLTw==
X-Received: by 2002:a17:906:454b:: with SMTP id
 s11mr8352453ejq.546.1592659948802; 
 Sat, 20 Jun 2020 06:32:28 -0700 (PDT)
Received: from localhost.localdomain (net252-38-245-109.mbb.telenor.rs.
 [109.245.38.252])
 by smtp.gmail.com with ESMTPSA id bd19sm7453202edb.2.2020.06.20.06.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 06:32:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] checkpatch: Rename top_of_kernel_tree() to
 top_of_qemu_tree()
Date: Sat, 20 Jun 2020 15:32:06 +0200
Message-Id: <20200620133207.26849-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This subroutine establishes top of qemu, not kernel, tree.

Do appropriate renaming.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0ba213e9f2..c760c5a4a9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -190,14 +190,14 @@ if ($terse) {
 
 if ($tree) {
 	if (defined $root) {
-		if (!top_of_kernel_tree($root)) {
+		if (!top_of_qemu_tree($root)) {
 			die "$P: $root: --root does not point at a valid tree\n";
 		}
 	} else {
-		if (top_of_kernel_tree('.')) {
+		if (top_of_qemu_tree('.')) {
 			$root = '.';
 		} elsif ($0 =~ m@(.*)/scripts/[^/]*$@ &&
-						top_of_kernel_tree($1)) {
+						top_of_qemu_tree($1)) {
 			$root = $1;
 		}
 	}
@@ -456,7 +456,7 @@ if ($chk_branch) {
 
 exit($exit);
 
-sub top_of_kernel_tree {
+sub top_of_qemu_tree {
 	my ($root) = @_;
 
 	my @tree_check = (
-- 
2.20.1


