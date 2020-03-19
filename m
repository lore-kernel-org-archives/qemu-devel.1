Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB460C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B9B2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B9B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0uH-0003a3-PF
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jF0tY-00036g-DG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jF0tX-0004WF-0v
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:31:56 -0400
Resent-Date: Thu, 19 Mar 2020 15:31:56 -0400
Resent-Message-Id: <E1jF0tX-0004WF-0v@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jF0tT-0004NE-Im; Thu, 19 Mar 2020 15:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584646290; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=REO0rwJ0l6rqhjBl8t1Y7Y08GKbLYt7HTFhzdhtUoOTc/3mgpZWMdsV3W3PPfx6NSciwflpVYXf5WuBe/OMqMmHMxHru9zNE2rtOdiH1oVzhcOWsfA5JSV0J7Ph3xA8evV1V3IYRNjNmH7Ak/BwaIKM5k3JjHapcAHG1AHVpag4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584646290;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gkdVgCTW8xpD9UgBAq/Rn85DzppkDnmzJZtQenD2Erk=; 
 b=CNxZ2JJPQ9IA5bkUelafZwpmamXlOrfMyKF+uClo8JfXglkLCbo9Q5lVE/CYNHtgJXMy+aKrlCZdSjf2KxVz0pM9y8A3hfuq+8Ideb1kmB73+Hclfhw+FIYbfTTK+yWDlwnU7zULmbPc1ANZle3ZpgrDKdpj0v7cVUJaJarcFo0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158464628793485.15113025577443;
 Thu, 19 Mar 2020 12:31:27 -0700 (PDT)
In-Reply-To: <20200319161925.1818377-2-dnbrdsky@gmail.com>
Subject: Re: [PATCH] lockable: replaced locks with lock guard macros where
 appropriate
Message-ID: <158464628614.8795.7072935999807888220@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dnbrdsky@gmail.com
Date: Thu, 19 Mar 2020 12:31:27 -0700 (PDT)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 stefanha@gmail.com, pl@kamp.de, armbru@redhat.com, qemu-devel@nongnu.org,
 dnbrdsky@gmail.com, alex.williamson@redhat.com, kraxel@redhat.com,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, mreitz@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxOTE2MTkyNS4xODE4
Mzc3LTItZG5icmRza3lAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
ICBDQyAgICAgIHRyYWNlLXJvb3QubwogIENDICAgICAgYWNjZWwva3ZtL3RyYWNlLm8KICBDQyAg
ICAgIGFjY2VsL3RjZy90cmFjZS5vCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL3RocmVhZC1wb29s
LmM6MjEzOjU6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ3FlbXVfbG9ja2FibGVfYXV0b19fQ09V
TlRFUl9fJyBbLVdlcnJvciwtV3VudXNlZC12YXJpYWJsZV0KICAgIFFFTVVfTE9DS19HVUFSRCgm
cG9vbC0+bG9jayk7CiAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvbG9ja2Fi
bGUuaDoxNzM6Mjk6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ1FFTVVfTE9DS19HVUFSRCcK
LS0tCnFlbXVfbG9ja2FibGVfYXV0b19fQ09VTlRFUl9fCl4KMSBlcnJvciBnZW5lcmF0ZWQuCm1h
a2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogdXRpbC90aHJlYWQtcG9v
bC5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAg
Q0MgICAgICBiYWNrZW5kcy90cmFjZS5vCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL3JjdS5jOjE1
Mjo1OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJf
XycKICAgIFFFTVVfTE9DS19HVUFSRCgmcmN1X3JlZ2lzdHJ5X2xvY2spOwogICAgXgovdG1wL3Fl
bXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xvY2thYmxlLmg6MTczOjI5OiBub3RlOiBleHBhbmRl
ZCBmcm9tIG1hY3JvICdRRU1VX0xPQ0tfR1VBUkQnCi0tLQpxZW11X2xvY2thYmxlX2F1dG9fX0NP
VU5URVJfXwpeCjEgZXJyb3IgZ2VuZXJhdGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3Ny
Yy9ydWxlcy5tYWs6Njk6IHV0aWwvcmN1Lm9dIEVycm9yIDEKL3RtcC9xZW11LXRlc3Qvc3JjL3V0
aWwvdmZpby1oZWxwZXJzLmM6NjcxOjU6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ3FlbXVfbG9j
a2FibGVfYXV0b19fQ09VTlRFUl9fJyBbLVdlcnJvciwtV3VudXNlZC12YXJpYWJsZV0KICAgIFFF
TVVfTE9DS19HVUFSRCgmcy0+bG9jayk7CiAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L3FlbXUvbG9ja2FibGUuaDoxNzM6Mjk6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ1FFTVVf
TE9DS19HVUFSRCcKLS0tCnFlbXVfbG9ja2FibGVfYXV0b19fQ09VTlRFUl9fCl4KMSBlcnJvciBn
ZW5lcmF0ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogdXRp
bC92ZmlvLWhlbHBlcnMub10gRXJyb3IgMQovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9sb2cuYzo5
ODo1OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJf
XycgWy1XZXJyb3IsLVd1bnVzZWQtdmFyaWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJnFlbXVf
bG9nZmlsZV9tdXRleCk7CiAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvbG9j
a2FibGUuaDoxNzM6Mjk6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ1FFTVVfTE9DS19HVUFS
RCcKLS0tCnFlbXVfbG9ja2FibGVfYXV0b19fQ09VTlRFUl9fCl4KMSBlcnJvciBnZW5lcmF0ZWQu
Cm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogdXRpbC9sb2cub10g
RXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0
cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdCht
YWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD00NWI2NjdiN2Fh
OGE0MjYxODE4YmViYjc4OTcxYmMxMScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1z
b2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScs
ICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hF
X0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUt
ZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtcF9jaHp3bTQvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0xOS0xNS4yOC4zMi4x
MDE4ODovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9y
dW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0
ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD00NWI2NjdiN2FhOGE0MjYx
ODE4YmViYjc4OTcxYmMxMQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsx
XTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1wX2Noendt
NC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoK
cmVhbCAgICAybTU0LjQ2OHMKdXNlciAgICAwbTcuNjM5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTkxNjE5MjUuMTgxODM3Ny0y
LWRuYnJkc2t5QGdtYWlsLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

