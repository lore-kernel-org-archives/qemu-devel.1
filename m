Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C19C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A1520829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUeZAlfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A1520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIApO-0004Ho-Di
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIAhS-0002ER-OZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:08:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIAhR-0007Af-4I
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600175324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LjcNDMEUNK8iwRNlCw+YdLpST0QIOxR9GG4Fp17R5Y=;
 b=MUeZAlfvZ9ziJr9aKa7Qxz0alYI+dhH/kIgP3UPZ/Th1MMic7160spZfatvtjXrrxVeMAy
 NTs7aPU4sfXF2drvyfn7zDFx6OOs1UXPDePaKzHT9NxGIwfcsgaPeb7O5WRO6aawS0/7fS
 mteI58iilf6QU2SqTFzCZ6zz4sa1z0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-0hUCPghAPHiBxFXpnWT-DA-1; Tue, 15 Sep 2020 09:08:41 -0400
X-MC-Unique: 0hUCPghAPHiBxFXpnWT-DA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F526408C;
 Tue, 15 Sep 2020 13:08:40 +0000 (UTC)
Received: from localhost (ovpn-115-146.ams2.redhat.com [10.36.115.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 394755DE4D;
 Tue, 15 Sep 2020 13:08:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] gitmodules: switch to qemu.org qboot mirror
Date: Tue, 15 Sep 2020 14:08:32 +0100
Message-Id: <20200915130834.706758-2-stefanha@redhat.com>
In-Reply-To: <20200915130834.706758-1-stefanha@redhat.com>
References: <20200915130834.706758-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:35:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSBub3cgaG9zdHMgYSBtaXJyb3Igb2YgcWJvb3QuZ2l0LiBRRU1VIG1pcnJvcnMgdGhpcmQt
cGFydHkgY29kZSB0bwplbnN1cmUgdGhhdCB1c2VycyBjYW4gYWx3YXlzIGJ1aWxkIFFFTVUgZXZl
biBpZiB0aGUgZGVwZW5kZW5jeSBnb2VzCm9mZmxpbmUgYW5kIHNvIFFFTVUgbWVldHMgaXRzIHJl
c3BvbnNpYmlsaXRpZXMgdG8gcHJvdmlkZSBmdWxsIHNvdXJjZQpjb2RlIHVuZGVyIHNvZnR3YXJl
IGxpY2Vuc2VzLgoKU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+CkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpUZXN0ZWQt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIC5naXRtb2R1
bGVzIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvLmdpdG1vZHVsZXMgYi8uZ2l0bW9kdWxlcwppbmRleCA5ZmZiOWYzZjRm
Li43Yzg2OTViMWRjIDEwMDY0NAotLS0gYS8uZ2l0bW9kdWxlcworKysgYi8uZ2l0bW9kdWxlcwpA
QCAtNTcsNyArNTcsNyBAQAogCXVybCA9IAlodHRwczovL2dpdC5xZW11Lm9yZy9naXQvb3BlbnNi
aS5naXQKIFtzdWJtb2R1bGUgInJvbXMvcWJvb3QiXQogCXBhdGggPSByb21zL3Fib290Ci0JdXJs
ID0gaHR0cHM6Ly9naXRodWIuY29tL2JvbnppbmkvcWJvb3QKKwl1cmwgPSBodHRwczovL2dpdC5x
ZW11Lm9yZy9naXQvcWJvb3QuZ2l0CiBbc3VibW9kdWxlICJtZXNvbiJdCiAJcGF0aCA9IG1lc29u
CiAJdXJsID0gaHR0cHM6Ly9naXRodWIuY29tL21lc29uYnVpbGQvbWVzb24vCi0tIAoyLjI2LjIK
Cg==


