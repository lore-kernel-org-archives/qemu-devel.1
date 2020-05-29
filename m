Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB96C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E704F2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E704F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelMv-0003Lx-5h
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jelLt-0002Dy-Sc
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:11:37 -0400
Resent-Date: Fri, 29 May 2020 16:11:37 -0400
Resent-Message-Id: <E1jelLt-0002Dy-Sc@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jelLs-0005sQ-7W
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:11:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590783082; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YPASYVAgBvU4Yjx3Jtc4u5YyXqgRsyTWKERhkDJQZ2dHBg2Nq/BvqjzsdhvAU3PuZiHshOppWaLXBSgutMs/+Wo0rj5HI4zuEcDvQKYIWjsBAr92b3IeLY+oBwgZ5I/Jm3neTCMsEV++5iZVo6K+Gh5zgc3zJeqzX5KXIHmrxZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590783082;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9EtpmOpLVpQckDykMihyxeiFwwKYBFmq5KyCpN/0ows=; 
 b=dmL455USg3jo/U0YwtZS18RTROVhHeJluc+L6SxYFxBtmD/EpaZdbkmZ4ejW8Pw/pcWVOFHToqXZhJImfyW3TLYSczIgcdb3JXOyBNjgyKNKBzkyMGpholOvQNx4qX5uagsL0clzse+5kKjYErWAAkZ0EdLA+7SqlkwujV+Xg3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590783080131991.0538234574494;
 Fri, 29 May 2020 13:11:20 -0700 (PDT)
Message-ID: <159078307892.27167.11336799426819606385@45ef0f9c86ae>
In-Reply-To: <cover.1590753455.git.mprivozn@redhat.com>
Subject: Re: [PATCH 0/3] Couple of HMAT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mprivozn@redhat.com
Date: Fri, 29 May 2020 13:11:20 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 16:11:33
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwNzUzNDU1Lmdp
dC5tcHJpdm96bkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay1xdGVz
dC14ODZfNjQ6IHRlc3RzL3F0ZXN0L3Rlc3QteDg2LWNwdWlkLWNvbXBhdAogIFRFU1QgICAgY2hl
Y2stcXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC9udW1hLXRlc3QKKioKRVJST1I6L3RtcC9xZW11
LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L251bWEtdGVzdC5jOjUyNDpwY19obWF0X2VyYW5nZV9jZmc6
ICdxbXBfcnNwX2lzX2VycihxdGVzdF9xbXAocXMsICJ7ICdleGVjdXRlJzogJ3NldC1udW1hLW5v
ZGUnLCIgIiAnYXJndW1lbnRzJzogeyAndHlwZSc6ICdobWF0LWNhY2hlJywgJ25vZGUtaWQnOiAw
LCAnc2l6ZSc6IDEwMjQwLCIgIiAnbGV2ZWwnOiAxLCAnYXNzb2NpYXRpdml0eSc6IFwiZGlyZWN0
XCIsICdwb2xpY3knOiBcIndyaXRlLWJhY2tcIiwiICIgJ2xpbmUnOiA4IH0gfSIpKScgc2hvdWxk
IGJlIFRSVUUKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3Rz
L3F0ZXN0L251bWEtdGVzdC5jOjUyNDpwY19obWF0X2VyYW5nZV9jZmc6ICdxbXBfcnNwX2lzX2Vy
cihxdGVzdF9xbXAocXMsICJ7ICdleGVjdXRlJzogJ3NldC1udW1hLW5vZGUnLCIgIiAnYXJndW1l
bnRzJzogeyAndHlwZSc6ICdobWF0LWNhY2hlJywgJ25vZGUtaWQnOiAwLCAnc2l6ZSc6IDEwMjQw
LCIgIiAnbGV2ZWwnOiAxLCAnYXNzb2NpYXRpdml0eSc6IFwiZGlyZWN0XCIsICdwb2xpY3knOiBc
IndyaXRlLWJhY2tcIiwiICIgJ2xpbmUnOiA4IH0gfSIpKScgc2hvdWxkIGJlIFRSVUUKL3RtcC9x
ZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTc1OiBraWxsX3FlbXUoKSBkZXRl
Y3RlZCBRRU1VIGRlYXRoIGZyb20gc2lnbmFsIDE1IChUZXJtaW5hdGVkKQptYWtlOiAqKiogW2No
ZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNzYKICBURVNUICAgIGlvdGVzdC1x
Y293MjogMTc3Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkK
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdk
b2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0yYjk1NmIx
MzZlZjQ0NjlmOWIyMzdmYTBiM2NhZDgxOScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0
JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICct
ZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICct
ZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LXZvaDFhb2VoL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjktMTUuNTYuMzguMTY4MjY6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTJiOTU2YjEzNmVmNDQ2OWY5YjIzN2ZhMGIz
Y2FkODE5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXZvaDFhb2VoL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAx
NG0zOS44NDZzCnVzZXIgICAgMG04Ljg2OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTA3NTM0NTUuZ2l0Lm1wcml2b3puQHJl
ZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

