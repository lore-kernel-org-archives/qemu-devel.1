Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBCC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796A523B6F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796A523B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k71HQ-0007bN-NK
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 14:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k71GF-0006gP-DS
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:50:35 -0400
Resent-Date: Sat, 15 Aug 2020 14:50:35 -0400
Resent-Message-Id: <E1k71GF-0006gP-DS@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k71GD-0003tl-0k
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597517420; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ThrLAtiHOjoBibMWzkCxr1axuEf+WDJIYJ9OB98hXYfc9yubVzpQ3Zkw8yPDBhH0VL5mdojYnElMuTUBumafop2mWVn460WlEa5mNLw/SpKRjqL6aN5uiiG91L4RkE7FAcmTKj2OcSf/ga9Yn7sGZWHPXu1kqHLEy6nKpwhwiOo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597517420;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Dn4CpozE6SdcomKGhfNqEcD0OGJyqBPKMSN+395sbz0=; 
 b=NTs6qxFKQRskp/Fwp31HW3Zbx1jcQ2NKcy3IHBLcD7GcG/G0sXklglsIq+S9cxmDyhymRIhuMnC9Kl/XRmUwqsm0HN+cwAKcBzML8jvtg2LXN1rI1P9RvLmYX93ZFc/5qMtZ3fklCJhGNkramp0aSbVsHtnvPAytbABV+fDQXIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597517416636254.42168899283774;
 Sat, 15 Aug 2020 11:50:16 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] *** A Method for evaluating dirty page rate ***
Message-ID: <159751741545.18357.15834234439955988646@66eaa9a8a123>
In-Reply-To: <1597458180-16945-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengchuan@huawei.com
Date: Sat, 15 Aug 2020 11:50:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 13:12:31
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk3NDU4MTgwLTE2OTQ1LTEt
Z2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQg
dGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUg
RG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2Ut
Y2VudG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3
IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVT
VCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWNoYXIKVW5leHBlY3RlZCBlcnJvciBpbiBvYmpl
Y3RfcHJvcGVydHlfdHJ5X2FkZCgpIGF0IC90bXAvcWVtdS10ZXN0L3NyYy9xb20vb2JqZWN0LmM6
MTE4MToKYXR0ZW1wdCB0byBhZGQgZHVwbGljYXRlIHByb3BlcnR5ICdzZXJpYWwtaWQnIHRvIG9i
amVjdCAodHlwZSAnY29udGFpbmVyJykKRVJST1IgdGVzdC1jaGFyIC0gdG9vIGZldyB0ZXN0cyBy
dW4gKGV4cGVjdGVkIDM4LCBnb3QgOSkKbWFrZTogKioqIFtjaGVjay11bml0XSBFcnJvciAxCm1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay1x
dGVzdC14ODZfNjQ6IHRlc3RzL3F0ZXN0L2hkLWdlby10ZXN0CnFlbXUtc3lzdGVtLWFhcmNoNjQ6
IC1hY2NlbCBrdm06IGludmFsaWQgYWNjZWxlcmF0b3Iga3ZtCi0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD1kMzBlNGYxMWRhMTg0ZjMyYTZhMThlOThkNDA4ZDFkMycsICct
dScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTI3Z2V5aDUzL3NyYy9kb2NrZXItc3JjLjIwMjAt
MDgtMTUtMTQuMzguMDYuODk0MzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3Jywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
ZDMwZTRmMTFkYTE4NGYzMmE2YTE4ZTk4ZDQwOGQxZDMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtMjdnZXloNTMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0Bj
ZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEybTkuNjM3cwp1c2VyICAgIDBtOS4yNjRzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTk3NDU4
MTgwLTE2OTQ1LTEtZ2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29tL3Rlc3Rpbmcu
ZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

