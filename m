Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D155C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53D02396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53D02396E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXwQ-00078L-Qp
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLXvg-0006dn-Te; Thu, 24 Sep 2020 16:33:24 -0400
Resent-Date: Thu, 24 Sep 2020 16:33:24 -0400
Resent-Message-Id: <E1kLXvg-0006dn-Te@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLXve-0006Vu-9T; Thu, 24 Sep 2020 16:33:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600979581; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yu0LDb9bN8rGq8CidcWFPYenQBkrNnJI82c4AWLVd5z6AE0+ISTgeK9JOR35lPPZ2VdE6Y+nEnxKRGMMHyOk6Hq/RK9vCEE+OUhItsRXaZOX1gW1kn5db5ZjOvn3uc4W8EgltDJk4Ze9rzfpCZPhemXtniO5XgoZkHwvK0bPcZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600979581;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=FnQ40+8Vxi6Up52qe1Uor/sE5u4bHsGDjCRJW0Tw0SI=; 
 b=fgwojl/8PqrphEtkRjvPnB2b1po9oBSgLE5mdV9ZlvjqO+04iSxSIyCKtMCDy5m+rsie032XJuSBM2zcsNax24c+HhbEu93oZdOdpUgb2oyibfmMDo/cdt6jTSFFRG2WAwp3qMlXSBBr/XGxoowYdR3xwX0Wuplh67sx9b5deMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600979579871910.2223002340844;
 Thu, 24 Sep 2020 13:32:59 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] coroutines: generate wrapper code
Message-ID: <160097957795.12744.8809653264339815766@66eaa9a8a123>
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Thu, 24 Sep 2020 13:32:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:30:26
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNDE4NTQxNC4yODY0
Mi0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDIGxpbmtlciBmb3Ig
dGhlIGhvc3QgbWFjaGluZTogY2MgbGQuYmZkIDIuMjctNDMKSG9zdCBtYWNoaW5lIGNwdSBmYW1p
bHk6IHg4Nl82NApIb3N0IG1hY2hpbmUgY3B1OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjEw
OiBXQVJOSU5HOiBNb2R1bGUgdW5zdGFibGUta2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9y
d2FyZHMgY29tcGF0aWJpbGl0eSBhbmQgbWlnaHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNl
cy4KUHJvZ3JhbSBzaCBmb3VuZDogWUVTClByb2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNy
L2Jpbi9weXRob24zKQpDb25maWd1cmluZyBuaW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgot
LS0KICAgIHJldHVybiBjb2RlY3MuYXNjaWlfZGVjb2RlKGlucHV0LCBzZWxmLmVycm9ycylbMF0K
VW5pY29kZURlY29kZUVycm9yOiAnYXNjaWknIGNvZGVjIGNhbid0IGRlY29kZSBieXRlIDB4ZTIg
aW4gcG9zaXRpb24gMTE0MDY6IG9yZGluYWwgbm90IGluIHJhbmdlKDEyOCkKR2VuZXJhdGluZyAn
bGlicWVtdS1hYXJjaDY0LXNvZnRtbXUuZmEucC9kZWNvZGUtdmZwLXVuY29uZC5jLmluYycuCm1h
a2U6ICoqKiBbYmxvY2svYmxvY2stZ2VuLmMuc3RhbXBdIEVycm9yIDEKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9k
dWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1lYTky
MmEwYTZjZTM0ZGZjOTBmNTliZjFiMDU5YjlkNScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9j
Y2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1yY3Rm
X3hzbS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA5LTI0LTE2LjI5LjUzLjE0NDI5Oi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWlj
ayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFi
ZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1lYTkyMmEwYTZjZTM0ZGZjOTBmNTliZjFiMDU5Yjlk
NQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1yY3RmX3hzbS9zcmMnCm1ha2U6ICoq
KiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgM200LjA0
N3MKdXNlciAgICAwbTIxLjY0OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI0MTg1NDE0LjI4NjQyLTEtdnNlbWVudHNvdkB2aXJ0
dW96em8uY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

