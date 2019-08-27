Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD48F205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD48F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Xvf-00019G-Sq
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2Xv1-0000fz-Q9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2Xuz-0004ag-KK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:37:39 -0400
Resent-Date: Tue, 27 Aug 2019 05:37:39 -0400
Resent-Message-Id: <E1i2Xuz-0004ag-KK@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2Xuz-0004aM-F3; Tue, 27 Aug 2019 05:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566898638; cv=none; d=zoho.com; s=zohoarc; 
 b=jNZl0YCiwYERPta658QvSciskEhs0dbusYN10kRm5Uaq7S185k/Qosl8FC4ToPZnQcsBPqVKjfLanyrdumtMX5x7o6Z0Rv/J5Fa5YyGRFSnfwGmhgLOdmqTsW7yqbVdS3sxXepddiHTpcqekLkH/0qZmGs0XBT1xz8mNu0FccuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566898638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=9IT9Y6ak9NV42GUZDBGCW3tybcenlxLRVWhwet2JMAY=; 
 b=mnqmIf/Pm7HS4E7UTL7GN/YveXJhCg3YA0nL6pFilHK1tDc9lIq9QK5/0RVsvavtekKZnZuVBm1nUfT3RITSR3mqk5dss0P1ZJZsTO1M/1JNYrOPLonGszoMw/5ZjFFVNf0T7gR0iObhCpSO4UBOdpfAlUbUkFQdExTYXVqafbw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566898636026938.2529568161978;
 Tue, 27 Aug 2019 02:37:16 -0700 (PDT)
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-ID: <156689863442.15196.11814842800073225674@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 02:37:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, seabios@seabios.org,
 qemu-devel@nongnu.org, kevin@koconnor.net, liran.alon@oracle.com,
 kraxel@redhat.com, sameid@google.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyNzA4MjQyNy42NDI4
MC0xLXNhbWVpZEBnb29nbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDgyNzA4MjQyNy42NDI4MC0xLXNhbWVpZEBnb29n
bGUuY29tClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY2IDAvOF0g
QWRkIFFlbXUgdG8gU2VhQklPUyBMQ0hTIGludGVyZmFjZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0YzM1YzRiIGhkLWdlby10
ZXN0OiBBZGQgdGVzdHMgZm9yIGxjaHMgb3ZlcnJpZGUKOTRmZTUwYSBib290ZGV2aWNlOiBGV19D
RkcgaW50ZXJmYWNlIGZvciBMQ0hTIHZhbHVlcwpmZWIxNDJiIGJvb3RkZXZpY2U6IFJlZmFjdG9y
IGdldF9ib290X2RldmljZXNfbGlzdApkMGQxYjBhIGJvb3RkZXZpY2U6IEdhdGhlciBMQ0hTIGZy
b20gYWxsIHJlbGV2YW50IGRldmljZXMKNDdhYWJhNyBzY3NpOiBQcm9wYWdhdGUgdW5yZWFsaXpl
KCkgY2FsbGJhY2sgdG8gc2NzaS1oZApjMTVhNmVmIGJvb3RkZXZpY2U6IEFkZCBpbnRlcmZhY2Ug
dG8gZ2F0aGVyIExDSFMKNWVlNmE1NyBibG9jazogU3VwcG9ydCBwcm92aWRpbmcgTENIUyBmcm9t
IHVzZXIKNzA1OGQzMiBibG9jazogUmVmYWN0b3IgbWFjcm9zIC0gZml4IHRhYmJpbmcKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgNzA1OGQzMjI5ZDcxIChibG9jazog
UmVmYWN0b3IgbWFjcm9zIC0gZml4IHRhYmJpbmcpCkVSUk9SOiBNYWNyb3Mgd2l0aCBjb21wbGV4
IHZhbHVlcyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMKIzU1OiBGSUxFOiBpbmNs
dWRlL2h3L2Jsb2NrL2Jsb2NrLmg6NjU6CisjZGVmaW5lIERFRklORV9CTE9DS19DSFNfUFJPUEVS
VElFUyhfc3RhdGUsIF9jb25mKSAgICAgICAgICAgICAgICAgICAgICBcCisgICAgREVGSU5FX1BS
T1BfVUlOVDMyKCJjeWxzIiwgX3N0YXRlLCBfY29uZi5jeWxzLCAwKSwgICAgICAgICAgICAgICAg
ICBcCisgICAgREVGSU5FX1BST1BfVUlOVDMyKCJoZWFkcyIsIF9zdGF0ZSwgX2NvbmYuaGVhZHMs
IDApLCAgICAgICAgICAgICAgICBcCiAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJzZWNzIiwgX3N0
YXRlLCBfY29uZi5zZWNzLCAwKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNyBsaW5l
cyBjaGVja2VkCgpQYXRjaCAxLzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvOCBDaGVj
a2luZyBjb21taXQgNWVlNmE1N2E4ZTkzIChibG9jazogU3VwcG9ydCBwcm92aWRpbmcgTENIUyBm
cm9tIHVzZXIpCjMvOCBDaGVja2luZyBjb21taXQgYzE1YTZlZjQyMjY2IChib290ZGV2aWNlOiBB
ZGQgaW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTKQo0LzggQ2hlY2tpbmcgY29tbWl0IDQ3YWFiYTdj
OTYwYyAoc2NzaTogUHJvcGFnYXRlIHVucmVhbGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQpCjUv
OCBDaGVja2luZyBjb21taXQgZDBkMWIwYTUwMGMzIChib290ZGV2aWNlOiBHYXRoZXIgTENIUyBm
cm9tIGFsbCByZWxldmFudCBkZXZpY2VzKQo2LzggQ2hlY2tpbmcgY29tbWl0IGZlYjE0MmIxOTY2
YiAoYm9vdGRldmljZTogUmVmYWN0b3IgZ2V0X2Jvb3RfZGV2aWNlc19saXN0KQo3LzggQ2hlY2tp
bmcgY29tbWl0IDk0ZmU1MGEyYzMwZiAoYm9vdGRldmljZTogRldfQ0ZHIGludGVyZmFjZSBmb3Ig
TENIUyB2YWx1ZXMpCjgvOCBDaGVja2luZyBjb21taXQgNGMzNWM0YjY5Y2FlIChoZC1nZW8tdGVz
dDogQWRkIHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlKQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1
c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNjQxOiBGSUxFOiB0ZXN0cy9oZC1n
ZW8tdGVzdC5jOjk5NjoKKyAgICAgICAgICAgICAgICAgICAgICAgInNraXBwaW5nIGhkLWdlby9v
dmVycmlkZS8qIHRlc3RzIik7Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDYwOSBsaW5l
cyBjaGVja2VkCgpQYXRjaCA4LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA4MjcwODI0Mjcu
NjQyODAtMS1zYW1laWRAZ29vZ2xlLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


