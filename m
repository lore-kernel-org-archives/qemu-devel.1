Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F7CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 18:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8208206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 18:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8208206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqKgH-0003vR-6I
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 14:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqKfY-0003Ut-PD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 14:07:44 -0400
Resent-Date: Tue, 30 Jun 2020 14:07:44 -0400
Resent-Message-Id: <E1jqKfY-0003Ut-PD@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqKfW-0003qL-2X
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 14:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593540421; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fYw4TTgzzK0hZnb1LHTs22A/Baq3N52SbnX97astLqT/HtyKB74twrSdtxGmLa35TmfeJY9j7jcV4UecPKr3YpDQJKk0N1m59lqsgka49ihG5wCRzKQghP3AHoCWLW/uz4rdmNzcFMlGHbH2cuCtq5U0OE9UtxziX4A5eCFHImM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593540421;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QvY44ot0L1EoTYMLgZN9ao81sPeOKtXDjP+XAMmua3Q=; 
 b=iygp430qce/gAPCoQ32yYtY4/Hkd7KJSNLbh+m1QYOD8o3RI8YVnk/nL4tvt4q7dumVvoDSyoF0GF8wdfW3JdEmifW+gZ4pnl/amERGB3z2DzLextIQ/rLqMos8r6BHLzLo8uaUjhqjqzzAReiq2wuTdLvS4h53pv3NVb/RbHoQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593540419462289.632616189691;
 Tue, 30 Jun 2020 11:06:59 -0700 (PDT)
Message-ID: <159354041626.15477.8604156689503337818@d1fd068a5071>
Subject: Re: [PATCH v2 00/12] vDPA support in qemu
In-Reply-To: <20200630174937.25560-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lulu@redhat.com
Date: Tue, 30 Jun 2020 11:06:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 14:07:39
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
Cc: rdunlap@infradead.org, mst@redhat.com, mhabets@solarflare.com,
 qemu-devel@nongnu.org, rob.miller@broadcom.com, saugatm@xilinx.com,
 lulu@redhat.com, armbru@redhat.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, jasowang@redhat.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 maxime.coquelin@redhat.com, aadam@redhat.com, cohuck@redhat.com,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYzMDE3NDkzNy4yNTU2
MC0xLWx1bHVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgovdG1wL3FlbXUtdGVzdC9z
cmMvaHcvbmV0L3ZpcnRpby1uZXQuYzoxNzM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHZob3N0
X2Rldl9zZXRfY29uZmlnJwovdXNyL2xpYi9nY2MveDg2XzY0LXc2NC1taW5ndzMyLzkuMi4xLy4u
Ly4uLy4uLy4uL3g4Nl82NC13NjQtbWluZ3czMi9iaW4vbGQ6IGh3L25ldC92aXJ0aW8tbmV0Lm86
IGluIGZ1bmN0aW9uIGB2aXJ0aW9fbmV0X2dldF9jb25maWcnOgovdG1wL3FlbXUtdGVzdC9zcmMv
aHcvbmV0L3ZpcnRpby1uZXQuYzoxNDk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHZob3N0X2Rl
dl9nZXRfY29uZmlnJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMK
bWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDg6IHFlbXUtc3lzdGVtLXg4Nl82NHcuZXhlXSBFcnJv
ciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NTI3OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIK
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBMSU5LICAgIGFhcmNo
NjQtc29mdG1tdS9xZW11LXN5c3RlbS1hYXJjaDY0dy5leGUKL3Vzci9saWIvZ2NjL3g4Nl82NC13
NjQtbWluZ3czMi85LjIuMS8uLi8uLi8uLi8uLi94ODZfNjQtdzY0LW1pbmd3MzIvYmluL2xkOiBo
dy9uZXQvdmlydGlvLW5ldC5vOiBpbiBmdW5jdGlvbiBgdmlydGlvX25ldF9zZXRfY29uZmlnJzoK
L3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC92aXJ0aW8tbmV0LmM6MTczOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGB2aG9zdF9kZXZfc2V0X2NvbmZpZycKL3Vzci9saWIvZ2NjL3g4Nl82NC13NjQt
bWluZ3czMi85LjIuMS8uLi8uLi8uLi8uLi94ODZfNjQtdzY0LW1pbmd3MzIvYmluL2xkOiBody9u
ZXQvdmlydGlvLW5ldC5vOiBpbiBmdW5jdGlvbiBgdmlydGlvX25ldF9nZXRfY29uZmlnJzoKL3Rt
cC9xZW11LXRlc3Qvc3JjL2h3L25ldC92aXJ0aW8tbmV0LmM6MTQ5OiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGB2aG9zdF9kZXZfZ2V0X2NvbmZpZycKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5l
ZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA4OiBxZW11LXN5c3RlbS1h
YXJjaDY0dy5leGVdIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29m
dG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZp
bGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY5LCBpbiA8bW9kdWxlPgogICAg
c3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2Rl
LCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAn
LW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
OWY1ZGVmMWFjMWE4NDBkZWIyMTllODgyNzAyMGYyNGQnLCAnLXUnLCAnMTAwMScsICctLXNlY3Vy
aXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElT
VD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9
MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElS
PS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tl
ci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLWx3eXVtZ2NzL3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMzAtMTQuMDEuMDQuMzIxMDI6
L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywg
J3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0t
ZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWY1ZGVmMWFjMWE4NDBkZWIyMTll
ODgyNzAyMGYyNGQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExl
YXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbHd5dW1nY3Mvc3Jj
JwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwg
ICAgNW01Mi43MjNzCnVzZXIgICAgMG04LjgyNHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjMwMTc0OTM3LjI1NTYwLTEtbHVsdUBy
ZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

