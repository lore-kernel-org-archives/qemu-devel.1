Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E79AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5862073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5862073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX3O-0003OJ-7z
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdX2r-0002zE-3U; Tue, 26 May 2020 06:42:53 -0400
Resent-Date: Tue, 26 May 2020 06:42:53 -0400
Resent-Message-Id: <E1jdX2r-0002zE-3U@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdX2p-00016o-GF; Tue, 26 May 2020 06:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590489750; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n1TBkTqcbgvu+jRrkP+ArNxCxLqrJCtuE5lNHn6bApD8UyK5IOMY0WQHxnmKjReiERHNZD8rbjWmaHfm7/4U3feoEBzeup71veIZLJFl5tUHTgafC61aQ/rGdIIuljusDEB6TjGoegrpeBEz/dVdtfvVKAud1vSaPG8J5Dx+pf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590489750;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KVFiGr9e0M2JPjAcMbmDISz7mAj6i5YlTv/Ruj3YrSs=; 
 b=AYGKHwez20mdlXLy0j4/dklWHWwKSC/m18uC0gICFbL/+JNPj53LbmmSEeH0fURTGp64ROctZFhSY8jA8Um/dAc/L0+ABdGD9ITmpZGlXCYaHKQJxGnB4CS/YkhWKHev+83oIJI1+aL6D+h6q3VQiDmIAKclTHs2x7/CDP7OY5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590489747604636.1878824495569;
 Tue, 26 May 2020 03:42:27 -0700 (PDT)
Message-ID: <159048974566.9494.18275093842046338190@45ef0f9c86ae>
In-Reply-To: <20200526081740.256236-1-rvkagan@yandex-team.ru>
Subject: Re: [PATCH v5 0/5] block: widen and check consistency of size-related
 BlockConf properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rvkagan@yandex-team.ru
Date: Tue, 26 May 2020 03:42:27 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:17:51
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
Cc: kwolf@redhat.com, fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, kraxel@redhat.com,
 stefanha@redhat.com, kbusch@kernel.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNjA4MTc0MC4yNTYy
MzYtMS1ydmthZ2FuQHlhbmRleC10ZWFtLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9j
b3JlL2hvdHBsdWcubwogIENDICAgICAgaHcvY29yZS92bXN0YXRlLWlmLm8KL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2Jsb2NrL3hlbi1ibG9jay5jOiBJbiBmdW5jdGlvbiAneGVuX2Jsb2NrX3JlYWxp
emUnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2sveGVuLWJsb2NrLmM6MjQyOjU6IGVycm9y
OiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiAnYmxrY29uZl9ibG9ja3NpemVzJwogICAg
IGJsa2NvbmZfYmxvY2tzaXplcyhjb25mKTsKICAgICBeCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAv
dG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody94ZW4veGVuLWJsb2NrLmg6MTI6MCwKICAgICAg
ICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay94ZW4tYmxvY2suYzoy
NToKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvaHcvYmxvY2svYmxvY2suaDo5MDo2OiBub3Rl
OiBkZWNsYXJlZCBoZXJlCiBib29sIGJsa2NvbmZfYmxvY2tzaXplcyhCbG9ja0NvbmYgKmNvbmYs
IEVycm9yICoqZXJycCk7CiAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL3hlbi1i
bG9jay5jOjI2MDozNTogZXJyb3I6IGZvcm1hdCAnJXUnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlw
ZSAndW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50IDQgaGFzIHR5cGUgJ3VpbnQ2NF90JyBbLVdl
cnJvcj1mb3JtYXQ9XQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmYtPmRp
c2NhcmRfZ3JhbnVsYXJpdHkpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
L3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL3hlbi1ibG9jay5jOjI3NDozMTogZXJyb3I6IGZv
cm1hdCAnJXUnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAndW5zaWduZWQgaW50JywgYnV0IGFy
Z3VtZW50IDQgaGFzIHR5cGUgJ3VpbnQ2NF90JyBbLVdlcnJvcj1mb3JtYXQ9XQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29uZi0+bG9naWNhbF9ibG9ja19zaXplKTsKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMKICBDQyAgICAgIGh3L2NvcmUvaXJxLm8KbWFrZTogKioqIFtody9ibG9jay94ZW4t
YmxvY2sub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2Nr
ZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD0yNDFkMDhkNjI0ODg0ZGRlOGVkN2I5Yjk3NzYwMDg5MycsICct
dScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTMxem9tanI2L3NyYy9kb2NrZXItc3JjLjIwMjAt
MDUtMjYtMDYuNDAuMTQuMTg5ODc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycs
ICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlk
PTI0MWQwOGQ2MjQ4ODRkZGU4ZWQ3YjliOTc3NjAwODkzCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1
bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTMxem9tanI2L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tA
Y2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTEyLjE5MHMKdXNlciAgICAwbTguNDQxcwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1
MjYwODE3NDAuMjU2MjM2LTEtcnZrYWdhbkB5YW5kZXgtdGVhbS5ydS90ZXN0aW5nLmRvY2tlci1x
dWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

