Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BAEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B292065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B292065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxDl-0001ZB-Bx
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYxCm-0000ng-48; Wed, 13 May 2020 15:38:12 -0400
Resent-Date: Wed, 13 May 2020 15:38:12 -0400
Resent-Message-Id: <E1jYxCm-0000ng-48@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYxCk-00028q-Ae; Wed, 13 May 2020 15:38:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589398677; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WTpMbDVnH9BM/sgS1MbLJYlH/3QDzj5Z1H54fnV049NewZRfc3CEl+SC3QspJSf0iTYtaxywF0StojCACQyBn5ImVy8PILAcCdnEfM6ToSOLbaWpnJf2Dleur9qs04cEYPEaCR/xS+UcZ4hXVlPPVzGZzPHU3yT0rdxdUhsAux4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589398677;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DEcGKp3Z48UUn6oyGWjzE468Qh+2vOpVA1dOzPtUSPI=; 
 b=YsQZzOV993H33wrb1ig+YKcUL/Auyv0bvAyBlg2y/GRd6OBW+qb/stbZmjo/Dr7MMR7PVT6Qn8Tj0kYLRlhjXFiTwqZRkZvGYCdv8xBO6jj1Gd3Vtwjgatj/1tCl0+35BPJkmFVaO8UoUvjK22DfJCda/w96qoBwJS6m1AgaJ2c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589398675358878.5204514350203;
 Wed, 13 May 2020 12:37:55 -0700 (PDT)
Message-ID: <158939867383.13639.382190902757055518@45ef0f9c86ae>
In-Reply-To: <20200513144941.1469447-1-mreitz@redhat.com>
Subject: Re: [RFC] migration: Add migrate-set-bitmap-node-mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Wed, 13 May 2020 12:37:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 15:34:21
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, quintela@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 pkrempa@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMzE0NDk0MS4xNDY5
NDQ3LTEtbXJlaXR6QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNU
PXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09Cgog
IEdFTiAgICAgaHcvaW50Yy90cmFjZS5oCiAgR0VOICAgICBody9pc2EvdHJhY2UuaAogIEdFTiAg
ICAgaHcvbWVtL3RyYWNlLmgKbWFrZTogKioqIFtNYWtlZmlsZTo2NjY6IHFhcGktZ2VuLXRpbWVz
dGFtcF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD03NzlkMDgxNGY2ZGQ0ZThjOTNmMDdmNWZhZWVhMGQ0NycsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdnBhemEweXQvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wNS0xMy0xNS4zNC40NS4zMTU5MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD03NzlkMDgxNGY2ZGQ0ZThjOTNmMDdmNWZhZWVhMGQ0NwptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC12cGF6YTB5dC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTguNzQ0cwp1c2VyICAgIDBtOC4w
NTRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDUxMzE0NDk0MS4xNDY5NDQ3LTEtbXJlaXR6QHJlZGhhdC5jb20vdGVzdGluZy5hc2Fu
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

