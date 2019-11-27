Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1875420665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1875420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZt72-0000im-9m
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iZt3U-0004pq-Jo
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iZt3R-0001ku-Jm
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:52:11 -0500
Resent-Date: Wed, 27 Nov 2019 03:52:10 -0500
Resent-Message-Id: <E1iZt3R-0001ku-Jm@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iZt3R-0001dX-BD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:52:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574844694; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YKLvt0rirsjJRQOlgpZlUyyRmGtKbsh+OilodJouiFr6GTIg4au1xcAwcIr3510LfAkMSz8ud+9jbu0BwSK8O6s7LUDb71XgSJy1cAGtP/F+BdbDh9nO1fKu2dmNbc6y97WnrcncKChX+hZnShzTF5WqNQhgA2hkmJAkcZcU5ws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574844694;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Qlz5O/4HrJgigT3PpXtPlwWCFCHgh3BqUWx4LKzR7L0=; 
 b=BVS5eyH4OJZ7iaf9/PdCtGG4qA6rjHGw3Peo4ZdfAAv5RlnumIiBRPeza8ReeEYkL8H9OMK8HzdM9GijR9xhCbpeN5hJWJJRg92525b/Uy5dUSQb+AJ1BBmU57c3c5DwecH11bz7ID1OhgdIidu0vkgJdh6UXVpRC03SVfcvVoo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574844691544376.075877932318;
 Wed, 27 Nov 2019 00:51:31 -0800 (PST)
In-Reply-To: <20191127082613.22903-1-tao3.xu@intel.com>
Subject: Re: [PATCH v18 0/8] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <157484468932.4822.1026920903729105588@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Wed, 27 Nov 2019 00:51:31 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, tao3.xu@intel.com, fan.du@intel.com,
 armbru@redhat.com, mdroth@linux.vnet.ibm.com, jingqi.liu@intel.com,
 imammedo@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNzA4MjYxMy4yMjkw
My0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay1xdGVz
dC14ODZfNjQ6IHRlc3RzL251bWEtdGVzdApCcm9rZW4gcGlwZQovdG1wL3FlbXUtdGVzdC9zcmMv
dGVzdHMvbGlicXRlc3QuYzoxNDk6IGtpbGxfcWVtdSgpIGRldGVjdGVkIFFFTVUgZGVhdGggZnJv
bSBzaWduYWwgOCAoRmxvYXRpbmcgcG9pbnQgZXhjZXB0aW9uKSAoY29yZSBkdW1wZWQpCkVSUk9S
IC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDksIGdvdCA4KQptYWtlOiAqKiogW2NoZWNr
LXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNTkKICBURVNUICAgIGlvdGVzdC1xY293
MjogMTYxCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1hYjU0ZTcxMzA3
MTM0OTkyOGQ1MjU1YzI5MTU3NTZhNicsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScs
ICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScs
ICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZn
Z29ubXFxL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMjctMDMuNDAuMDguNjQ4NzovdmFyL3RtcC9x
ZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVp
Y2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxh
YmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YWI1NGU3MTMwNzEzNDk5MjhkNTI1NWMyOTE1NzU2
YTYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNmdnb25tcXEvc3JjJwptYWtlOiAq
KiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDExbTIx
Ljk4NHMKdXNlciAgICAwbTguNjMzcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMjcwODI2MTMuMjI5MDMtMS10YW8zLnh1QGludGVs
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


