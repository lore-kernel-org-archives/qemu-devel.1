Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC4AC2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 00:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72254206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 00:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72254206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYf2H-0001NY-LF
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 20:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYf1V-0000si-AH; Tue, 12 May 2020 20:13:21 -0400
Resent-Date: Tue, 12 May 2020 20:13:21 -0400
Resent-Message-Id: <E1jYf1V-0000si-AH@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYf1T-0007C5-Tf; Tue, 12 May 2020 20:13:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589328784; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ji/uf9SVSO8x27jrzhHLs+Ey/BaZ+S9Rc0ZxIw7T44cx6pLrIZf3aVNTWOrQ6n3VqVVRSOPUhN0CeBOxgm6bwFQCooNCxZkk8FRzve+tYHHfC2Zb0+P7cN06NWMP0V2cYV7igIvcIlHFAJF2Vn4W3TavbGJzDNYtvGvyQnSAGw8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589328784;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+VJ2pswpySqts9Pf3hY2oCdgRPmrge7YBkEJ/I4rDmI=; 
 b=SVEhLnpoKwKhiaMyricEmlD05c7xYFjm8cmJul27oFpMRrU0TvgeH7oYfufVJ5nvt/3DrwHD1JDI2YqFI6xYAnhlbERnQ9ZjjgQw6HiJprfYYUPquPs075m7eVTMcTzh0iNzYauc7PNpiIwJSXTRDMdUgnV8XR18b2tz/ADiiX8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589328784167896.5536880219055;
 Tue, 12 May 2020 17:13:04 -0700 (PDT)
Message-ID: <158932878251.9905.84985493743167329@45ef0f9c86ae>
In-Reply-To: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v4 00/15] Apply COR-filter to the block-stream permanently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 12 May 2020 17:13:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 19:44:32
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5MzAyMjQ1LTg5MzI2OS0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
ZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaW8vY2hhbm5lbC5vCiAgQ0MgICAgICBp
by9jaGFubmVsLWJ1ZmZlci5vCiAgQ0MgICAgICBpby9jaGFubmVsLWNvbW1hbmQubwovdG1wL3Fl
bXUtdGVzdC9zcmMvYmxvY2svY29weS1vbi1yZWFkLmM6Mjk6MTA6IGZhdGFsIGVycm9yOiAnYmxv
Y2svY29weS1vbi1yZWFkLmgnIGZpbGUgbm90IGZvdW5kCiNpbmNsdWRlICJibG9jay9jb3B5LW9u
LXJlYWQuaCIKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoxIGVycm9yIGdlbmVyYXRl
ZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBibG9jay9jb3B5
LW9uLXJlYWQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc3RyZWFtLmM6MjI6MTA6IGZhdGFsIGVycm9y
OiAnYmxvY2svY29weS1vbi1yZWFkLmgnIGZpbGUgbm90IGZvdW5kCiNpbmNsdWRlICJibG9jay9j
b3B5LW9uLXJlYWQuaCIKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoxIGVycm9yIGdl
bmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBibG9j
ay9zdHJlYW0ub10gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAg
ICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD02ZWE1ODI1NGQ1YmE0MDQzYTFkYzAzYzk1ZTFkZGExYicsICctdScsICcxMDAzJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScs
ICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcXhjOTlyZjUvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0x
Mi0yMC4wOS41OC4xMjg2OTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD02ZWE1
ODI1NGQ1YmE0MDQzYTFkYzAzYzk1ZTFkZGExYgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC1xeGM5OXJmNS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9y
YV0gRXJyb3IgMgoKcmVhbCAgICAzbTQuNDAzcwp1c2VyICAgIDBtOC40MjVzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg5MzAyMjQ1LTg5
MzI2OS0xLWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vdGVz
dGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

