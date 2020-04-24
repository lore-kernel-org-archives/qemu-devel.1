Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA452084D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA452084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvFM-00049V-0V
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRvEk-0003aw-OC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRvEj-0000jx-Dw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:07:10 -0400
Resent-Date: Fri, 24 Apr 2020 06:07:10 -0400
Resent-Message-Id: <E1jRvEj-0000jx-Dw@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRvEi-0000Q4-Rj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587722816; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jYcqyunJKQZ1BfnP1sZiA+KT5vm/o7zacPQdksyW9GRdlL+RZWJ+1qgQMHoGgNJ1hODstbVDZpVIznTYXIcIhnWtvqiDU6dWjt+YIe0EpasZS/bVyq7uwvJ4I6bjOqMyY2PyKFz6bxFJsr+xQfAR9mhYz+mMRXAcsRE2JERZTXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587722816;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=h5R6Mz0JqM6ees9/BUtFNN4m6jQ/z6HmYQ9amWSFQ+4=; 
 b=VELKbGdmp33eT2ZJ+1qXBF/j+dPlyE4GHAK+eASc6a9V1KQyZ+mEjk3yeflP6OI27vJcb48FyzcEKYdbMfUzjpo2eDZQH69TnR88VDFXWGbgMBEShAFR+CXjw9KkIPIYj2BhQ8uu1XcsAaiHCpABoLyQTcl6nNd5S4ek9Byf5jc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158772281457837.099511810757804;
 Fri, 24 Apr 2020 03:06:54 -0700 (PDT)
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
Subject: Re: [PATCH v2 00/15] qapi: Spring cleaning
Message-ID: <158772281333.22435.14973289862380467538@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Fri, 24 Apr 2020 03:06:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 06:07:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNDA4NDMzOC4yNjgw
My0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi0uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4KKy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLkUuLgorPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQorRVJS
T1I6IHRlc3Rfc3RyZWFtX3BhdXNlIChfX21haW5fXy5UZXN0U2luZ2xlRHJpdmUpCistLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCitUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CisgIEZpbGUgIjAzMCIs
IGxpbmUgOTMsIGluIHRlc3Rfc3RyZWFtX3BhdXNlCi0tLQogUmFuIDI3IHRlc3RzCiAKLU9LCitG
QUlMRUQgKGVycm9ycz0xKQpDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJuZWwgbW9kdWxlOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5CnFlbXUtc3lzdGVtLXg4Nl82NDogLWFjY2VsIGt2bTogZmFp
bGVkIHRvIGluaXRpYWxpemUga3ZtOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CnFlbXUtc3lz
dGVtLXg4Nl82NDogZmFsbGluZyBiYWNrIHRvIHRjZwotLS0KTm90IHJ1bjogMjU5CkZhaWx1cmVz
OiAwMzAKRmFpbGVkIDEgb2YgMTE3IGlvdGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVj
ay1ibG9jay5zaF0gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAg
ICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD1hNjVjY2E0Y2ZiMGY0N2Q2YWZiMDE0NjAwOGNmZGEzNicsICctdScsICcxMDAxJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWV5b2x5MV9zL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjQtMDUuNTIuMTMuMzg5
MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YTY1Y2NhNGNmYjBmNDdkNmFm
YjAxNDYwMDhjZmRhMzYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZXlvbHkxX3Mv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpy
ZWFsICAgIDE0bTQxLjMyMXMKdXNlciAgICAwbTkuMjM1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjQwODQzMzguMjY4MDMtMS1h
cm1icnVAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

