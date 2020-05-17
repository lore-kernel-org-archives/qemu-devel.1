Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4DC20674
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4DC20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNta-00015y-Cb
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 14:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaNsu-0000e5-Oe
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:19:36 -0400
Resent-Date: Sun, 17 May 2020 14:19:36 -0400
Resent-Message-Id: <E1jaNsu-0000e5-Oe@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaNst-0002uV-1L
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589739553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hP1GfvJ1IAfpPjL/9LEV4zWg6/ar/UK7aTtY5TbCb+dunl7z9V+p5IYBBSFLU2MPMLbre4I9SDsVcoJDo8vqIIRWsSAJL6IW6jCcbRRRnDy5crpEpUt6W7FrUyMXSEAbSreICpYzVUopKtE7vBsEx3ZGcA26SSzwtYhW4+UTDgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589739553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LxXrGlH5YEPqnxiL2rHytm/DmaSnE7CxHJsACQmvymw=; 
 b=ipvPtYMKc4F/Pn4vBywNeDQSvP9nFUII4yQWIW6TSHezksrKpMCu10l8/ritK3VuAGp7AkS7xrTCXItpN73/kOEUr3Tmx9gzNpOcQUMvz981BmrgjZ1JtKJS4kqrHDnF10qNTJxwYtML/g5J7WdmLph7hyii0koxDMU9YgdryIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589739552163481.8909823529599;
 Sun, 17 May 2020 11:19:12 -0700 (PDT)
Message-ID: <158973955027.15373.2544287686124912941@45ef0f9c86ae>
In-Reply-To: <20200517164817.5371-1-f4bug@amsat.org>
Subject: Re: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 17 May 2020 11:19:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 14:07:12
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
Cc: peter.maydell@linaro.org, lizhijian@cn.fujitsu.com, mst@redhat.com,
 aik@ozlabs.ru, jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 f4bug@amsat.org, tony.nguyen@bt.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNzE2NDgxNy41Mzcx
LTEtZjRidWdAYW1zYXQub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdl
LWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9kaXNw
bGF5L2JjbTI4MzVfZmIubwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2NvcmUvbG9hZGVyLmM6MzI3OgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody9lbGZf
b3BzLmg6IEluIGZ1bmN0aW9uICdsb2FkX2VsZjY0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1
ZGUvaHcvZWxmX29wcy5oOjU1NjoyMTogZXJyb3I6IGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZiAn
YWRkcmVzc19zcGFjZV93cml0ZScsIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIHdhcm5fdW51c2Vk
X3Jlc3VsdCBbLVdlcnJvcj11bnVzZWQtcmVzdWx0XQogICAgICAgICAgICAgICAgICAgICBhZGRy
ZXNzX3NwYWNlX3dyaXRlKGFzID8gYXMgOiAmYWRkcmVzc19zcGFjZV9tZW1vcnksCiAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyLCBN
RU1UWEFUVFJTX1VOU1BFQ0lGSUVELAotLS0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3Fl
bXUtdGVzdC9zcmMvaHcvY29yZS9sb2FkZXIuYzozMDU6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNs
dWRlL2h3L2VsZl9vcHMuaDogSW4gZnVuY3Rpb24gJ2xvYWRfZWxmMzInOgovdG1wL3FlbXUtdGVz
dC9zcmMvaW5jbHVkZS9ody9lbGZfb3BzLmg6NTU2OjIxOiBlcnJvcjogaWdub3JpbmcgcmV0dXJu
IHZhbHVlIG9mICdhZGRyZXNzX3NwYWNlX3dyaXRlJywgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUg
d2Fybl91bnVzZWRfcmVzdWx0IFstV2Vycm9yPXVudXNlZC1yZXN1bHRdCiAgICAgICAgICAgICAg
ICAgICAgIGFkZHJlc3Nfc3BhY2Vfd3JpdGUoYXMgPyBhcyA6ICZhZGRyZXNzX3NwYWNlX21lbW9y
eSwKICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZHIsIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsCi0tLQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRhdGEsIGZpbGVfc2l6ZSk7CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9z
cmMvaHcvY29yZS9sb2FkZXIuYzogSW4gZnVuY3Rpb24gJ3JvbV9yZXNldCc6Ci90bXAvcWVtdS10
ZXN0L3NyYy9ody9jb3JlL2xvYWRlci5jOjExNDk6MTM6IGVycm9yOiBpZ25vcmluZyByZXR1cm4g
dmFsdWUgb2YgJ2FkZHJlc3Nfc3BhY2Vfd3JpdGVfcm9tJywgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1
dGUgd2Fybl91bnVzZWRfcmVzdWx0IFstV2Vycm9yPXVudXNlZC1yZXN1bHRdCiAgICAgICAgICAg
ICBhZGRyZXNzX3NwYWNlX3dyaXRlX3JvbShyb20tPmFzLCByb20tPmFkZHIsIE1FTVRYQVRUUlNf
VU5TUEVDSUZJRUQsCiAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByb20tPmRhdGEsIHJvbS0+ZGF0YXNpemUpOwogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFs
bCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10
ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L2NvcmUvbG9hZGVyLm9dIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBp
biA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Y2JjNzhj
YzE1YzcxNGZkNDhlZjg5ZDU2MGNmMzllZDInLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LTN1bjl6ZDB2L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMTctMTQuMTUuNTIuMjQ5MDovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1t
aW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9
bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1jYmM3OGNjMTVjNzE0ZmQ0OGVmODlkNTYwY2Yz
OWVkMgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zdW45emQwdi9zcmMnCm1ha2U6
ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTE4
LjIzN3MKdXNlciAgICAwbTkuMTAwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MTcxNjQ4MTcuNTM3MS0xLWY0YnVnQGFtc2F0Lm9y
Zy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

