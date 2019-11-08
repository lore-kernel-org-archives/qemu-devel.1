Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53252C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3AC20673
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3AC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT8N4-0001ub-3I
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iT8LP-0000t4-Md
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iT8LN-0002pR-4d
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:46:47 -0500
Resent-Date: Fri, 08 Nov 2019 12:46:46 -0500
Resent-Message-Id: <E1iT8LN-0002pR-4d@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iT8LF-0002Y9-IW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:46:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573235180; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yvd2e4iJv7UDbbEtloTxnAII06dejFqQ6SfkXEdqQd/8nUwyIUXiSTm13jwq99o6QuZVOpNozje+3nrAQ1j33RV+hk59BnhWVvno2m9a+0RjLUveBjHQYPiJ62sqVTu3uZo8of23yaOn7DG7lW1lGeCHfVBvYO1hAO9hw/5pwYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573235180;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=61epiVrGY4hq+m7xEXs3UXpiEMgCuX2YWSo/1Hg69qk=; 
 b=XDirFG/OUA/H+6C6V68XvVjPBbS3UEE/4snZCe7eFozmEJtkP0F3Ah0vmJ9ioewMHBhC/MihZ5C6nbctoN1gAPedN2fm54GQ9CIhLY/jGikl+mSStzWHpBU1ZnR36T7ukHWhz1AmTm0eEdAnH+KoRheILiG0lZ7CRyt7/Ut27o4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573235179219895.973693481257;
 Fri, 8 Nov 2019 09:46:19 -0800 (PST)
In-Reply-To: <20191108104307.125020-1-dgilbert@redhat.com>
Subject: Re: [PATCH] tests/migration: Print some debug on bad status
Message-ID: <157323517815.7743.2882918933706185467@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Fri, 8 Nov 2019 09:46:19 -0800 (PST)
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwODEwNDMwNy4xMjUw
MjAtMS1kZ2lsYmVydEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay11
bml0OiB0ZXN0cy90ZXN0LWJkcnYtZHJhaW4Kd2FpdF9mb3JfbWlncmF0aW9uX2ZhaWw6IHVuZXhw
ZWN0ZWQgc3RhdHVzIHN0YXR1cz13YWl0LXVucGx1ZyBhbGxvd19hY3RpdmU9MQoqKgpFUlJPUjov
dG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvbWlncmF0aW9uLXRlc3QuYzo5MDg6d2FpdF9mb3JfbWln
cmF0aW9uX2ZhaWw6IGFzc2VydGlvbiBmYWlsZWQ6IChyZXN1bHQpCkVSUk9SIC0gQmFpbCBvdXQh
IEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdyYXRpb24tdGVzdC5jOjkwODp3YWl0
X2Zvcl9taWdyYXRpb25fZmFpbDogYXNzZXJ0aW9uIGZhaWxlZDogKHJlc3VsdCkKbWFrZTogKioq
IFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWJkcnYtZ3Jh
cGgtbW9kCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWJsb2Nram9iCi0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
bGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1mYTU3NGNjMDM3N2Y0N2YzOTQ0NzkxOWNi
OTQxOTk2NScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25m
aW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTRjdTc1MXNoL3NyYy9kb2Nr
ZXItc3JjLjIwMTktMTEtMDgtMTIuMzMuMTMuMjQ1NDU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPWZhNTc0Y2MwMzc3ZjQ3ZjM5NDQ3OTE5Y2I5NDE5OTY1Cm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTRjdTc1MXNoL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxM201LjEzNnMKdXNlciAgICAw
bTguMTg2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTExMDgxMDQzMDcuMTI1MDIwLTEtZGdpbGJlcnRAcmVkaGF0LmNvbS90ZXN0aW5n
LmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


