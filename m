Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52119C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 00:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6888A223FD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 00:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YuSBPnKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6888A223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUf7C-0003Bs-D6
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 20:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUf5s-0002jJ-HL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 20:01:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUf5q-0006GN-90
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 20:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=RuOTqBAMk3mm4SdV4HQ5pcyCq4zbV9oz6iHJZftxfzs=; b=YuSBPnKtkjVYSTnfTORgGw1eAn
 6XVu9b2kDSGNPtHOHfjk6KrYrbhdFfrCN+Qq64Xpu2zaLLtXObweVfYeuOQmYTnMxtiEBxN8EArSH
 1naH2sKAI++7OSQgFcjdK2pmd9HpKCCLT94XaOlwk8Sdp08Ok447KxpdT26eEQX5eaxYVpOO659u1
 r+NMCGjr9E5ZfFmsce7h+e/xPjZBB8Hvs3hMMkGxVe3+3nUbDC151VCXqxz506EW5+R6t3LLQrXNU
 vDiwB4KxjsUtDz/7RbZ+ZAFpZ4NZvjOTKnNOWam5N5+9X/WBc84k5HVuR4wjHDlmmzQYRywweG5L6
 nDKoL45Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 7/8] tests/9pfs: add local Tlink test
Date: Tue, 20 Oct 2020 02:01:30 +0200
Message-ID: <4187116.WyENfdrYhA@silver>
In-Reply-To: <ee6d9e1147d05bcf0b51b02ef6757f4b4691ba2d.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
 <ee6d9e1147d05bcf0b51b02ef6757f4b4691ba2d.1603149434.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 19:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 20. Oktober 2020 01:13:24 CEST Christian Schoenebeck wrote:
> This test case uses a Tlink request to create a hard link to a regular
> file using the 9pfs 'local' fs driver.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 61 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index f7d18f6274..447d8e3344 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -260,6 +260,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RMKDIR ? "RMKDIR" :
>          id == P9_RLCREATE ? "RLCREATE" :
>          id == P9_RSYMLINK ? "RSYMLINK" :
> +        id == P9_RLINK ? "RLINK" :
>          id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :
>          id == P9_RREADDIR ? "READDIR" :
> @@ -742,6 +743,33 @@ static void v9fs_rsymlink(P9Req *req, v9fs_qid *qid)
>      v9fs_req_free(req);
>  }
> 
> +/* size[4] Tlink tag[2] dfid[4] fid[4] name[s] */
> +static P9Req *v9fs_tlink(QVirtio9P *v9p, uint32_t dfid, uint32_t fid,
> +                         const char *name, uint16_t tag)
> +{

This hard-link test was actually motived by an issue that I recently 
encountered on a machine: it fails to create any hard links with 9p. This 
particular test case succeeds though.

I think the problem is that recent libvirt versions enable qemu's sandbox 
feature by default which filters syscalls. Fact is, any linkat() call fails on 
that machine with EACCES now. I couldn't reproduce it on my development 
machine yet though. I guess it's a difference in white/black-list seccomp 
config or something. Not sure yet if there is some change required on 9p side 
or whether it's really just a seccomp config issue.

P.S. Noisy days from my side, but this is probably the last batch of patches 
from my side in a while, unless I really need to fix something for that hard 
link isssue. We'll see ...

Best regards,
Christian Schoenebeck



