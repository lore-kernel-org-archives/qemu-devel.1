Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018FEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C074220829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074220829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GGz-0004XC-0x
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6GCA-0003ho-CR; Thu, 13 Aug 2020 12:35:14 -0400
Resent-Date: Thu, 13 Aug 2020 12:35:14 -0400
Resent-Message-Id: <E1k6GCA-0003ho-CR@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6GC7-0001tj-DA; Thu, 13 Aug 2020 12:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597336482; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gMASWnRFzrZwhak/LzXYapBKC9TOxWDbMWSH8WnNoC94KH80FfhtGsfBtpwA6PjwSh5ufamW/MwzvkHESL/f6hVmXTmN/X8umiRmftKbQOTOtVZAKx+7hij67u9mGTuxkUYmNMo5xjnwpkKvcULShlRgij3/jUzycHUoqCGZArU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597336482;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=n5WBm6wxH0x+r3O4iJHicD0Z83O3uOrTcdriZF8lx3M=; 
 b=AZhG11/8+TmHWIiUOZUzFmVgb9x9gyA0m6MNuAv0wB5E/D9qhPP/7K4FPQ26OscMbDIvngjoajT9H0sFhYjK1rzA9KnTi0z7nyjQfaW0VUZeOgSQcQ4C3KEWBf0Rm+/QLOFNQ/R+qWJQOKiB+pvik4t8NJxWwjmOD226vVT54tI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597336478728430.1531814030461;
 Thu, 13 Aug 2020 09:34:38 -0700 (PDT)
Subject: Re: [RFC 0/9] Support disable/enable CPU features for AArch64
Message-ID: <159733647760.15736.9146033731205988201@66eaa9a8a123>
In-Reply-To: <20200813102657.2588720-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liangpeng10@huawei.com
Date: Thu, 13 Aug 2020 09:34:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 10:17:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, liangpeng10@huawei.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzEwMjY1Ny4yNTg4
NzIwLTEtbGlhbmdwZW5nMTBAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vdHJhbnNsYXRlLWE2NC5vCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvdGFyZ2V0L2FybS9oZWxwZXItYTY0Lm8KL3RtcC9xZW11LXRlc3Qvc3Jj
L3RhcmdldC9hcm0vY3B1LmM6IEluIGZ1bmN0aW9uICdhcm1fY3B1X3NldF9iaXRfcHJvcCc6Ci90
bXAvcWVtdS10ZXN0L3NyYy90YXJnZXQvYXJtL2NwdS5jOjE1ODY6MTA6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAna3ZtX2FybV9jcHVfZmVhdHVyZV9zdXBwb3J0ZWQn
OyBkaWQgeW91IG1lYW4gJ2t2bV9hcm1fcG11X3N1cHBvcnRlZCc/IFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMTU4NiB8ICAgICBpZiAoIWt2bV9hcm1fY3B1X2ZlYXR1
cmVfc3VwcG9ydGVkKCkpIHsKICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fgogICAgICB8ICAgICAgICAgIGt2bV9hcm1fcG11X3N1cHBvcnRlZAovdG1wL3FlbXUt
dGVzdC9zcmMvdGFyZ2V0L2FybS9jcHUuYzoxNTg2OjEwOiBlcnJvcjogbmVzdGVkIGV4dGVybiBk
ZWNsYXJhdGlvbiBvZiAna3ZtX2FybV9jcHVfZmVhdHVyZV9zdXBwb3J0ZWQnIFstV2Vycm9yPW5l
c3RlZC1leHRlcm5zXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHRhcmdldC9hcm0v
Y3B1Lm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIK
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQot
LS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3Mu
Q2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1
bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ODI0OThhYjQ4YjlkNGU4M2E2
ZTNkNTUxODUyZjdjZTcnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21w
PXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFf
Q09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9
JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1w
L2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0wNXB1eWNyby9z
cmMvZG9ja2VyLXNyYy4yMDIwLTA4LTEzLTEyLjMwLjU1LjMwNTYzOi92YXIvdG1wL3FlbXU6eixy
bycsICdxZW11L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJl
dHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20u
cWVtdS5pbnN0YW5jZS51dWlkPTgyNDk4YWI0OGI5ZDRlODNhNmUzZDU1MTg1MmY3Y2U3Cm1ha2Vb
MV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBg
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTA1cHV5Y3JvL3NyYycKbWFrZTogKioqIFtkb2Nr
ZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNtNDIuOTk3cwp1c2Vy
ICAgIDBtOS4yODVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDgxMzEwMjY1Ny4yNTg4NzIwLTEtbGlhbmdwZW5nMTBAaHVhd2VpLmNv
bS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

