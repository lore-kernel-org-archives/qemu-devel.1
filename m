Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A647C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2B62072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2B62072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8n4T-0007O0-4U
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8n3H-0005s2-GB; Thu, 20 Aug 2020 12:04:31 -0400
Resent-Date: Thu, 20 Aug 2020 12:04:31 -0400
Resent-Message-Id: <E1k8n3H-0005s2-GB@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8n3F-0005z2-0S; Thu, 20 Aug 2020 12:04:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597939460; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bM16+CQjcbpjgWr+obOkExGwol6iUgNypGDJZ9A9SIQEUFiaBt91mNJnzqNO9Dhbx9L7E2blj7EXaULHd3+RPVdJQlOBySRDTqlUyS+2GipVKJ1BfMgQltEwdOSyRo2xNIcPJWKGh+pUsTL3G26BWjcpEtjd7J6DXOzzy8EpPaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597939460;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xO7aoA2Jsa/SWeTS2prvCqrYOsJ7ohtOjyDR7gA+fCs=; 
 b=AV8GYL2C34ez8FviLYFCHDq2j9+E2HpD4vFJJNQNhJobnmi+Ms8Fb7ZUVAOkWLA6i3HT5Lq0G07ONioyJTGi9XYc1SeTKHhUEGvabuu1woiOFjoa4Fnaj1ddeuQBK1fO2a571qvBY+OQubzoELWRNb0GOI7vimXW2AYw9KibA1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597939458179233.28852313596178;
 Thu, 20 Aug 2020 09:04:18 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded controller
Message-ID: <159793945758.7760.16892401987742724390@66eaa9a8a123>
In-Reply-To: <20200820133201.80577-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: graeme@nuviainc.com
Date: Thu, 20 Aug 2020 09:04:18 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 12:02:38
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
Cc: graeme@nuviainc.com, peter.maydell@linaro.org, rad@semihalf.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyMDEzMzIwMS44MDU3
Ny0xLWdyYWVtZUBudXZpYWluYy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82NC1z
b2Z0bW11L3RhcmdldC9pMzg2L21pc2NfaGVscGVyLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS9ody9hcm0vbXBzMi10ei5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vc2JzYS1yZWYuYzog
SW4gZnVuY3Rpb24gJ2NyZWF0ZV9zZWN1cmVfZWMnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYXJt
L3Nic2EtcmVmLmM6NjUxOjU6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biAncWRldl9jcmVhdGUnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQog
ICAgIERldmljZVN0YXRlICpkZXYgPSBxZGV2X2NyZWF0ZShOVUxMLCBUWVBFX1NFQ1VSRV9FQyk7
CiAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYXJtL3Nic2EtcmVmLmM6NjUxOjU6IGVycm9y
OiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdxZGV2X2NyZWF0ZScgWy1XZXJyb3I9bmVz
dGVkLWV4dGVybnNdCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vc2JzYS1yZWYuYzo2NTE6MjQ6
IGVycm9yOiBpbml0aWFsaXphdGlvbiBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0
IGEgY2FzdCBbLVdlcnJvcl0KICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gcWRldl9jcmVhdGUoTlVM
TCwgVFlQRV9TRUNVUkVfRUMpOwogICAgICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdh
cm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbaHcvYXJtL3Nic2Et
cmVmLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L21weF9oZWxwZXIubwogIEND
ICAgICAgeDg2XzY0LXNvZnRtbXUvdGFyZ2V0L2kzODYvc2VnX2hlbHBlci5vCi0tLQogIENDICAg
ICAgeDg2XzY0LXNvZnRtbXUvdGFyZ2V0L2kzODYvc2V2Lm8KICBHRU4gICAgIHRyYWNlL2dlbmVy
YXRlZC1oZWxwZXJzLmMKICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L3RyYWNlL2NvbnRyb2wtdGFy
Z2V0Lm8KbWFrZTogKioqIFthYXJjaDY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9z
b2Z0bW11L21haW4ubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvZ2Ric3R1Yi14bWwubwotLS0K
ICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2Fs
bGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bics
ICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OGM2YjE1OWRmZjA1NDEzMWE1Mzc4
YmVkYjVjMzVmNTgnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVu
Y29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09O
RklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9Jywg
Jy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAn
LXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2Nj
YWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0xdHR2ZndzZy9zcmMv
ZG9ja2VyLXNyYy4yMDIwLTA4LTIwLTEyLjAxLjMyLjgzNjc6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXUvY2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPThjNmIxNTlkZmYwNTQxMzFhNTM3OGJlZGI1YzM1ZjU4Cm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTF0dHZmd3NnL3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTQ2Ljc0NnMKdXNlciAg
ICAwbTkuMjIwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA4MjAxMzMyMDEuODA1NzctMS1ncmFlbWVAbnV2aWFpbmMuY29tL3Rlc3Rp
bmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

