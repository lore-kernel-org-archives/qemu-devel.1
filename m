Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AB7207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AB7207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdRz8-0004U8-Ot
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 01:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdRyN-0003eT-VP; Tue, 26 May 2020 01:17:55 -0400
Resent-Date: Tue, 26 May 2020 01:17:55 -0400
Resent-Message-Id: <E1jdRyN-0003eT-VP@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdRyM-0008Fb-9H; Tue, 26 May 2020 01:17:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590470238; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kEaSl/35sMhVzePDh9oyuDUIJPAqGoVSPNTpXbify4icUEvJANEA2PHX9JEOYlWwFWlQHHQj3WmdjPRpiuNe4hv6YIy8Ac277OwA/Yh8rJe7naziel5tO4ybHiJ5C65S2k6rLXfe2WGmxoay89nc12JhCaZ8+D/Vw/yPDldH4K4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590470238;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GpabIEgLR2K+qcjlxB633coQWHGfnxlp4gGi636ylLI=; 
 b=RnKTndhd51b6nqofAtjeAMjcxZwpiif+Iyd+bhQ2Ok0lehCu2eJnNRjpn/r97pYUiF+veBVOP8v9sn+MtthUErcm2UuyUSUhULZmDTUNRxsNhb/nsNaGaZ07Di8pl4dh7qIScHm36tdjTsDMJAL30TAa2bG3QontVv3Lz+W4Ie0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590470237193236.7317188125843;
 Mon, 25 May 2020 22:17:17 -0700 (PDT)
Message-ID: <159047023574.7716.10329320896993109043@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Mon, 25 May 2020 22:17:17 -0700 (PDT)
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwNDI5OTAxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay9yZXBsaWNh
dGlvbi5vCiAgQ0MgICAgICBibG9jay90aHJvdHRsZS5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9xY293Mi1jbHVzdGVyLmM6IEluIGZ1bmN0aW9uICdxY293Ml9nZXRfaG9zdF9vZmZzZXQnOgov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3MzoxOTogZXJyb3I6ICdl
eHBlY3RlZF90eXBlJyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24g
Wy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICAgICAgfSBlbHNlIGlmICh0eXBlICE9
IGV4cGVjdGVkX3R5cGUpIHsKICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDk6MjU6IG5vdGU6ICdleHBlY3RlZF90eXBlJyB3YXMg
ZGVjbGFyZWQgaGVyZQogICAgIFFDb3cyU3ViY2x1c3RlclR5cGUgZXhwZWN0ZWRfdHlwZSwgdHlw
ZTsKICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fj
b3cyLWNsdXN0ZXIuYzo0NzU6MTk6IGVycm9yOiAnY2hlY2tfb2Zmc2V0JyBtYXkgYmUgdXNlZCB1
bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXpl
ZF0KICAgICAgICAgfSBlbHNlIGlmIChjaGVja19vZmZzZXQpIHsKICAgICAgICAgICAgICAgICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDc6MTA6IG5vdGU6
ICdjaGVja19vZmZzZXQnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgYm9vbCBjaGVja19vZmZzZXQ7
CiAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDc2
OjI5OiBlcnJvcjogJ2V4cGVjdGVkX29mZnNldCcgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBp
biB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgICAg
ICBleHBlY3RlZF9vZmZzZXQgKz0gcy0+Y2x1c3Rlcl9zaXplOwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDg6
MTQ6IG5vdGU6ICdleHBlY3RlZF9vZmZzZXQnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgdWludDY0
X3QgZXhwZWN0ZWRfb2Zmc2V0OwogICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFtibG9jay9xY293Mi1jbHVzdGVyLm9dIEVy
cm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5w
eSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9ODk5ODRlZTNmNjU2NDUyYTk4NjU4YjAyOGUyZjgxYWQnLCAnLXUnLCAnMTAwMycs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtaWhfdXNtYnIvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0yNi0wMS4x
NS4yNS4xNTM5MTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ODk5ODRlZTNm
NjU2NDUyYTk4NjU4YjAyOGUyZjgxYWQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
aWhfdXNtYnIvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDFtMzEuODE5cwp1c2VyICAgIDBtNy45NjJzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTkwNDI5OTAx
LmdpdC5iZXJ0b0BpZ2FsaWEuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

