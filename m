Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9138C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99A8206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99A8206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorls-0006nl-0u
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jorZX-00047d-O4; Fri, 26 Jun 2020 12:51:27 -0400
Resent-Date: Fri, 26 Jun 2020 12:51:27 -0400
Resent-Message-Id: <E1jorZX-00047d-O4@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jorZU-0000v0-UC; Fri, 26 Jun 2020 12:51:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593190277; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=czvQjjin9jo9brRWTgLa3xxwGlDJFkXAv6/n0H4fFyCM/TW0gPLVpcFSMpldP/D09Q+IJoWql8/JIW4/xLWzabejVbjZ9JjjTf9b9HR1ZMIV0XF83xKLpAiGWLfsZgwMmFf1htywfc/DioNgbOw0dVmZszSGo5EX3sf4Mo/tYUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593190277;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=t1++Tj2Zs49it3PNxf8HhZikRUTADyYHy0HUeOLqb1g=; 
 b=ax3E6kXdM32VtTaCBHZp9biJ4VlSgzEVm6pJ7LmLSKZs1yx9HBCfMabL3WmJ6/nIuiniXo1KUwyd1TOWUmkvmg/383gmcglcXyFLcA1FPJ4kbWUbTE5PeIQjuALQfps/JkqwqXDy7xazfFd/IKVZGqsh4wxGw6mBMj+vzTYgnEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593190274851382.8816317190791;
 Fri, 26 Jun 2020 09:51:14 -0700 (PDT)
Message-ID: <159319027364.28361.6431570503311912262@d1fd068a5071>
Subject: Re: [PATCH v4 00/14] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Fri, 26 Jun 2020 09:51:14 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 11:53:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNjE2MjgxOC4yNTg0
MC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogICAgICAgICAgICAgICAg
IGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9vc2RlcC5oOjEyNiwKICAgICAg
ICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ody9zZC9zZC5jOjMzOgovdG1wL3Fl
bXUtdGVzdC9zcmMvaHcvc2Qvc2QuYzogSW4gZnVuY3Rpb24gJ3NkX2FkZHJfdG9fd3BudW0nOgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvc2Qvc2QuYzo1NDY6MTk6IGVycm9yOiAnc2QnIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuICdzZW5kJz8KICA1
NDYgfCAgICAgYXNzZXJ0KGFkZHIgPCBzZC0+c2l6ZSk7CiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgXn4KL3Vzci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWluZ3cvaW5jbHVkZS9nbGli
LTIuMC9nbGliL2dtYWNyb3MuaDo5Mjg6ODogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAn
X0dfQk9PTEVBTl9FWFBSJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3NkL3NkLmM6NTQ2OjU6
IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnYXNzZXJ0JwogIDU0NiB8ICAgICBhc3NlcnQo
YWRkciA8IHNkLT5zaXplKTsKICAgICAgfCAgICAgXn5+fn5+Cm1ha2U6ICoqKiBbL3RtcC9xZW11
LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvc2Qvc2Qub10gRXJyb3IgMQptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwg
bGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjksIGluIDxt
b2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD03MDRkNTlkNTk3
YTY0YmZkYmU2YWFmN2UzMmZlNDViMCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScs
ICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScs
ICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXNt
ZmZjZnc1L3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMjYtMTIuNDguMTAuMjQwNTc6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWlu
Z3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxh
YmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NzA0ZDU5ZDU5N2E2NGJmZGJlNmFhZjdlMzJmZTQ1
YjAKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtc21mZmNmdzUvc3JjJwptYWtlOiAq
KiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM20zLjQ0
NHMKdXNlciAgICAwbTguNjI1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MjYxNjI4MTguMjU4NDAtMS1mNGJ1Z0BhbXNhdC5vcmcv
dGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

