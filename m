Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ECC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D008120675
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D008120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGdJt-0001Uv-3K
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 01:41:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGdJ5-00014u-FY
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGdIy-0000HU-Bm
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:23 -0400
Resent-Date: Wed, 17 Apr 2019 01:40:21 -0400
Resent-Message-Id: <E1hGdIy-0000HU-Bm@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hGdIs-00005q-NN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555479576; cv=none; d=zoho.com; s=zohoarc; 
	b=OadJS/dlToLB7U1ZDZR7pSS/XSdRiTmINXFJOiDpf/IHJprQzw2SUwfIfJ1ijYjj8tDXKTObBE7jp9OCOUtedYkD2yCtyiCLGWoHrw7AWLwy21GF2zMKTSN6siCajftqx132lLwwR6Eny7Gmb909MCx1qDKDjtuUPtOy37hxsOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555479576;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=vCLw0AfilsQYGv0+CkWMtIN/6FMWKGDInYTZQeIoKVI=; 
	b=cLpgH+HtuqAHCMb1ZQ6tnTdN7+MyikWMfIHtgLxOElXvpqrR6/JNdPOBflTNKL6xbxaYUehyQ+LTxn89VUwReVjlgT93l1UW0bN8jP+K86EUZbhW/263MA6XZ79oWBVQM2UQ9fwUPEkNqLCO8+8OPWkLnOCy1841O3c1xSUBzLI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555479572461615.0371921303599;
	Tue, 16 Apr 2019 22:39:32 -0700 (PDT)
Message-ID: <155547957120.17102.12945973855038831456@76452e4e88f2>
In-Reply-To: <20190417053225.27505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 16 Apr 2019 22:39:32 -0700 (PDT)
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
Message-ID: <20190417053932.mIOEgATabOwuvt4ZGLqdh-ows60Hls6IpfGOj3muO9w@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNzA1MzIyNS4yNzUw
NS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRz
IGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlv
dSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFS
R0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KCiAgQ0MgICAgICBzdHVicy9ibG9ja2Rldi1jbG9zZS1hbGwtYmRydi1zdGF0ZXMubwog
IENDICAgICAgc3R1YnMvY2xvY2std2FycC5vCiAgQ0MgICAgICBzdHVicy9jcHUtZ2V0LWNsb2Nr
Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjI0OjEyOiBlcnJvcjogJ2dfY2Fub25p
Y2FsaXplX2ZpbGVuYW1lJyBpcyBkZXByZWNhdGVkIFstV2Vycm9yLC1XZGVwcmVjYXRlZC1kZWNs
YXJhdGlvbnNdCiAgICBiYXNlID0gZ19jYW5vbmljYWxpemVfZmlsZW5hbWUocHJlZml4LCBOVUxM
KTsKICAgICAgICAgICBeCi91c3IvaW5jbHVkZS9nbGliLTIuMC9nbGliL2dmaWxldXRpbHMuaDox
NzU6MTogbm90ZTogJ2dfY2Fub25pY2FsaXplX2ZpbGVuYW1lJyBoYXMgYmVlbiBleHBsaWNpdGx5
IG1hcmtlZCBkZXByZWNhdGVkIGhlcmUKLS0tCi91c3IvaW5jbHVkZS9nbGliLTIuMC9nbGliL2dt
YWNyb3MuaDo0MzI6Mzc6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ0dfREVQUkVDQVRFRCcK
I2RlZmluZSBHX0RFUFJFQ0FURUQgX19hdHRyaWJ1dGVfXygoX19kZXByZWNhdGVkX18pKQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy91dGls
L3BhdGguYzo1NDoxMzogZXJyb3I6IGFzc2lnbmluZyB0byAnY2hhciAqJyBmcm9tICdjb25zdCB2
b2lkIConIGRpc2NhcmRzIHF1YWxpZmllcnMgWy1XZXJyb3IsLVdpbmNvbXBhdGlibGUtcG9pbnRl
ci10eXBlcy1kaXNjYXJkcy1xdWFsaWZpZXJzXQogICAgICAgIHJldCA9IHZhbHVlID8gdmFsdWUg
OiBuYW1lOwogICAgICAgICAgICBeIH5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0
L3NyYy91dGlsL3BhdGguYzo2MDoyMTogZXJyb3I6ICdnX2Nhbm9uaWNhbGl6ZV9maWxlbmFtZScg
aXMgZGVwcmVjYXRlZCBbLVdlcnJvciwtV2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogICAgICAg
IGZ1bGxfbmFtZSA9IGdfY2Fub25pY2FsaXplX2ZpbGVuYW1lKGdfcGF0aF9za2lwX3Jvb3QobmFt
ZSksIGJhc2UpOwogICAgICAgICAgICAgICAgICAgIF4KL3Vzci9pbmNsdWRlL2dsaWItMi4wL2ds
aWIvZ2ZpbGV1dGlscy5oOjE3NToxOiBub3RlOiAnZ19jYW5vbmljYWxpemVfZmlsZW5hbWUnIGhh
cyBiZWVuIGV4cGxpY2l0bHkgbWFya2VkIGRlcHJlY2F0ZWQgaGVyZQotLS0KL3Vzci9pbmNsdWRl
L2dsaWItMi4wL2dsaWIvZ21hY3Jvcy5oOjQzMjozNzogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNy
byAnR19ERVBSRUNBVEVEJwojZGVmaW5lIEdfREVQUkVDQVRFRCBfX2F0dHJpYnV0ZV9fKChfX2Rl
cHJlY2F0ZWRfXykpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9x
ZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjc0OjE3OiBlcnJvcjogYXNzaWduaW5nIHRvICdjaGFy
IConIGZyb20gJ2NvbnN0IGNoYXIgKicgZGlzY2FyZHMgcXVhbGlmaWVycyBbLVdlcnJvciwtV2lu
Y29tcGF0aWJsZS1wb2ludGVyLXR5cGVzLWRpc2NhcmRzLXF1YWxpZmllcnNdCiAgICAgICAgICAg
IHJldCA9IG5hbWU7CiAgICAgICAgICAgICAgICBeIH5+fn4KNCBlcnJvcnMgZ2VuZXJhdGVkLgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA0MTcwNTMyMjUuMjc1MDUtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3Rpbmcu
YXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


