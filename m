Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED80C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7002724655
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7002724655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Dqz-0003Eu-Mc
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j4Dq1-0001vI-V6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j4Dq0-00044J-55
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:07:41 -0500
Resent-Date: Tue, 18 Feb 2020 20:07:41 -0500
Resent-Message-Id: <E1j4Dq0-00044J-55@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j4Dpz-00043G-SI; Tue, 18 Feb 2020 20:07:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582074431; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W+1bq3xbOCiodZSJoezSEpHNLiINjt5varIqtolJc0Z7YTqwv2WcDlzenadulppFlTM60aZIryOfK7qZT8KdQk/X+LciUqlZWpvIN7S1tpKPYO4qxhyKMWXltr4N4kauD0urzgGSuZJIjI/BNGhgL40r4bbTB4OKatvizXyfA9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582074431;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/mzZeFTkXxEu0l+Dh28fk9rH+JeoQN+/lQcsXb+l+w8=; 
 b=DRvFjGRzOYbP9nCqzDUfEUpSc5EILs52lMXl8VFkXvAtnYj1GAONQ9hvnY+nhDJXqFNg+5A1D5mVp9vn468lziCSScHfxl0//u28NF4fTQGHJTnyZ5sL1FkCX/T9a6xGoU50V9UxKY72QbN3X4IHw7GwwH+Z3QBdx1PaL5DlFUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582074428463898.274301461669;
 Tue, 18 Feb 2020 17:07:08 -0800 (PST)
In-Reply-To: <20200218224811.30050-1-andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <158207442698.20350.5846437537237258589@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrzej.jakowski@linux.intel.com
Date: Tue, 18 Feb 2020 17:07:08 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, keith.busch@intel.com, andrzej.jakowski@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxODIyNDgxMS4zMDA1
MC0xLWFuZHJ6ZWouamFrb3dza2lAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0
Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXIt
dGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CiAgQ0MgICAgICBody9kaXNwbGF5L3NpaTkwMjIubwogIENDICAgICAgaHcvZGlzcGxheS9zc2Qw
MzAzLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUuYzogSW4gZnVuY3Rpb24gJ252
bWVfcG1yX3JlYWQnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svbnZtZS5jOjEzNDI6MTU6
IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnbXN5bmMnOyBkaWQgeW91
IG1lYW4gJ2ZzeW5jJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAg
ICAgICAgIHJldCA9IG1zeW5jKG4tPnBtcmJ1Ziwgbi0+Zl9wbXJfc2l6ZSwgTVNfU1lOQyk7CiAg
ICAgICAgICAgICAgIF5+fn5+CiAgICAgICAgICAgICAgIGZzeW5jCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9ibG9jay9udm1lLmM6MTM0MjoxNTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRp
b24gb2YgJ21zeW5jJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2Jsb2NrL252bWUuYzoxMzQyOjQ3OiBlcnJvcjogJ01TX1NZTkMnIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAgICAgICByZXQgPSBtc3luYyhuLT5wbXJidWYs
IG4tPmZfcG1yX3NpemUsIE1TX1NZTkMpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUu
YzoxMzQyOjQ3OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBv
bmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgovdG1wL3FlbXUtdGVzdC9z
cmMvaHcvYmxvY2svbnZtZS5jOiBJbiBmdW5jdGlvbiAnbnZtZV9yZWFsaXplJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUuYzoxNDEzOjIxOiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gJ21tYXAnOyBkaWQgeW91IG1lYW4gJ21heCc/IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICBuLT5wbXJidWYgPSBtbWFwKE5V
TEwsIG4tPmZfcG1yX3NpemUsCiAgICAgICAgICAgICAgICAgICAgIF5+fn4KICAgICAgICAgICAg
ICAgICAgICAgbWF4Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6MTQxMzoyMTog
ZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ21tYXAnIFstV2Vycm9yPW5lc3Rl
ZC1leHRlcm5zXQovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svbnZtZS5jOjE0MTQ6Mjc6IGVy
cm9yOiAnUFJPVF9SRUFEJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7
IGRpZCB5b3UgbWVhbiAnT0ZfUkVBRCc/CiAgICAgICAgICAgICAgICAgICAgICAgICAgKFBST1Rf
UkVBRCB8IFBST1RfV1JJVEUpLCBNQVBfU0hBUkVELCBmZCwgMCk7CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICBPRl9SRUFECi90
bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6MTQxNDozOTogZXJyb3I6ICdQUk9UX1dS
SVRFJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVh
biAnT0ZfV1JJVEUnPwogICAgICAgICAgICAgICAgICAgICAgICAgIChQUk9UX1JFQUQgfCBQUk9U
X1dSSVRFKSwgTUFQX1NIQVJFRCwgZmQsIDApOwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE9GX1dSSVRFCi90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6MTQxNDo1Mjog
ZXJyb3I6ICdNQVBfU0hBUkVEJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlv
bik7IGRpZCB5b3UgbWVhbiAnUkFNX1NIQVJFRCc/CiAgICAgICAgICAgICAgICAgICAgICAgICAg
KFBST1RfUkVBRCB8IFBST1RfV1JJVEUpLCBNQVBfU0hBUkVELCBmZCwgMCk7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSQU1fU0hBUkVE
Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6MTQxNjoyNjogZXJyb3I6ICdNQVBf
RkFJTEVEJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3Ug
bWVhbiAnV0FJVF9GQUlMRUQnPwogICAgICAgICBpZiAobi0+cG1yYnVmID09IE1BUF9GQUlMRUQp
IHsKICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgV0FJVF9GQUlMRUQKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUuYzog
SW4gZnVuY3Rpb24gJ252bWVfZXhpdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1l
LmM6MTU4MzoxMzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdtdW5t
YXAnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICAgICAg
bXVubWFwKG4tPnBtcmJ1Ziwgbi0+Zl9wbXJfc2l6ZSk7CiAgICAgICAgICAgICBefn5+fn4KL3Rt
cC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUuYzoxNTgzOjEzOiBlcnJvcjogbmVzdGVkIGV4
dGVybiBkZWNsYXJhdGlvbiBvZiAnbXVubWFwJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdG1wL3Fl
bXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9ibG9jay9udm1lLm9dIEVycm9yIDEKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2Vu
dCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0
LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4n
LCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDU4
ODMzYjhkOTZlNGM2N2E2NDZhMDk5ZjQxMTgzNTEnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5
LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0n
LCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQn
LCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC0wa3N0YmllMy9zcmMvZG9ja2VyLXNyYy4yMDIwLTAyLTE4LTIwLjA0LjI4LjIyNTk6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rl
c3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmls
dGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDU4ODMzYjhkOTZlNGM2N2E2NDZhMDk5
ZjQxMTgzNTEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMGtzdGJpZTMvc3JjJwpt
YWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAg
Mm0zOS40MDNzCnVzZXIgICAgMG04LjE3MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjE4MjI0ODExLjMwMDUwLTEtYW5kcnplai5q
YWtvd3NraUBsaW51eC5pbnRlbC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

