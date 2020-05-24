Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F01CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D931220787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D931220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctip-0008GP-3K
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jctiA-0007kv-Ic; Sun, 24 May 2020 12:42:54 -0400
Resent-Date: Sun, 24 May 2020 12:42:54 -0400
Resent-Message-Id: <E1jctiA-0007kv-Ic@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcti8-0006Kw-0m; Sun, 24 May 2020 12:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590338534; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jtMyftLgNGUsQp8maQ/hEL76333ciH3WD87g8e0ACMpZ5Tz3/8M2iQfWGn5XJgqEGf02kiVMZ4sPXfWTMSWWs/63LF857KAnMdNm7t6GbwaqT4bBm0mKQYIoSGQCuJNnD/wla5CXt6xPD1qxcehTxxRP+ECGYR63CzNjtJmG6Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590338534;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=S6eMjqo/cbnWgdpBfhyDYignfczJv8Hsb+Vc7q0FGD0=; 
 b=e/sHlICK8tvnypxDQ0sdZV07i8+DkVPc2o26rB2NK/s1RbwPxmpujEHreEV1MlKMsB0gVrb964ykDlqQuB4rIdDo2msMZXuOJo0Dz07A6f3CloO6THCQLQoXVdBoFFFBVtot94ttQsixVV2ByZmdk5VJp4WNaDBoGinETjlGY8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590338532944940.43736705208;
 Sun, 24 May 2020 09:42:12 -0700 (PDT)
Message-ID: <159033853153.25024.18215758507848261213@45ef0f9c86ae>
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
Subject: Re: [PATCH v6 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Sun, 24 May 2020 09:42:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 12:30:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMzMxNzQxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay9zbmFwc2hv
dC5vCiAgQ0MgICAgICBibG9jay9xYXBpLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cy
LWNsdXN0ZXIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2dldF9ob3N0X29mZnNldCc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDczOjE5OiBlcnJvcjogJ2V4cGVjdGVk
X3R5cGUnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJv
cj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICB9IGVsc2UgaWYgKHR5cGUgIT0gZXhwZWN0
ZWRfdHlwZSkgewogICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cWNvdzItY2x1c3Rlci5jOjQ0OToyNTogbm90ZTogJ2V4cGVjdGVkX3R5cGUnIHdhcyBkZWNsYXJl
ZCBoZXJlCiAgICAgUUNvdzJTdWJjbHVzdGVyVHlwZSBleHBlY3RlZF90eXBlLCB0eXBlOwogICAg
ICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1
c3Rlci5jOjQ3NToxOTogZXJyb3I6ICdjaGVja19vZmZzZXQnIG1heSBiZSB1c2VkIHVuaW5pdGlh
bGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAg
ICAgICB9IGVsc2UgaWYgKGNoZWNrX29mZnNldCkgewogICAgICAgICAgICAgICAgICAgXgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0NzoxMDogbm90ZTogJ2NoZWNr
X29mZnNldCcgd2FzIGRlY2xhcmVkIGhlcmUKICAgICBib29sIGNoZWNrX29mZnNldDsKICAgICAg
ICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NzY6Mjk6IGVy
cm9yOiAnZXhwZWN0ZWRfb2Zmc2V0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMg
ZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICAgICAgICAgIGV4cGVj
dGVkX29mZnNldCArPSBzLT5jbHVzdGVyX3NpemU7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0ODoxNDogbm90
ZTogJ2V4cGVjdGVkX29mZnNldCcgd2FzIGRlY2xhcmVkIGhlcmUKICAgICB1aW50NjRfdCBleHBl
Y3RlZF9vZmZzZXQ7CiAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlOiAqKiogW2Jsb2NrL3Fjb3cyLWNsdXN0ZXIub10gRXJyb3IgMQpt
YWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3Qg
cmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGlu
ZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0yYjAwZWQ3NjY1NzA0Njg4OGIxNTljZThmNDNkZGFmZScsICctdScsICcxMDAzJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC04c2EzeGxjbi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTI0LTEyLjM5LjQ0LjQ5
Njk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTJiMDBlZDc2NjU3MDQ2ODg4
YjE1OWNlOGY0M2RkYWZlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLThzYTN4bGNu
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoK
cmVhbCAgICAybTI3Ljg2N3MKdXNlciAgICAwbTQuNTg2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU5MDMzMTc0MS5naXQuYmVy
dG9AaWdhbGlhLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

