Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6473FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312782067D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312782067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNnu-0006bD-Ea
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 14:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaNnF-000689-LS
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:13:45 -0400
Resent-Date: Sun, 17 May 2020 14:13:45 -0400
Resent-Message-Id: <E1jaNnF-000689-LS@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaNnD-0001Wd-E3
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:13:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589739203; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KzQTkGNgFHjayXHplQqbu9qEjWNtuoo61c8dauurn4EYP2ivX1/kTMXNda1rvId2xeV3+pFLZd9p1ZvP6eREIR6EL3inpP0coWy2QS8fqOfCM2m4XPrX1RXisyfJ7bN5647yTDkXP59eMwsMkDAuW2YukbVxBZ1vDN5vo86MRdM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589739203;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Snudginz2Ey9RlUP4nK20ZUlk6iL7c3PRdAfLfyfWtc=; 
 b=LLmKhdIRuqkoSkrbppN2RiuSlWlVEZRJJIjLFjRnR6kMOtw9QA58hYjJrMItCs0wvelEBRAnWA/W7U0fK81k1VHmFhO1cLQdcbjWnoWi8pdvk+W6DAoj9ux2go+Ea0XoCBBhbXOb99+560M8WYFT93xzclLL9lIy0Y3SmSfpkcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589739201316474.5516175512381;
 Sun, 17 May 2020 11:13:21 -0700 (PDT)
Message-ID: <158973919945.15373.1265873859282986555@45ef0f9c86ae>
In-Reply-To: <20200517164817.5371-1-f4bug@amsat.org>
Subject: Re: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 17 May 2020 11:13:21 -0700 (PDT)
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
LTEtZjRidWdAYW1zYXQub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBi
dWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0
cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5
IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZf
NjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIGh3L2Rpc3BsYXkvYXRpXzJkLm8KICBDQyAgICAgIGh3L2Rpc3BsYXkvYXRpX2RiZy5vCklu
IGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvY29yZS9sb2FkZXIuYzoz
MDU6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3L2VsZl9vcHMuaDo1NTY6MjE6IGVycm9y
OiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2YgZnVuY3Rpb24gZGVjbGFyZWQgd2l0aCAnd2Fybl91
bnVzZWRfcmVzdWx0JyBhdHRyaWJ1dGUgWy1XZXJyb3IsLVd1bnVzZWQtcmVzdWx0XQogICAgICAg
ICAgICAgICAgICAgIGFkZHJlc3Nfc3BhY2Vfd3JpdGUoYXMgPyBhcyA6ICZhZGRyZXNzX3NwYWNl
X21lbW9yeSwKICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+IH5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUt
dGVzdC9zcmMvaHcvY29yZS9sb2FkZXIuYzozMjc6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L2h3L2VsZl9vcHMuaDo1NTY6MjE6IGVycm9yOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2YgZnVu
Y3Rpb24gZGVjbGFyZWQgd2l0aCAnd2Fybl91bnVzZWRfcmVzdWx0JyBhdHRyaWJ1dGUgWy1XZXJy
b3IsLVd1bnVzZWQtcmVzdWx0XQogICAgICAgICAgICAgICAgICAgIGFkZHJlc3Nfc3BhY2Vfd3Jp
dGUoYXMgPyBhcyA6ICZhZGRyZXNzX3NwYWNlX21lbW9yeSwKICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAv
cWVtdS10ZXN0L3NyYy9ody9jb3JlL2xvYWRlci5jOjExNDk6MTM6IGVycm9yOiBpZ25vcmluZyBy
ZXR1cm4gdmFsdWUgb2YgZnVuY3Rpb24gZGVjbGFyZWQgd2l0aCAnd2Fybl91bnVzZWRfcmVzdWx0
JyBhdHRyaWJ1dGUgWy1XZXJyb3IsLVd1bnVzZWQtcmVzdWx0XQogICAgICAgICAgICBhZGRyZXNz
X3NwYWNlX3dyaXRlX3JvbShyb20tPmFzLCByb20tPmFkZHIsIE1FTVRYQVRUUlNfVU5TUEVDSUZJ
RUQsCiAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+IH5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KMyBlcnJvcnMgZ2VuZXJhdGVkLgptYWtlOiAqKiog
Wy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L2NvcmUvbG9hZGVyLm9dIEVycm9y
IDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIs
IGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9N2JhM2I5NDJhNjFmNDA0N2IwM2Q0MTE2MzNiMDMwMjgnLCAnLXUnLCAnMTAwMScsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD14ODZfNjQtc29mdG1tdScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtM2Rmc19zMHUvc3JjL2RvY2tlci1zcmMuMjAyMC0w
NS0xNy0xNC4wOC4zMS4yODg0MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD03
YmEzYjk0MmE2MWY0MDQ3YjAzZDQxMTYzM2IwMzAyOAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC0zZGZzX3MwdS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZl
ZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA0bTQ5LjAyOHMKdXNlciAgICAwbTkuODM5cwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MTcx
NjQ4MTcuNTM3MS0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

