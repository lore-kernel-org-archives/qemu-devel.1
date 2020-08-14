Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFACC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFED82087D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFED82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6YTD-0005QW-Vs
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 08:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6YSb-0004qQ-Cc; Fri, 14 Aug 2020 08:05:25 -0400
Resent-Date: Fri, 14 Aug 2020 08:05:25 -0400
Resent-Message-Id: <E1k6YSb-0004qQ-Cc@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6YSY-00083p-Kw; Fri, 14 Aug 2020 08:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597406704; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BxaCJN1oIHdKEgPCoIUCQ8nvwXcjrA+bQ6Ooh0zaqZyUrKfwTgAb8k2HQSuzkx9IdnHtbS01+u1xd3p3/puWbur/7vH0OHDFIx3ElWI3SxYMYZV6hii2lXm5HTm5xC8CSGDAyKRSwMcBZbebhm2CupAaY1+AVpLh3ErM+pk++FQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597406704;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qXP+FgDOmZhp0z4DqwY6333UaRJk9gjMszEdYNygkW4=; 
 b=DdGFtFKyeby0BYdyK9ddxgyRDFYqHvtkQ6aHTTD5zI9uOD0SZ/HjtYhRUbb8id35sih6TPhKBGGazzwP+FN1xqSe/8ukv2lAQgxxnR3Tvwq8ei6ffI8I+yFE5rk9KzwxyxJ5yYDnla11uSXH47Du2aA/f6z4fzk0TmbuUOT6OW8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597406702195944.7193516815704;
 Fri, 14 Aug 2020 05:05:02 -0700 (PDT)
Subject: Re: [PATCH] hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
Message-ID: <159740670142.3532.12885589957746966294@66eaa9a8a123>
In-Reply-To: <20200814110057.307-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Fri, 14 Aug 2020 05:05:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 08:01:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Andrew.Baumann@microsoft.com, f4bug@amsat.org, b.galvani@gmail.com,
 nieklinnenbank@gmail.com, qemu-arm@nongnu.org, michael@walle.cc,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNDExMDA1Ny4zMDct
MS1mNGJ1Z0BhbXNhdC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXIt
cXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5F
VFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11
L3RhcmdldC9pMzg2L3NtbV9oZWxwZXIubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvdGFyZ2V0
L2kzODYvc3ZtX2hlbHBlci5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vYWxsd2lubmVyLWEx
MC5jOiBJbiBmdW5jdGlvbiAnYXdfYTEwX3JlYWxpemUnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
YXJtL2FsbHdpbm5lci1hMTAuYzoxNzA6MzA6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDIgb2Yg
J29iamVjdF9wcm9wZXJ0eV9zZXRfbGluaycgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBl
IFstV2Vycm9yXQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QoZ2V0X3N5c3Rl
bV9tZW1vcnkoKSksICZlcnJvcl9mYXRhbCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2V4ZWMv
bWVtb3J5Lmg6Mjg6MCwKLS0tCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FvbS9vYmplY3Qu
aDoxMjQzOjY6IG5vdGU6IGV4cGVjdGVkICdzdHJ1Y3QgT2JqZWN0IConIGJ1dCBhcmd1bWVudCBp
cyBvZiB0eXBlICdjb25zdCBjaGFyIConCiB2b2lkIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhP
YmplY3QgKm9iaiwgT2JqZWN0ICp2YWx1ZSwKICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
YXJtL2FsbHdpbm5lci1hMTAuYzoxNzA6MzA6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDMgb2Yg
J29iamVjdF9wcm9wZXJ0eV9zZXRfbGluaycgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBl
IFstV2Vycm9yXQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QoZ2V0X3N5c3Rl
bV9tZW1vcnkoKSksICZlcnJvcl9mYXRhbCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2V4ZWMv
bWVtb3J5Lmg6Mjg6MCwKLS0tCiB2b2lkIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPYmplY3Qg
Km9iaiwgT2JqZWN0ICp2YWx1ZSwKICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW2h3L2FybS9hbGx3aW5uZXItYTEwLm9dIEVycm9y
IDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAg
IHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L21hY2hpbmUubwogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvdGFyZ2V0L2kzODYvYXJjaF9tZW1vcnlfbWFwcGluZy5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9hcm0vYWxsd2lubmVyLWgzLmM6IEluIGZ1bmN0aW9uICdhbGx3aW5uZXJfaDNfcmVhbGl6
ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vYWxsd2lubmVyLWgzLmM6MzUzOjMwOiBlcnJv
cjogcGFzc2luZyBhcmd1bWVudCAyIG9mICdvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsnIGZyb20g
aW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcl0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgT0JKRUNUKGdldF9zeXN0ZW1fbWVtb3J5KCkpLCAmZXJyb3JfZmF0YWwpOwogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3Fl
bXUtdGVzdC9zcmMvaW5jbHVkZS9leGVjL21lbW9yeS5oOjI4OjAsCi0tLQovdG1wL3FlbXUtdGVz
dC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6MTI0Mzo2OiBub3RlOiBleHBlY3RlZCAnc3RydWN0
IE9iamVjdCAqJyBidXQgYXJndW1lbnQgaXMgb2YgdHlwZSAnY29uc3QgY2hhciAqJwogdm9pZCBv
YmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT2JqZWN0ICpvYmosIE9iamVjdCAqdmFsdWUsCiAgICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FybS9hbGx3aW5uZXItaDMuYzozNTM6MzA6IGVycm9y
OiBwYXNzaW5nIGFyZ3VtZW50IDMgb2YgJ29iamVjdF9wcm9wZXJ0eV9zZXRfbGluaycgZnJvbSBp
bmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9yXQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBPQkpFQ1QoZ2V0X3N5c3RlbV9tZW1vcnkoKSksICZlcnJvcl9mYXRhbCk7CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVt
dS10ZXN0L3NyYy9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6Mjg6MCwKLS0tCiB2b2lkIG9iamVjdF9w
cm9wZXJ0eV9zZXRfbGluayhPYmplY3QgKm9iaiwgT2JqZWN0ICp2YWx1ZSwKICAgICAgXgpjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW2h3L2Fy
bS9hbGx3aW5uZXItaDMub10gRXJyb3IgMQogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvdGFyZ2V0
L2kzODYvYXJjaF9kdW1wLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L21v
bml0b3IubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvdGFyZ2V0L2kzODYva3ZtLm8KLS0tCiAg
Q0MgICAgICB4ODZfNjQtc29mdG1tdS9zb2Z0bW11L21haW4ubwogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvZ2Ric3R1Yi14bWwubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvdHJhY2UvZ2VuZXJh
dGVkLWhlbHBlcnMubwptYWtlOiAqKiogW2FhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBMSU5LICAgIHg4Nl82NC1z
b2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFz
dCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJv
Y2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXIn
LCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1kYjY2ZGQ4MmY0MDI0
Mzg5OGNhNWZjNTg3NDM0MGZmMicsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3Nl
Y2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdF
WFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdE
RUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2Nj
YWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zh
ci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV8yXzBx
d2hoL3NyYy9kb2NrZXItc3JjLjIwMjAtMDgtMTQtMDguMDEuMjQuMTA5Mjk6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNr
J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJl
bD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWRiNjZkZDgyZjQwMjQzODk4Y2E1ZmM1ODc0MzQwZmYy
Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV8yXzBxd2hoL3NyYycKbWFrZTogKioq
IFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTM3Ljk2
OHMKdXNlciAgICAwbTguNjA1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTQxMTAwNTcuMzA3LTEtZjRidWdAYW1zYXQub3JnL3Rl
c3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

