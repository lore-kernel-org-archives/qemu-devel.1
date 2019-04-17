Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09AEC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8437220835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8437220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGdLY-0002Xr-RA
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 01:43:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGdJG-0001D4-4D
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGdJC-0000Wm-BH
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:36 -0400
Resent-Date: Wed, 17 Apr 2019 01:40:35 -0400
Resent-Message-Id: <E1hGdJC-0000Wm-BH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hGdJ7-0000DF-OP
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555479604; cv=none; d=zoho.com; s=zohoarc; 
	b=YsbVdDTiUYpEBumWQeYwJ9IL3f1w+hjWsPKle4Ay3cQ5XYbGrFlhvRP9WbVoQbF9pxQeuXdqN/eTTeYqSzcW6/+FxN5cWiGAV5/5TVtoGHZcGwCCwL88e1Vj2dc0tToPvlfe2AoWF2XCFUHBeXQVJRADMzt29uuVUNzeNMye2X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555479604;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=ulkTT/Z2MsucMinsL4XjYd3StpaMUaWxGN816Aw28tA=; 
	b=PZ/TJDvaHcg7Lp0iV/FOm0Zst60jK5NUfcOKOYijuuZJs0abJsOot/+P9BDrZdcYOTfrjj0tjL3u2lQPOqEcQwz427Sz0zfFMqM2epiN+cXd1fZbrQFVhuRdtf1G+kUf5VDs+iHyJ4IpAt0HlQEAwbioxk9hw2JeQpkicAxvms8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555479603950635.6070016046662;
	Tue, 16 Apr 2019 22:40:03 -0700 (PDT)
Message-ID: <155547960277.17102.1916370280246281593@76452e4e88f2>
In-Reply-To: <20190417053225.27505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 16 Apr 2019 22:40:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/1] util/path: Do not cache all filenames
 at startup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-devel@nongnu.org,
	evgreen@chromium.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417054003.f42NsKyQ3YleaZk_vI-EXEQrYmg3DYaJ59C25FvBSeA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNzA1MzIyNS4yNzUw
NS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1t
aW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIHJlcGxpY2F0aW9uLm8KICBDQyAgICAgIGJsb2NrL3Jhdy1mb3JtYXQu
bwovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9wYXRoLmM6IEluIGZ1bmN0aW9uICdpbml0X3BhdGhz
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjI0OjU6IGVycm9yOiAnZ19jYW5vbmlj
YWxpemVfZmlsZW5hbWUnIGlzIGRlcHJlY2F0ZWQ6IE5vdCBhdmFpbGFibGUgYmVmb3JlIDIuNTgg
Wy1XZXJyb3I9ZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAgICAgYmFzZSA9IGdfY2Fub25pY2Fs
aXplX2ZpbGVuYW1lKHByZWZpeCwgTlVMTCk7CiAgICAgXn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3Vzci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWluZ3cvaW5jbHVkZS9nbGliLTIu
MC9nbGliLmg6NDgsCi0tLQogZ2NoYXIgKmdfY2Fub25pY2FsaXplX2ZpbGVuYW1lIChjb25zdCBn
Y2hhciAqZmlsZW5hbWUsCiAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11
LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOiBJbiBmdW5jdGlvbiAncGF0aCc6Ci90bXAvcWVtdS10ZXN0
L3NyYy91dGlsL3BhdGguYzo1NDoxMzogZXJyb3I6IGFzc2lnbm1lbnQgZGlzY2FyZHMgJ2NvbnN0
JyBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1x
dWFsaWZpZXJzXQogICAgICAgICByZXQgPSB2YWx1ZSA/IHZhbHVlIDogbmFtZTsKICAgICAgICAg
ICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjYwOjk6IGVycm9yOiAnZ19jYW5v
bmljYWxpemVfZmlsZW5hbWUnIGlzIGRlcHJlY2F0ZWQ6IE5vdCBhdmFpbGFibGUgYmVmb3JlIDIu
NTggWy1XZXJyb3I9ZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAgICAgICAgIGZ1bGxfbmFtZSA9
IGdfY2Fub25pY2FsaXplX2ZpbGVuYW1lKGdfcGF0aF9za2lwX3Jvb3QobmFtZSksIGJhc2UpOwog
ICAgICAgICBefn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IveDg2XzY0LXc2NC1t
aW5ndzMyL3N5cy1yb290L21pbmd3L2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjQ4LAotLS0KL3Vz
ci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWluZ3cvaW5jbHVkZS9nbGliLTIuMC9nbGli
L2dmaWxldXRpbHMuaDoxNzY6ODogbm90ZTogZGVjbGFyZWQgaGVyZQogZ2NoYXIgKmdfY2Fub25p
Y2FsaXplX2ZpbGVuYW1lIChjb25zdCBnY2hhciAqZmlsZW5hbWUsCiAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjc0OjE3OiBlcnJv
cjogYXNzaWdubWVudCBkaXNjYXJkcyAnY29uc3QnIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFy
Z2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAgICAgICAgICAgICByZXQg
PSBuYW1lOwogICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMTkwNDE3MDUzMjI1LjI3NTA1LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


