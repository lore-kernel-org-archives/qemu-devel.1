Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A34C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3BB207D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3BB207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaaQu-0006OF-Gr
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 03:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaaQI-0005xR-1i
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:42:54 -0400
Resent-Date: Mon, 18 May 2020 03:42:54 -0400
Resent-Message-Id: <E1jaaQI-0005xR-1i@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaaQG-0001jL-Fu
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589787743; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=i4YOYilReH/pthc6TRtbUoM4x9Mubwiel1KUAtts1jJAwmREga/qgF3lYHHImBZvu5gL83CQ+3B3l8l1H3daGtj3tg8NKj3k/+iJDdkbbwDCwvppCve2y+R+ZV5OCNRhO/y1UHpz52IITkzvstVCY6/VoP4MbegqJ4v2TZohjaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589787743;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=saCUigoxLiSG54+XrqAnGjNMTghV1Fr5qGoCU/MIo2Y=; 
 b=VKd1pW3m58Ys3oOwDKZ+1JQ8IJqNl8TO/iX5qUVE/cRCjTLAR/+tBZKR6E4SVI/xYIb6xbJPvV3B6aescVOl3dQR5xdCTxR417rPaavV8yJBLrTWyNz66AiQWy6L6QvR05Uusu6UAypdU/nbeCJtm5m1yxGs3KbmMVVFUdwGJao=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589787741400742.4492915106428;
 Mon, 18 May 2020 00:42:21 -0700 (PDT)
Message-ID: <158978773823.15373.3713738538739513974@45ef0f9c86ae>
In-Reply-To: <1589782398-24406-1-git-send-email-kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v22 00/18] Add migration support for VFIO devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Mon, 18 May 2020 00:42:21 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 02:54:09
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 eskultet@redhat.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5NzgyMzk4LTI0NDA2LTEt
Z2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQK
bWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10
ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
Li4vbWlncmF0aW9uL21pZ3JhdGlvbi5vOiBJbiBmdW5jdGlvbiBgcG9wdWxhdGVfdmZpb19pbmZv
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9taWdyYXRpb24uYzo5NzY6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYHZmaW9fbWlnX2FjdGl2ZScKL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3Jh
dGlvbi9taWdyYXRpb24uYzo5Nzk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHZmaW9fbWlnX2J5
dGVzX3RyYW5zZmVycmVkJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0
dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDg6IHFlbXUtc3lzdGVtLXg4Nl82NHcuZXhlXSBF
cnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NTI3OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9y
IDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL3N2ZV9oZWxwZXIubwogIENDICAgICAgYWFyY2g2NC1z
b2Z0bW11L3RhcmdldC9hcm0vcGF1dGhfaGVscGVyLm8KLS0tCi4uL21pZ3JhdGlvbi9taWdyYXRp
b24ubzogSW4gZnVuY3Rpb24gYHBvcHVsYXRlX3ZmaW9faW5mbyc6Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9taWdyYXRpb24vbWlncmF0aW9uLmM6OTc2OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB2Zmlv
X21pZ19hY3RpdmUnCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vbWlncmF0aW9uLmM6OTc5
OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB2ZmlvX21pZ19ieXRlc190cmFuc2ZlcnJlZCcKY29s
bGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFr
ZWZpbGU6MjA4OiBxZW11LXN5c3RlbS1hYXJjaDY0dy5leGVdIEVycm9yIDEKbWFrZTogKioqIFtN
YWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxp
bmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENh
bGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vy
cm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywg
J2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MmMxMTlkZGYyNjI3NGFmZjlkZGM3OTRiZTg4NjdmMTEn
LCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAn
LS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9
JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1df
RU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9w
YXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYn
LCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJ3eXVkaHNhL3NyYy9kb2NrZXItc3JjLjIw
MjAtMDUtMTgtMDMuMzYuNTUuNDM0NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEn
LCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBl
eGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0yYzExOWRkZjI2Mjc0YWZmOWRkYzc5NGJlODg2N2YxMQptYWtlWzFdOiAqKiogW2RvY2tlci1y
dW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC0yd3l1ZGhzYS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3
QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA1bTIzLjYzMnMKdXNlciAgICAwbTcuMzEycwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU4OTc4
MjM5OC0yNDQwNi0xLWdpdC1zZW5kLWVtYWlsLWt3YW5raGVkZUBudmlkaWEuY29tL3Rlc3Rpbmcu
ZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

