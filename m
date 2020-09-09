Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01046C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E2C21D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WINKRaKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E2C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxBB-0005vY-H6
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFxA7-0004lN-IQ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:17:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFxA5-00039J-O5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599646628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xprktIkyqonQ0bDJ1sLc4HrIOQ0hafI/xwlPrGGjZg=;
 b=WINKRaKoVqXOMZZ+LQi1q/+W/63SByZQh3iqHgLa67Z932AVu9omdTNrMOi8rmScsWUKqK
 b9gik0NNxnAxSQiHF5igEqYTOISvupAGyZk6rQDjYTvOA45fQv0Jzxa2FxmMzmbgaEPB2x
 mGkw5gbtRArVDXWwcbkTBa0QgDPSuqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-ohRwg6DON1aM8VIbplLyDw-1; Wed, 09 Sep 2020 06:17:05 -0400
X-MC-Unique: ohRwg6DON1aM8VIbplLyDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E8B310ABDA1;
 Wed,  9 Sep 2020 10:17:04 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57C5660C0F;
 Wed,  9 Sep 2020 10:17:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] gitmodules: switch to qemu.org qboot mirror
Date: Wed,  9 Sep 2020 11:16:40 +0100
Message-Id: <20200909101642.17698-2-stefanha@redhat.com>
In-Reply-To: <20200909101642.17698-1-stefanha@redhat.com>
References: <20200909101642.17698-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSBub3cgaG9zdHMgYSBtaXJyb3Igb2YgcWJvb3QuZ2l0LiBRRU1VIG1pcnJvcnMgdGhpcmQt
cGFydHkgY29kZSB0bwplbnN1cmUgdGhhdCB1c2VycyBjYW4gYWx3YXlzIGJ1aWxkIFFFTVUgZXZl
biBpZiB0aGUgZGVwZW5kZW5jeSBnb2VzCm9mZmxpbmUgYW5kIHNvIFFFTVUgbWVldHMgaXRzIHJl
c3BvbnNpYmlsaXRpZXMgdG8gcHJvdmlkZSBmdWxsIHNvdXJjZQpjb2RlIHVuZGVyIHNvZnR3YXJl
IGxpY2Vuc2VzLgoKU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+CkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogLmdpdG1v
ZHVsZXMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS8uZ2l0bW9kdWxlcyBiLy5naXRtb2R1bGVzCmluZGV4IGNlOTc5Mzk4
YTguLmIyMDE2NzUyODggMTAwNjQ0Ci0tLSBhLy5naXRtb2R1bGVzCisrKyBiLy5naXRtb2R1bGVz
CkBAIC01Nyw3ICs1Nyw3IEBACiAJdXJsID0gCWh0dHBzOi8vZ2l0LnFlbXUub3JnL2dpdC9vcGVu
c2JpLmdpdAogW3N1Ym1vZHVsZSAicm9tcy9xYm9vdCJdCiAJcGF0aCA9IHJvbXMvcWJvb3QKLQl1
cmwgPSBodHRwczovL2dpdGh1Yi5jb20vYm9uemluaS9xYm9vdAorCXVybCA9IGh0dHBzOi8vZ2l0
LnFlbXUub3JnL2dpdC9xYm9vdC5naXQKIFtzdWJtb2R1bGUgIm1lc29uIl0KIAlwYXRoID0gbWVz
b24KIAl1cmwgPSBodHRwczovL2dpdGh1Yi5jb20vbWVzb25idWlsZC9tZXNvbi8KLS0gCjIuMjYu
MgoK


