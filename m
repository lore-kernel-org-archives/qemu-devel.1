Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4BC47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 00:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BD92084C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 00:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BD92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ5EW-0000fy-9i
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 20:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJ5D4-0007hy-S3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJ5D3-00073x-CL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:24:38 -0400
Resent-Date: Fri, 11 Oct 2019 20:24:38 -0400
Resent-Message-Id: <E1iJ5D3-00073x-CL@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJ5D3-000723-4c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570839867; cv=none; d=zoho.com; s=zohoarc; 
 b=VEEJyiwhifyO98wZLVcDK+rGYFf7JcVI9DmDSrEB0ikrieM1yrwvHYf+i7Mkrmq0xIFcWjbHEFJB7wMRO5YBjCjKaTZAtVKJe1A9GjIoFK/Re2rQ92WQ8nbx1u5767wO/qOMDLDIaLgpep4cUmpmfSLyfn3jq5R3yhyKuTxpQZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570839867;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NYraOzyD4ravXxa6D/uNCe5mfYqO28hvL842eRBvLG0=; 
 b=KMjx3Fi5pY0uFAW+/j7HxSnwKI6/1XHpuE/+8twlK3XMyx4geuRvO+EwmBpHYb62979NF4icQJ+U9qoNv8nwJM0gbZIBx8YSJOKIVT7hBf5qnqvTM35MuzXuH+uQpHQ4Yx/iNDzM6AGm+YESKVz+pPYzEdV5r+jymBL2sdnJsAY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570839865337127.16152826732105;
 Fri, 11 Oct 2019 17:24:25 -0700 (PDT)
In-Reply-To: <20191011175536.GB25464@xps13.dannf>
Subject: Re: [Bug 1805256] Re: [Qemu-devel] qemu_futex_wait() lockups in
 ARM64: 2 possible issues
Message-ID: <157083986430.16951.3957645403261787920@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dann.frazier@canonical.com
Date: Fri, 11 Oct 2019 17:24:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMTE3NTUzNi5HQjI1
NDY0QHhwczEzLmRhbm5mLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLW1p
bmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBh
bmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3Ug
Y2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZl
ZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkluIGZpbGUgaW5jbHVkZWQgZnJv
bSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L29zZGVwLmg6NTEsCiAgICAgICAgICAg
ICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9hc3luYy5jOjI2OgovdG1wL3FlbXUt
dGVzdC9zcmMvdXRpbC9hc3luYy5jOiBJbiBmdW5jdGlvbiAnYWlvX25vdGlmeSc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvY29tcGlsZXIuaDo4NjozNjogZXJyb3I6IHN0YXRpYyBh
c3NlcnRpb24gZmFpbGVkOiAibm90IGV4cGVjdGluZzogc2l6ZW9mKComY3R4LT5ub3RpZnlfbWUp
ID4gQVRPTUlDX1JFR19TSVpFIgogI2RlZmluZSBRRU1VX0JVSUxEX0JVR19NU0coeCwgbXNnKSBf
U3RhdGljX2Fzc2VydCghKHgpLCBtc2cpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvY29tcGls
ZXIuaDo5NDozMDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdRRU1VX0JVSUxEX0JVR19N
U0cnCi0tLQovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9hc3luYy5jOjM0OTo5OiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8gJ2F0b21pY19tYl9yZWFkJwogICAgIGlmIChhdG9taWNfbWJfcmVh
ZCgmY3R4LT5ub3RpZnlfbWUpKSB7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+Cm1ha2U6ICoqKiBb
L3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogdXRpbC9hc3luYy5vXSBFcnJvciAxCm1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5l
IDY2MiwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PWI5MDQ0OWVhNjg0ZTRhMTRhZDZiMzRmNGY1ZGNiMGM5JywgJy11JywgJzEwMDEnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJ
Uj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2Nr
ZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC0weTJlYjU0ZC9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTExLTIwLjEyLjU3LjMwMjU0
Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bics
ICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0t
LWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWI5MDQ0OWVhNjg0ZTRhMTRhZDZi
MzRmNGY1ZGNiMGM5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTB5MmViNTRkL3Ny
YycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFs
ICAgIDExbTI3LjczNXMKdXNlciAgICAwbTcuNTMycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMTExNzU1MzYuR0IyNTQ2NEB4cHMx
My5kYW5uZi90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


