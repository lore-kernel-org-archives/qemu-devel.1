Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89159C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D729207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D729207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Yxe-0000nh-LQ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8Ywr-0008OC-OT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:00:57 -0400
Resent-Date: Wed, 19 Aug 2020 21:00:57 -0400
Resent-Message-Id: <E1k8Ywr-0008OC-OT@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8Ywn-0007fO-Kd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597885247; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dZ0puS+FsEx8CQdck+0BJX01wf8VTaKYusO+Ld+3gmDyodxkdXpwSkkSUAHfbWryYF780N/gxOT8EABST2w3YwhW36vH/cXObAPqtRyfAsTVbNzHGf8gKCfHmC5oRJs9MsKhbN/CAR9wD5vVRD7WtfywHZGYBU+EaSGtFBSWO+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597885247;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DhBqd4Qt4/52HiilDNM1IH/OYRCvO4U0WcKkMfjoiPw=; 
 b=NXMQoZXtnukQiYR5SNfHNlI04kESUQXdyMnmTkBXyfMUKUblihmfWhLBGDBeGmH/PtrqcVbTCFJoAdOvwdozMFUyZA9hQhsFKcqTMaCPtw5XDJp+8RIsrjW6zVejXzlZBCQ0MggoUeQuD9U8ZCJj14g3gDUiGV9B/lr1WJvnAus=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597885243867653.93335352928;
 Wed, 19 Aug 2020 18:00:43 -0700 (PDT)
Subject: Re: [PATCH v2 00/58] qom: Automated conversion of type checking
 boilerplate
Message-ID: <159788524330.1856.1088020848569643336@66eaa9a8a123>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Wed, 19 Aug 2020 18:00:43 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:56:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyMDAwMTIzNi4xMjg0
NTQ4LTEtZWhhYmtvc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
dXRpbC9sb2NrY250Lm8KICBDQyAgICAgIHV0aWwvaW92Lm8KICBDQyAgICAgIHV0aWwvaW92YS10
cmVlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjM1
Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncGFyZW50X2NsYXNzJyBu
b3QgZGVzY3JpYmVkIGluICdJT01NVU1lbW9yeVJlZ2lvbkNsYXNzJwovdG1wL3FlbXUtdGVzdC9z
cmMvZG9jcy8uLi9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6MzUzOiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICd0cmFuc2xhdGUnIG5vdCBkZXNjcmliZWQgaW4gJ0lPTU1VTWVt
b3J5UmVnaW9uQ2xhc3MnCi90bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4uL2luY2x1ZGUvZXhlYy9t
ZW1vcnkuaDozNTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2dldF9t
aW5fcGFnZV9zaXplJyBub3QgZGVzY3JpYmVkIGluICdJT01NVU1lbW9yeVJlZ2lvbkNsYXNzJwov
dG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6MzUzOiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdub3RpZnlfZmxhZ19jaGFuZ2VkJyBu
b3QgZGVzY3JpYmVkIGluICdJT01NVU1lbW9yeVJlZ2lvbkNsYXNzJwovdG1wL3FlbXUtdGVzdC9z
cmMvZG9jcy8uLi9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6MzUzOiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdyZXBsYXknIG5vdCBkZXNjcmliZWQgaW4gJ0lPTU1VTWVtb3J5
UmVnaW9uQ2xhc3MnCi90bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4uL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaDozNTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2dldF9hdHRy
JyBub3QgZGVzY3JpYmVkIGluICdJT01NVU1lbW9yeVJlZ2lvbkNsYXNzJwovdG1wL3FlbXUtdGVz
dC9zcmMvZG9jcy8uLi9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6MzUzOiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhdHRyc190b19pbmRleCcgbm90IGRlc2NyaWJlZCBpbiAn
SU9NTVVNZW1vcnlSZWdpb25DbGFzcycKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvLi4vaW5jbHVk
ZS9leGVjL21lbW9yeS5oOjM1Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJl
ciAnbnVtX2luZGV4ZXMnIG5vdCBkZXNjcmliZWQgaW4gJ0lPTU1VTWVtb3J5UmVnaW9uQ2xhc3Mn
CgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9p
bmNsdWRlL2V4ZWMvbWVtb3J5Lmg6MjMxOlVuZXhwZWN0ZWQgaW5kZW50YXRpb24uCiAgQ0MgICAg
ICB1dGlsL2hiaXRtYXAubwogIENDICAgICAgdXRpbC9udmRpbW0tdXRpbHMubwotLS0KICBDQyAg
ICAgIGF1dGh6L3RyYWNlLm8KICBDQyAgICAgIGJsb2NrL3RyYWNlLm8KICBDQyAgICAgIGlvL3Ry
YWNlLm8KbWFrZTogKioqIFtNYWtlZmlsZToxMDkxOiBkb2NzL2RldmVsL2luZGV4Lmh0bWxdIEVy
cm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAg
IG5iZC90cmFjZS5vClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICBy
YWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFBy
b2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1s
YWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTYyZDQ2MzU5MWY2NTRmZTM4YmMzNTNhZWM5
YWZmY2IwJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZp
bmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZ3BpbHM5YXQvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wOC0xOS0yMC41Ny4yOS4yNDcwMzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dS9mZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD02MmQ0NjM1OTFmNjU0ZmUzOGJjMzUzYWVjOWFmZmNiMAptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1ncGlsczlhdC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTE0LjIyOXMKdXNlciAgICAwbTgu
MDUxcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDA4MjAwMDEyMzYuMTI4NDU0OC0xLWVoYWJrb3N0QHJlZGhhdC5jb20vdGVzdGluZy5k
b2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

