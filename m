Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D9C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA42206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA42206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpKo-00046n-Vd
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kPpIj-0002rR-2d; Tue, 06 Oct 2020 11:54:53 -0400
Resent-Date: Tue, 06 Oct 2020 11:54:53 -0400
Resent-Message-Id: <E1kPpIj-0002rR-2d@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kPpIb-0001Ov-VO; Tue, 06 Oct 2020 11:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601999671; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NIUJBxZsPeXEAEgaQgLlITKeXDGplwhH84y4D2aABRxiClyTTK/9UqtskK63bqjNXy5KQhm5lygoOVKPe1YHMJx+BufJc66DPOa7sr+7yAcnlQ/yuti+z0234IqEoRCEPwSqbtD0ViuSJqA3LfyNv6TGxx9YZvbjVKIAB+DA4ao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601999671;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ah5UUq5rjYoSQ1GD0qpstKPERkV+QvONis7mEpw0u0A=; 
 b=iZ8Xwc1XrtN3bgrz12Gz8EHTgXVIYvyvBuwDOE4pUhST4rNqVw99/phdt3Zhd4b6lnERRPuj9D1BND+qrXFhCntwMlKiCbL+MwYk1nGtOB+ILxwOcstq5kMep+2YU42kfF4lx0p7/YZpvOVAlqZFPDxq5wUpK1Z5K81BbrlpZGo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601999670251275.93598644502697;
 Tue, 6 Oct 2020 08:54:30 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] qom: Fix missing interface in qemu-storage-daemon
Message-ID: <160199966888.31697.2663610300038118998@66eaa9a8a123>
In-Reply-To: <20201006153636.2383248-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 6 Oct 2020 08:54:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 11:54:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Reply-To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, lersek@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNjE1MzYzNi4yMzgz
MjQ4LTEtcGhpbG1kQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAwNjE1MzYzNi4yMzgz
MjQ4LTEtcGhpbG1kQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYzIDAvMV0gcW9tOiBGaXgg
bWlzc2luZyBpbnRlcmZhY2UgaW4gcWVtdS1zdG9yYWdlLWRhZW1vbgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDEwMDYxNTM2MzYuMjM4
MzI0OC0xLXBoaWxtZEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDYxNTM2MzYuMjM4MzI0
OC0xLXBoaWxtZEByZWRoYXQuY29tCmZhdGFsOiBmYWlsZWQgdG8gd3JpdGUgcmVmLXBhY2sgZmls
ZQpmYXRhbDogVGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1bmV4cGVjdGVkbHkKVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBhdGNoZXctdGVzdGVyMi9zcmMvcGF0Y2hl
dy1jbGkiLCBsaW5lIDUzMSwgaW4gdGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCBy
WyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZiwgVHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRlc3RlcjIv
c3JjL3BhdGNoZXctY2xpIiwgbGluZSA2MiwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN1YnByb2Nl
c3MuY2hlY2tfY2FsbChjbG9uZV9jbWQsIHN0ZGVycj1sb2dmLCBzdGRvdXQ9bG9nZikKICBGaWxl
ICIvb3B0L3JoL3JoLXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNz
LnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J2dpdCcsICdjbG9uZScsICctcScsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcGF0Y2hldy1naXQt
Y2FjaGUvaHR0cHNnaXRodWJjb21wYXRjaGV3cHJvamVjdHFlbXUtM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdHR5
cWlmanYvc3JjJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEyOC4KCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMTAwNjE1
MzYzNi4yMzgzMjQ4LTEtcGhpbG1kQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

