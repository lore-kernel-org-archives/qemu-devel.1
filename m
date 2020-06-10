Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E57CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1AC206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1AC206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8GE-0006CG-DV
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 17:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj8FU-0005jt-Oq
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 17:27:04 -0400
Resent-Date: Wed, 10 Jun 2020 17:27:04 -0400
Resent-Message-Id: <E1jj8FU-0005jt-Oq@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj8FS-00009k-Rc
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 17:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591824409; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AcHbihvg1E17Wf4g9/Q/wYzA0DogG0moTH2fx6JuKHLyjdHwwtNWKnMJLkIVmNbk6U2ptgYCc/739GcO5UC7aJPBxE1ryM9h8pjJuX//pBDKEM4iP5px/pDO/plOrZzGY07Vh7GAykQ/DxYDrQSYpsFTD9Th85C+ShHtVXYpijM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591824409;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=CmsMEqY9Rf6MH8tuixNpCjZ8V3ec4fcrWkwaqh8fPXw=; 
 b=V5h6PHCZwVMFhTERmWuJfItXBKqvWltm0rEBJZ3pp/egh5GbcBzq5AkDmf8AR5bRcCrkxabsIYcjFudRKLdwj6PMkeBE6WWl7RyxFF6qvJnXuNAcq/frs2UXlJhlYipghnGxr+9gb7vN0Fn2Bb8OiR15sO5mH8L64fW/goFvN+I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15918244052881019.0313376399178;
 Wed, 10 Jun 2020 14:26:45 -0700 (PDT)
Message-ID: <159182440384.21115.5098161812296032401@45ef0f9c86ae>
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
Subject: Re: [PATCH 0/8] tpm: Split hw/ vs backends/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Wed, 10 Jun 2020 14:26:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 16:25:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au,
 philmd@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMDIwMDI0Ny4yMTM3
OC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQtc29m
dG1tdS9ody92aXJ0aW8vdmhvc3QtdXNlci5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3Fl
bXUtdGVzdC9zcmMvaHcvdHBtL3RwbV9wcGkuYzoxNDowOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
dHBtL3RwbV9wcGkuYzogSW4gZnVuY3Rpb24gJ3RwbV9wcGlfaW5pdCc6Ci90bXAvcWVtdS10ZXN0
L3NyYy9ody90cG0vdHBtX3BwaS5jOjQ3OjQ5OiBlcnJvcjogJ1RQTV9QUElfQUREUl9TSVpFJyB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgSE9TVF9QQUdFX0FMSUdOKFRQTV9QUElfQUREUl9TSVpFKSk7CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10
ZXN0L3NyYy9pbmNsdWRlL3FlbXUvb3NkZXAuaDoyNzg6Mjc6IG5vdGU6IGluIGRlZmluaXRpb24g
b2YgbWFjcm8gJ1JPVU5EX1VQJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3RwbS90cG1fcHBp
LmM6NDc6MzM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnSE9TVF9QQUdFX0FMSUdOJwog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIT1NUX1BBR0VfQUxJR04oVFBNX1BQSV9B
RERSX1NJWkUpKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgptYWtlWzFdOiAq
KiogW2h3L3RwbS90cG1fcHBpLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVu
ZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L3ZpcnRpby92aXJ0
aW8tY3J5cHRvLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L3ZpcnRpby92aXJ0aW8tYmFs
bG9vbi5vCi0tLQogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvdmlydGlvL3Zob3N0LXZzb2Nr
LXBjaS5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody92aXJ0aW8vdmhvc3QtdnNvY2subwog
IENDICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLXBjaS5vCm1h
a2U6ICoqKiBbYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvdmlydGlv
L3Zob3N0LXVzZXItaW5wdXQtcGNpLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L3ZpcnRp
by92aG9zdC11c2VyLXNjc2ktcGNpLm8KLS0tCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody9p
Mzg2L3BjX3EzNS5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaHcv
dHBtL3RwbV9wcGkuYzoxNDowOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdHBtL3RwbV9wcGkuYzog
SW4gZnVuY3Rpb24gJ3RwbV9wcGlfaW5pdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody90cG0vdHBt
X3BwaS5jOjQ3OjQ5OiBlcnJvcjogJ1RQTV9QUElfQUREUl9TSVpFJyB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
SE9TVF9QQUdFX0FMSUdOKFRQTV9QUElfQUREUl9TSVpFKSk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L3FlbXUvb3NkZXAuaDoyNzg6Mjc6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8gJ1JPVU5E
X1VQJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3RwbS90cG1fcHBpLmM6NDc6MzM6IG5vdGU6
IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnSE9TVF9QQUdFX0FMSUdOJwogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBIT1NUX1BBR0VfQUxJR04oVFBNX1BQSV9BRERSX1NJWkUpKTsKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgptYWtlWzFdOiAqKiogW2h3L3RwbS90cG1f
cHBpLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L2kzODYvbWljcm92bS5vCiAgQ0MgICAgICB4
ODZfNjQtc29mdG1tdS9ody9pMzg2L2Z3X2NmZy5vCm1ha2U6ICoqKiBbeDg2XzY0LXNvZnRtbXUv
YWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIu
L3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NSwgaW4gPG1vZHVsZT4KICAgIHN5cy5l
eGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywg
J2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTEwMDZj
MDFkYzVhNzQ1MGJhZGRjMmYwMmRiYTExYjFkJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1v
cHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9Jywg
Jy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0Jywg
Jy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zh
ci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1j
Y2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLTRzeXI5anNiL3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMTAtMTcuMjMuNTcuMjM2OTk6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTEwMDZjMDFkYzVhNzQ1MGJhZGRjMmYw
MmRiYTExYjFkCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTRzeXI5anNiL3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAybTQ2Ljc1MnMKdXNlciAgICAwbTguMTEwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MTAyMDAyNDcuMjEzNzgtMS1waGlsbWRA
cmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t

