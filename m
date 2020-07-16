Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62319C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBCD207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBCD207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw44P-0001hU-Hf
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jw43r-0001H6-AP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:36:31 -0400
Resent-Date: Thu, 16 Jul 2020 09:36:31 -0400
Resent-Message-Id: <E1jw43r-0001H6-AP@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jw43o-00057j-FG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594906579; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kcyDTkUbjJOy6I3dsuGAofeYWMudGYnXnHf1H1uzADxzJShVYHtlapMgWZZQJiWFXMJmGlBdMYWNdKTXtle0tn9mLey8hZUs+b0xfo2KIMO1otWP8wIuoR/H5/uErC1skfJH2rSVBudiJa67SC9Xcbuq0AFZXawMv1g67QJjYj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594906579;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NAGe0JrM10XHBDcwynXMnGPupbq5VxhdT3oklfwleVI=; 
 b=UOgBbCqx/mExn9S5tu6iLhx2xi0+PT7dcxLSBYE3tiSkT3KWRscokxabwy9B8CZqlOgaONktEIGXLhdUaiwXFSZCeuzJSJG44RqeaFxcHY2QMxbanIVYyvnH/fCJ5b8j2fRVJYzMD2/Vcvl7AgLcSgtb48A/OHWJXpZSqeQVseg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594906576320267.4787071477051;
 Thu, 16 Jul 2020 06:36:16 -0700 (PDT)
Subject: Re: [PATCH] virtiofsd: Remove "norace" from cmdline help
Message-ID: <159490657519.7691.15594686679114197001@07a7f0d89f7d>
In-Reply-To: <20200716101442.48057-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: slp@redhat.com
Date: Thu, 16 Jul 2020 06:36:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:36:25
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
Cc: mszeredi@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 slp@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNjEwMTQ0Mi40ODA1
Ny0xLXNscEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6
IDAyMQogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1jaGFyCioqCkVSUk9SOi90bXAv
cWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzoxMjA0OmNoYXJfc2VyaWFsX3Rlc3Q6ICdj
aHInIHNob3VsZCBub3QgYmUgTlVMTApFUlJPUiB0ZXN0LWNoYXIgLSBCYWlsIG91dCEgRVJST1I6
L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtY2hhci5jOjEyMDQ6Y2hhcl9zZXJpYWxfdGVz
dDogJ2Nocicgc2hvdWxkIG5vdCBiZSBOVUxMCm1ha2U6ICoqKiBbY2hlY2stdW5pdF0gRXJyb3Ig
MQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90
ZXN0LXFjb3cyOiAwMjIKICBURVNUICAgIGlvdGVzdC1xY293MjogMDI0Ci0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1jMmEwMzViNDZlZjE0MDQxODllY2Q1YWQwZTU0MjE4
YicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6Jywg
Jy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1lamNjYzJrbS9zcmMvZG9ja2VyLXNy
Yy4yMDIwLTA3LTE2LTA5LjIwLjQyLjcyMTQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2Vu
dG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16
ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWMyYTAzNWI0NmVmMTQwNDE4OWVjZDVhZDBlNTQyMThiCm1ha2VbMV06ICoqKiBbZG9j
a2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLWVqY2NjMmttL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3Qt
cXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNW0zMy41NTlzCnVzZXIgICAgMG05LjMy
M3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNzE2MTAxNDQyLjQ4MDU3LTEtc2xwQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVp
Y2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

