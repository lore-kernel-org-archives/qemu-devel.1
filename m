Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C8C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C69214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C69214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0zj-0005yp-Ex
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kH0zE-0005YE-3a
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:34:20 -0400
Resent-Date: Sat, 12 Sep 2020 04:34:20 -0400
Resent-Message-Id: <E1kH0zE-0005YE-3a@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kH0zC-0002Ur-1b
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599899618; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bb0LUI0nk12gbQS0PrEW/CG5n2x88kNOHbHJQW91bi+KXSrRC+9Htx3UZETxbaEoFU48qY80JgT/UsLEFjYkbJ09gV8aYq6KZErjQnpH13mJUvP/+b5szeR3nIejqCEBYJX92rAV2X39vYcXT9S4Rf7MFxYIXLFbnpROL5lGR/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599899618;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=pz6Eup3CH3vnw+wa+l8OcEqHbs+inXJM8QRGPRI/xlM=; 
 b=OvB7gXx29UBEk04Y8o1RW7iJben8LWS3PRsYshRctI0OhZoIeCfbtIV2lpIqI6n0hzDnfFSwd13eGYks079SRWcb5WrljuCe+e+kwkKx66nfyjRP0wnA/jDoUnz8MktGT4QgvOjtKnr5QMH0ad22q0NHhuhaK5vyr/KKQviGs8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599899616039711.5914227920471;
 Sat, 12 Sep 2020 01:33:36 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] hw/char: Remove TYPE_SERIAL_IO
Message-ID: <159989961416.31217.4748533572284270088@66eaa9a8a123>
In-Reply-To: <20200912082944.890972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sat, 12 Sep 2020 01:33:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 04:34:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com, mst@redhat.com,
 qemu-devel@nongnu.org, jiaxun.yang@flygoat.com, f4bug@amsat.org,
 aleksandar.qemu.devel@gmail.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxMjA4Mjk0NC44OTA5
NzItMS1mNGJ1Z0BhbXNhdC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRl
c3Qgb24gRnJlZUJTRCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCgoKCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDkxMjA4Mjk0NC44OTA5NzItMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5GcmVlQlNELz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

