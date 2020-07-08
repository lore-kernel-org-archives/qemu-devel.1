Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC055C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AF6206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AF6206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJa6-0005LL-Q3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtJZO-0004uZ-9I
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:33:42 -0400
Resent-Date: Wed, 08 Jul 2020 19:33:42 -0400
Resent-Message-Id: <E1jtJZO-0004uZ-9I@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtJZM-0001wd-1g
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594251214; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A5LESFH6dG2053ojECbgg4bve/hlCq/nA/pMPxhHAPj/HAI8sMSDkFH6EjjjBnJ94cd//CsCTd5FDwqrq2eItGfQ5zte5aw0xuwunqRArJeuLkEcpD3MFVL0RdopC0fRLrKDpma2ovI7DQdbQebgeRNFTcUvrerl3ihmIfl2Zgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594251214;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wKRLIi7GsifJv2keNpeo1yCLez+1kRvFxXAWovT/ZVg=; 
 b=Zpq0dZtF22JQYCqpYSFHGt4cbQHsUWvVOB4aW5mqHLl9sYC34dtFnbabEfUtr53Jp0WTCeyohJtzLAc44SU5XDi4+D9Nov7yC2/YnLQrYkWJmkTMskxHV1EP87j5QR2IQVuusWHSZpy9Dl2x0twmgneNcpBl7RgFywPaF5H3ShA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594251212977996.3672773534997;
 Wed, 8 Jul 2020 16:33:32 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] Use ACPI PCI hot-plug for q35
Message-ID: <159425121178.14243.14211274465329160712@07a7f0d89f7d>
In-Reply-To: <20200708224615.114077-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jusual@redhat.com
Date: Wed, 8 Jul 2020 16:33:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 19:29:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: imammedo@redhat.com, jusual@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwODIyNDYxNS4xMTQw
NzctMS1qdXN1YWxAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcv
YWNwaS9hY3BpX2ludGVyZmFjZS5vCiAgQ0MgICAgICBody9hY3BpL2Jpb3MtbGlua2VyLWxvYWRl
ci5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2ljaDkuYzogSW4gZnVuY3Rpb24gJ2ljaDlf
cG1faW5pdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL2ljaDkuYzozMTM6OTogZXJyb3I6
IHRvbyBtYW55IGFyZ3VtZW50cyB0byBmdW5jdGlvbiAncWJ1c19zZXRfaG90cGx1Z19oYW5kbGVy
JwogIDMxMyB8ICAgICAgICAgcWJ1c19zZXRfaG90cGx1Z19oYW5kbGVyKEJVUyhwY2lfZ2V0X2J1
cyhscGNfcGNpKSksCiAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3L2lzYS9pc2Eu
aDo4LAotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvaHcvcWRldi1jb3JlLmg6NTM4OjY6
IG5vdGU6IGRlY2xhcmVkIGhlcmUKICA1MzggfCB2b2lkIHFidXNfc2V0X2hvdHBsdWdfaGFuZGxl
cihCdXNTdGF0ZSAqYnVzLCBPYmplY3QgKmhhbmRsZXIpOwogICAgICB8ICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+Cm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2
OTogaHcvYWNwaS9pY2g5Lm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNo
ZWQgam9icy4uLi4KICBDQyAgICAgIGh3L2FjcGkvYW1sLWJ1aWxkLm8KVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9ZjQwMTk4Yjk5MWViNGJmNGExNWNjY2JmODFlY2NiZjUnLCAnLXUnLCAnMTAwMycsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC10dmt0aDZhdC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTA4LTE5LjMwLjAwLjE4
MTcyOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWY0MDE5OGI5OTFlYjRiZjRh
MTVjY2NiZjgxZWNjYmY1Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXR2a3RoNmF0
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpy
ZWFsICAgIDNtMzIuMjAzcwp1c2VyICAgIDBtOC40MjRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcwODIyNDYxNS4xMTQwNzctMS1q
dXN1YWxAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

