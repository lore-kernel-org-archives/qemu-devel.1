Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACCC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A4320781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A4320781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRN3F-0007vL-Lo
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 17:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRN2g-0007WI-E9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRN2e-0005nL-Qf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:36:25 -0400
Resent-Date: Wed, 22 Apr 2020 17:36:25 -0400
Resent-Message-Id: <E1jRN2e-0005nL-Qf@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRN2e-0005m7-9k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587591371; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dagZLiZtUWNz0UpIgIEklMVkyFwCJBjX3i7bTpW73nC32gM2BThzJ/yKQ9cxcBfpCsSRqY3mJzQJWASQ2INW6+uRHFTU7hBLR+z9pLVHcweTSb2AZr8MwmJEQ6wuSdZm0f/9uPIkBp5e3S16GJ2lqwnqqz49a8rsnBmwBpqOU8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587591371;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ChLHF9BzTp2Ytjcb3+FvUkehD+jqrP/sAmyNEtte/wk=; 
 b=Lqi4NJtuPvBCV1Np7GexldBCl8n4G2UPidF2D9Y77oZhvbG0boOYvzI4gg8CMP3OVFUYX0cJM5hD+9iz9ZSN9kMcOZMtkfU4zlfURbC/eCtJx9q6fko+UAVbEbY0FB+sM/UTTq5MsWGTIzUphqrcqFTFo4KkgV7lGVjaTgZ9Zxs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587591369863511.93635427369304;
 Wed, 22 Apr 2020 14:36:09 -0700 (PDT)
In-Reply-To: <20200422171305.10923-1-jonathan.derrick@intel.com>
Subject: Re: [PATCH for QEMU] hw/vfio: Add VMD Passthrough Quirk
Message-ID: <158759136841.3922.4821101148440128786@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jonathan.derrick@intel.com
Date: Wed, 22 Apr 2020 14:36:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 14:26:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, helgaas@kernel.org,
 andrzej.jakowski@intel.com, jonathan.derrick@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjE3MTMwNS4xMDky
My0xLWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBh
bmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3Ug
Y2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVk
b3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJH
RVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIHFlbXUtaW8tY21kcy5vCiAgQ0MgICAgICByZXBsaWNhdGlvbi5vCklu
IGZpbGUgaW5jbHVkZWQgZnJvbSBody92ZmlvL3RyYWNlLmM6NToKL3RtcC9xZW11LXRlc3QvYnVp
bGQvaHcvdmZpby90cmFjZS5oOjIzNDg6MTIwOiBlcnJvcjogZXhwZWN0ZWQgJyknCiAgICAgICAg
cWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX3BjaV92bWRfcXVpcmtfc2hhZG93X3JlZ3MgIiAi
JXMgbWVtYmFyMV9waHlzPTB4JSJQUkl4NjQiIG1lbWJhcjJfcGh5cz0weCUiUFJJeDY0IiAiXG4i
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KL3RtcC9xZW11LXRlc3QvYnVpbGQvaHcvdmZpby90cmFjZS5oOjIzNDg6MTc6IG5v
dGU6IHRvIG1hdGNoIHRoaXMgJygnCiAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2Zmlv
X3BjaV92bWRfcXVpcmtfc2hhZG93X3JlZ3MgIiAiJXMgbWVtYmFyMV9waHlzPTB4JSJQUkl4NjQi
IG1lbWJhcjJfcGh5cz0weCUiUFJJeDY0IiAiXG4iLAogICAgICAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9idWlsZC9ody92ZmlvL3RyYWNlLmg6MjM0ODoxMjI6IGVycm9yOiBtaXNzaW5nIHRl
cm1pbmF0aW5nICciJyBjaGFyYWN0ZXIgWy1XZXJyb3IsLVdpbnZhbGlkLXBwLXRva2VuXQogICAg
ICAgIHFlbXVfbG9nKCIlZEAlenUuJTA2enU6dmZpb19wY2lfdm1kX3F1aXJrX3NoYWRvd19yZWdz
ICIgIiVzIG1lbWJhcjFfcGh5cz0weCUiUFJJeDY0IiBtZW1iYXIyX3BoeXM9MHglIlBSSXg2NCIg
IlxuIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KICBDQyAgICAgIGJsb2NrL3Jhdy1mb3JtYXQubwoyIGVycm9ycyBnZW5l
cmF0ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvdmZp
by90cmFjZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCiAgQ0MgICAgICBibG9jay92bWRrLm8KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MjMxYWM5NmRlMTY3
NGQzYjg4N2IxZDNiOGZkNDc3OWMnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD14ODZfNjQtc29m
dG1tdScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9E
SVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLXkwMXdkMGhoL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjItMTcuMzIuMzguNTYw
NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4n
LCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9
LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0yMzFhYzk2ZGUxNjc0ZDNiODg3
YjFkM2I4ZmQ0Nzc5YwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTog
TGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15MDF3ZDBoaC9z
cmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVh
bCAgICAzbTMxLjI3OXMKdXNlciAgICAwbTguMjI4cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjIxNzEzMDUuMTA5MjMtMS1qb25h
dGhhbi5kZXJyaWNrQGludGVsLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

