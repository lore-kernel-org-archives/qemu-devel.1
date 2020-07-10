Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E397720725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E397720725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwsx-0004BI-7s
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtwq7-0000fM-I9; Fri, 10 Jul 2020 13:29:35 -0400
Resent-Date: Fri, 10 Jul 2020 13:29:35 -0400
Resent-Message-Id: <E1jtwq7-0000fM-I9@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtwq4-0006q1-OP; Fri, 10 Jul 2020 13:29:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594402135; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M3n9jX3p+R1L86ySdZMBPY+KsY2KN88uRu3eQERs5FRr/I2g31L3q/DxGJOgoqOmUrku9bwmE86jc+ZsKWPqWfrnBuEfnnzzppvYBTRjkuIK38FJBB1BLx5gG9e9Xf1Dlq7i+/eCaukDrRU9zfJ3TNqnbIQZl1nP4Xyzvvxirfs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594402135;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=YIi36bSX5AkDFtD1cxiJFGxIO1XmyY3gVYqAVdkPg/I=; 
 b=l24SE5g+dQAG/uYNqPoTjiMWHPxx8sYuL4dtGBgljcNq2mMmaofOtG6Xw8a4R0yFG7eTZKF1cuPD+IbgvUouLsd3mIZVsw7mToXNL3wgmxSsN9sLv4dC6WMupLb6z3sIpZikQYIH1wNiGf3dGPVRedwlhqwvMv+70ncrWx07U4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594402132661673.1242360130083;
 Fri, 10 Jul 2020 10:28:52 -0700 (PDT)
Subject: Re: [PATCH v11 00/34] Add subcluster allocation to qcow2
Message-ID: <159440213114.29400.17809502281758198860@07a7f0d89f7d>
In-Reply-To: <cover.1594396418.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Fri, 10 Jul 2020 10:28:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 12:44:35
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTk0Mzk2NDE4Lmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay9ibGt2ZXJp
ZnkubwogIENDICAgICAgYmxvY2svYmxrcmVwbGF5Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2Nr
L3Fjb3cyLWNsdXN0ZXIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2dldF9ob3N0X29mZnNldCc6Ci90
bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDczOjE5OiBlcnJvcjogJ2V4
cGVjdGVkX3R5cGUnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBb
LVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICB9IGVsc2UgaWYgKHR5cGUgIT0g
ZXhwZWN0ZWRfdHlwZSkgewogICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0OToyNTogbm90ZTogJ2V4cGVjdGVkX3R5cGUnIHdhcyBk
ZWNsYXJlZCBoZXJlCiAgICAgUUNvdzJTdWJjbHVzdGVyVHlwZSBleHBlY3RlZF90eXBlLCB0eXBl
OwogICAgICAgICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlOiAqKiogW2Jsb2NrL3Fjb3cyLWNsdXN0ZXIub10gRXJyb3IgMQpt
YWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3Qg
cmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGlu
ZSA2NjksIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0yMWRhN2UwZmRkMDg0ZWVhOGIwMDk3MTk1M2EzZmYyYScsICctdScsICcxMDAxJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLXlvYTZ4eXQ0L3NyYy9kb2NrZXItc3JjLjIwMjAtMDctMTAtMTMuMjYuMjUuMjU2
MjE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTIxZGE3ZTBmZGQwODRlZWE4
YjAwOTcxOTUzYTNmZjJhCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXlvYTZ4eXQ0
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoK
cmVhbCAgICAybTI3LjE4OXMKdXNlciAgICAwbTguNjkxcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU5NDM5NjQxOC5naXQuYmVy
dG9AaWdhbGlhLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

