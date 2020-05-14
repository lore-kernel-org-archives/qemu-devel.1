Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DC22065C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC22065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ2B7-0005Z9-3k
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 20:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZ2Aa-000513-2E
 for qemu-devel@nongnu.org; Wed, 13 May 2020 20:56:16 -0400
Resent-Date: Wed, 13 May 2020 20:56:16 -0400
Resent-Message-Id: <E1jZ2Aa-000513-2E@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZ2AY-0007pQ-Ba
 for qemu-devel@nongnu.org; Wed, 13 May 2020 20:56:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589417766; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MLmigprgNDJWpVsHF19/gaydA9fEoSVbqTYVk94Z1L7vfv7VO4gSTJd9Bz3Xzu04h+kuBpin7OeYcglrGel32c4hdZN3DVMw2Ca71tJ0PFPBcJN1umFUxoSTBvqympm7WFdeIOeV/uONue0/fdOnSNOTg0ZSDhcx3BjRqXYGCXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589417766;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zuKEIUlRXNoYmKpmY4SctCmiXPe1MNqHOd11u1lKtmU=; 
 b=E3dsw2PReQH4VS2DFurfPhVivSSSsDYldTSspOHXAS6CPJr0izSNNmjgq1LUlZv6bsU4pPSpFfk0llChxJrYqh2HouBpivjZA3142oESdSZP1beiMrGSw+idh+73NdmOEbjSnVeb+fxapSx9y5uurx3MxpljRNtYJxpEy1mIdfQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589417764012140.86155280347668;
 Wed, 13 May 2020 17:56:04 -0700 (PDT)
Message-ID: <158941776295.13639.11397906895741625948@45ef0f9c86ae>
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/8] plugins/next (cleanup, cpu_index and lockstep)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 13 May 2020 17:56:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 20:56:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMzE3MzIwMC4xMTgz
MC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNr
LXF0ZXN0LWFhcmNoNjQ6IHRlc3RzL3F0ZXN0L3FvbS10ZXN0CkJyb2tlbiBwaXBlCi90bXAvcWVt
dS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0
ZWQgUUVNVSBkZWF0aCBmcm9tIHNpZ25hbCAxMSAoU2VnbWVudGF0aW9uIGZhdWx0KSAoY29yZSBk
dW1wZWQpCkVSUk9SIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDY1LCBnb3QgMCkKbWFr
ZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE5MQogIFRFU1Qg
ICAgaW90ZXN0LXFjb3cyOiAxOTIKLS0tCnFlbXUtc3lzdGVtLXg4Nl82NDogL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2kzODYveDg2LmM6MTc1OiB4ODZfY3B1X2luZGV4X3RvX3Byb3BzOiBBc3NlcnRp
b24gYGNwdV9pbmRleCA8IHBvc3NpYmxlX2NwdXMtPmxlbicgZmFpbGVkLgpCcm9rZW4gcGlwZQov
dG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNzU6IGtpbGxfcWVtdSgp
IGRldGVjdGVkIFFFTVUgZGVhdGggZnJvbSBzaWduYWwgNiAoQWJvcnRlZCkgKGNvcmUgZHVtcGVk
KQpFUlJPUiAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCA4LCBnb3QgNikKbWFrZTogKioq
IFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKICBURVNUICAgIGlvdGVzdC1xY293MjogMjIw
CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDIyNgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAyMjkK
LS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNz
LkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdy
dW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTA4Njc5ODI5ZDlkNTQwNmVh
YzM1YTE5NjkyNzQyMzViJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29t
cD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJB
X0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVH
PScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hl
JywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90
bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTgyb2R2Z3hq
L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMTMtMjAuNDIuNTEuMjI0MDI6L3Zhci90bXAvcWVtdTp6
LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10n
IHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1j
b20ucWVtdS5pbnN0YW5jZS51dWlkPTA4Njc5ODI5ZDlkNTQwNmVhYzM1YTE5NjkyNzQyMzViCm1h
a2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9y
eSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTgyb2R2Z3hqL3NyYycKbWFrZTogKioqIFtk
b2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxM20xMS4zMDBz
CnVzZXIgICAgMG04LjI5NnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTEzMTczMjAwLjExODMwLTEtYWxleC5iZW5uZWVAbGluYXJv
Lm9yZy90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

