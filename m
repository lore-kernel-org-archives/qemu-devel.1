Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD76C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 22:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA85720792
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 22:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA85720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkEba-0006Nl-6C
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 18:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkEaR-0005Ik-GE; Sat, 13 Jun 2020 18:25:15 -0400
Resent-Date: Sat, 13 Jun 2020 18:25:15 -0400
Resent-Message-Id: <E1jkEaR-0005Ik-GE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkEaO-0001BL-UM; Sat, 13 Jun 2020 18:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592087079; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jy56bFVpj0Y49vAtcaihhOdr7USoNx9hYQj7ST5EpMHtezbJCH9gGhA2jGnyY8axVVK7zRtSmKMR8fjxrhbdpF07ne8VshRYROuIKJFoD9vI79PcXdqLjj6QbIbGAGYZtY0LZ1WaRp0A9/dZnA4YWakTj82dPgeRgz21ULVkpRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592087079;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=z3JhaTLn2aDaes/Vy6oTWalv6qtxOchgzWJdzJPTHYc=; 
 b=E0EixLWYTyyms2QRs+b9lj3jwqojmd6ikLZxsQCBVclJsX5UqYXgIOL9Y6wNBNxrMwbzg75vD7j2ngHRLSfAMJE03txt5MT6GgYZpEACOQ813WdVuJJvu6HFBDovuBZUaHUX5z4d2SlRV71j90YC8qunH20QI/d+DKIZxB9Wweg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592087076574124.36103233910012;
 Sat, 13 Jun 2020 15:24:36 -0700 (PDT)
Message-ID: <159208707355.19484.2198690175838390820@45ef0f9c86ae>
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
Subject: Re: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: salil.mehta@huawei.com
Date: Sat, 13 Jun 2020 15:24:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 18:25:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, gshan@redhat.com, mst@redhat.com,
 catalin.marinas@arm.com, qemu-devel@nongnu.org, will@kernel.org,
 wangxiongfeng2@huawei.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, drjones@redhat.com,
 mehta.salil.lnk@gmail.com, richard.henderson@linaro.org, linuxarm@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 salil.mehta@huawei.com, maran.wilson@oracle.com, james.morse@arm.com,
 sudeep.holla@arm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMzIxMzYyOS4yMTk4
NC0xLXNhbGlsLm1laHRhQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNr
LXVuaXQ6IHRlc3RzL3Rlc3QtY2hhcgogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVz
dHMvcXRlc3QvdHBtLXRpcy1kZXZpY2Utc3d0cG0tdGVzdAogIFRFU1QgICAgY2hlY2stcXRlc3Qt
YWFyY2g2NDogdGVzdHMvcXRlc3QvbnVtYS10ZXN0CnFlbXUtc3lzdGVtLWFhcmNoNjQ6IHdhcm5p
bmc6IEZvciBHSUN2MiBtYXgtY3B1cyBtdXN0IGJlIGVxdWFsIHRvIHNtcC1jcHVzCnFlbXUtc3lz
dGVtLWFhcmNoNjQ6IHdhcm5pbmc6IE92ZXJyaWRpbmcgc3BlY2lmaWVkIG1heC1jcHVzKDgpIHdp
dGggc21wLWNwdXMoOCkKICBURVNUICAgIGlvdGVzdC1xY293MjogMDAzCnFlbXUtc3lzdGVtLWFh
cmNoNjQ6IHdhcm5pbmc6IEZvciBHSUN2MiBtYXgtY3B1cyBtdXN0IGJlIGVxdWFsIHRvIHNtcC1j
cHVzCnFlbXUtc3lzdGVtLWFhcmNoNjQ6IHdhcm5pbmc6IE92ZXJyaWRpbmcgc3BlY2lmaWVkIG1h
eC1jcHVzKDgpIHdpdGggc21wLWNwdXMoOCkKcWVtdS1zeXN0ZW0tYWFyY2g2NDogd2FybmluZzog
Rm9yIEdJQ3YyIG1heC1jcHVzIG11c3QgYmUgZXF1YWwgdG8gc21wLWNwdXMKcWVtdS1zeXN0ZW0t
YWFyY2g2NDogd2FybmluZzogT3ZlcnJpZGluZyBzcGVjaWZpZWQgbWF4LWNwdXMoOCkgd2l0aCBz
bXAtY3B1cyg4KQpxZW11LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiBGb3IgR0lDdjIgbWF4LWNw
dXMgbXVzdCBiZSBlcXVhbCB0byBzbXAtY3B1cwpxZW11LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5n
OiBPdmVycmlkaW5nIHNwZWNpZmllZCBtYXgtY3B1cyg4KSB3aXRoIHNtcC1jcHVzKDgpCnFlbXUt
c3lzdGVtLWFhcmNoNjQ6IHdhcm5pbmc6IEZvciBHSUN2MiBtYXgtY3B1cyBtdXN0IGJlIGVxdWFs
IHRvIHNtcC1jcHVzCnFlbXUtc3lzdGVtLWFhcmNoNjQ6IHdhcm5pbmc6IE92ZXJyaWRpbmcgc3Bl
Y2lmaWVkIG1heC1jcHVzKDIpIHdpdGggc21wLWNwdXMoMikKICBURVNUICAgIGNoZWNrLXF0ZXN0
LWFhcmNoNjQ6IHRlc3RzL3F0ZXN0L2Jvb3Qtc2VyaWFsLXRlc3QKcWVtdS1zeXN0ZW0tYWFyY2g2
NDogd2FybmluZzogRm9yIEdJQ3YyIG1heC1jcHVzIG11c3QgYmUgZXF1YWwgdG8gc21wLWNwdXMK
cWVtdS1zeXN0ZW0tYWFyY2g2NDogd2FybmluZzogT3ZlcnJpZGluZyBzcGVjaWZpZWQgbWF4LWNw
dXMoMSkgd2l0aCBzbXAtY3B1cygxKQogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVz
dHMvcXRlc3QvbWlncmF0aW9uLXRlc3QKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL2NoZWNr
LXFudW0KICBURVNUICAgIGlvdGVzdC1xY293MjogMDA0Ci0tLQpxZW11LXN5c3RlbS1hYXJjaDY0
OiBmYWxsaW5nIGJhY2sgdG8gdGNnCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA2MAogIFRFU1Qg
ICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdApxZW11
LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiBGb3IgR0lDdjIgbWF4LWNwdXMgbXVzdCBiZSBlcXVh
bCB0byBzbXAtY3B1cwpxZW11LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiBPdmVycmlkaW5nIHNw
ZWNpZmllZCBtYXgtY3B1cygxKSB3aXRoIHNtcC1jcHVzKDEpCiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDA2MQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNjIKICBURVNUICAgIGlvdGVzdC1xY293
MjogMDYzCi0tLQphY3BpLXRlc3Q6IFdhcm5pbmchIERTRFQgYmluYXJ5IGZpbGUgbWlzbWF0Y2gu
IEFjdHVhbCBbYW1sOi90bXAvYW1sLTNQRklNMF0sIEV4cGVjdGVkIFthbWw6dGVzdHMvZGF0YS9h
Y3BpL3ZpcnQvRFNEVF0uClNlZSBzb3VyY2UgZmlsZSB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10
ZXN0LmMgZm9yIGluc3RydWN0aW9ucyBvbiBob3cgdG8gdXBkYXRlIGV4cGVjdGVkIGZpbGVzLgp0
byBzZWUgQVNMIGRpZmYgYmV0d2VlbiBtaXNtYXRjaGVkIGZpbGVzIGluc3RhbGwgSUFTTCwgcmVi
dWlsZCBRRU1VIGZyb20gc2NyYXRjaCBhbmQgcmUtcnVuIHRlc3RzIHdpdGggVj0xIGVudmlyb25t
ZW50IHZhcmlhYmxlIHNldCoqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9i
aW9zLXRhYmxlcy10ZXN0LmM6NDk0OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChh
bGxfdGFibGVzX21hdGNoKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9z
cmMvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOjQ5NDp0ZXN0X2FjcGlfYXNsOiBhc3Nl
cnRpb24gZmFpbGVkOiAoYWxsX3RhYmxlc19tYXRjaCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1h
YXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA3MwogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNzQK
LS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNz
LkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdy
dW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTg1YjU1YjQ1NWQ1NTQ0OTI5
NzQ2OWJmM2E5ODFjYWJkJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29t
cD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJB
X0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVH
PScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hl
JywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3Rt
cC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaThwenhhdmIv
c3JjL2RvY2tlci1zcmMuMjAyMC0wNi0xMy0xOC4wOC4wMy4yOTM2NDovdmFyL3RtcC9xZW11Onos
cm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScg
cmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9ODViNTViNDU1ZDU1NDQ5Mjk3NDY5YmYzYTk4MWNhYmQKbWFr
ZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5
IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaThwenhhdmIvc3JjJwptYWtlOiAqKiogW2Rv
Y2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE2bTMwLjg3MXMK
dXNlciAgICAwbTkuNDEwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA2MTMyMTM2MjkuMjE5ODQtMS1zYWxpbC5tZWh0YUBodWF3ZWku
Y29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

