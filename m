Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D57C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0664120651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uLbj+3Ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0664120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMJ7E-0000jE-Us
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 17:19:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMJ66-0000He-UJ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMJ65-0002JR-0k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:18:30 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:39340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMJ63-0001vA-Ju
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556831898;
	bh=ZxXqRiSgHAzRZub19E15ED6WmN+lJym9DOGZ7o8khuQ=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=uLbj+3Ch1DwZElgo/Y+yA1s53uGjKU77ku+W0+VU+Vio5plW6HjxvCktE5ZTN0gcJ
	t+PoRjnNi1qiFfqOprS/Z7Q/38RI2lePJS0zozqmcKHJB8bYh9USmC2Ejnenap09Ef
	M1l/mC2BJmNxxpvaxwF2RHSQuwTKQf6XRlddxZQI=
X-QQ-FEAT: 3p7n3kIA6lXTrvIqubXpDAIXZzaFiWPlAxjnX5lPCvxPTTZf9Z9urjHGJofy2
	mCvgrzMrbgEvRe508Abxugh1xxbssMaprMhj4yaL1kgyrGWej7qZ+M5zGtF0z9kjiVtd5EQ
	fEYm/HL8AGfXf0NLwc/1KYlRNdG0QI7ZnbPA+3CKLVhvNg5wEvM+RS5au5yt9PfwliRLACy
	GZQ7RwtXYpnrHOcoGNEn+OWzckHdWcnwRTUh1HUW2zaJvy/47b0zq486Z9s1CEtonlnSDmy
	OmeKEkaXE1n/ef
X-QQ-SSF: 000000000000003000000000000000P
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 183.63.18.252
X-QQ-STYLE: 
X-QQ-mid: webmail122t1556831897t5793276
From: "=?ISO-8859-1?B?ZHJpdmVyMTk5OA==?=" <driver1998@foxmail.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>,
	"=?ISO-8859-1?B?RXJpYyBCbGFrZQ==?=" <eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 3 May 2019 05:18:16 +0800
X-Priority: 3
Message-ID: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 03 May 2019 05:18:17 +0800 (CST)
Feedback-ID: webmail:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 54.207.22.56
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion
 warningin commands-win32.c, hit by clang.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502211816.j_4pnywDO3CST5cg2p8pFaFVLG2j1lMlopPsbExDwcg@z>

T24gNS8xLzE5IDI6MjUgQU0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+IFRoaXMgYWRkcyBsb3Rz
IG9mIGV4cGxpY2l0IGNhc3RzLiBBcmUgdGhleSBhY3R1YWxseSBuZWNlc3Nhcnk/IFdpdGhv
dXQNCj4gc2VlaW5nIHRoZSBhY3R1YWwgd2FybmluZywgaXQgc2VlbXMgZmlzaHkgdG8gaGF2
ZSB0byBiZSB0aGlzIGV4cGxpY2l0Lg0KDQpTbyBoZXJlIGFyZSB0aGUgd2FybmluZ3MsIG9u
IGNsYW5nIHZlcnNpb24gOS4wLjAgKHRydW5rIDM1MTk3NykuDQoNCnFnYS9jb21tYW5kcy13
aW4zMi5jOjQ2MToyNDogZXJyb3I6IGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJh
dGlvbiB0eXBlICdlbnVtIEd1ZXN0RGlza0J1c1R5cGUnIHRvIGRpZmZlcmVudA0KICAgICAg
ZW51bWVyYXRpb24gdHlwZSAnU1RPUkFHRV9CVVNfVFlQRScgKGFrYSAnZW51bSBfU1RPUkFH
RV9CVVNfVFlQRScpIFstV2Vycm9yLC1XZW51bS1jb252ZXJzaW9uXQ0KICAgIFtCdXNUeXBl
VW5rbm93bl0gPSBHVUVTVF9ESVNLX0JVU19UWVBFX1VOS05PV04sDQogICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KcWdhL2NvbW1hbmRzLXdp
bjMyLmM6NDYyOjIxOiBlcnJvcjogaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIGVudW1lcmF0
aW9uIHR5cGUgJ2VudW0gR3Vlc3REaXNrQnVzVHlwZScgdG8gZGlmZmVyZW50DQogICAgICBl
bnVtZXJhdGlvbiB0eXBlICdTVE9SQUdFX0JVU19UWVBFJyAoYWthICdlbnVtIF9TVE9SQUdF
X0JVU19UWVBFJykgWy1XZXJyb3IsLVdlbnVtLWNvbnZlcnNpb25dDQogICAgW0J1c1R5cGVT
Y3NpXSA9IEdVRVNUX0RJU0tfQlVTX1RZUEVfU0NTSSwNCiAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQpxZ2EvY29tbWFuZHMtd2luMzIuYzo0NjM6MjI6
IGVycm9yOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20gZW51bWVyYXRpb24gdHlwZSAnZW51
bSBHdWVzdERpc2tCdXNUeXBlJyB0byBkaWZmZXJlbnQNCiAgICAgIGVudW1lcmF0aW9uIHR5
cGUgJ1NUT1JBR0VfQlVTX1RZUEUnIChha2EgJ2VudW0gX1NUT1JBR0VfQlVTX1RZUEUnKSBb
LVdlcnJvciwtV2VudW0tY29udmVyc2lvbl0NCiAgICBbQnVzVHlwZUF0YXBpXSA9IEdVRVNU
X0RJU0tfQlVTX1RZUEVfSURFLA0KICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4NCnFnYS9jb21tYW5kcy13aW4zMi5jOjQ2NDoyMDogZXJyb3I6IGltcGxp
Y2l0IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIEd1ZXN0RGlza0J1
c1R5cGUnIHRvIGRpZmZlcmVudA0KICAgICAgZW51bWVyYXRpb24gdHlwZSAnU1RPUkFHRV9C
VVNfVFlQRScgKGFrYSAnZW51bSBfU1RPUkFHRV9CVVNfVFlQRScpIFstV2Vycm9yLC1XZW51
bS1jb252ZXJzaW9uXQ0KICAgIFtCdXNUeXBlQXRhXSA9IEdVRVNUX0RJU0tfQlVTX1RZUEVf
SURFLA0KICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQpxZ2Ev
Y29tbWFuZHMtd2luMzIuYzo0NjU6MjE6IGVycm9yOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZy
b20gZW51bWVyYXRpb24gdHlwZSAnZW51bSBHdWVzdERpc2tCdXNUeXBlJyB0byBkaWZmZXJl
bnQNCiAgICAgIGVudW1lcmF0aW9uIHR5cGUgJ1NUT1JBR0VfQlVTX1RZUEUnIChha2EgJ2Vu
dW0gX1NUT1JBR0VfQlVTX1RZUEUnKSBbLVdlcnJvciwtV2VudW0tY29udmVyc2lvbl0NCiAg
ICBbQnVzVHlwZTEzOTRdID0gR1VFU1RfRElTS19CVVNfVFlQRV9JRUVFMTM5NCwNCiAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KcWdhL2NvbW1h
bmRzLXdpbjMyLmM6NDY2OjIwOiBlcnJvcjogaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIGVu
dW1lcmF0aW9uIHR5cGUgJ2VudW0gR3Vlc3REaXNrQnVzVHlwZScgdG8gZGlmZmVyZW50DQog
ICAgICBlbnVtZXJhdGlvbiB0eXBlICdTVE9SQUdFX0JVU19UWVBFJyAoYWthICdlbnVtIF9T
VE9SQUdFX0JVU19UWVBFJykgWy1XZXJyb3IsLVdlbnVtLWNvbnZlcnNpb25dDQogICAgW0J1
c1R5cGVTc2FdID0gR1VFU1RfRElTS19CVVNfVFlQRV9TU0EsDQogICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCnFnYS9jb21tYW5kcy13aW4zMi5jOjQ2Nzoy
MjogZXJyb3I6IGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdl
bnVtIEd1ZXN0RGlza0J1c1R5cGUnIHRvIGRpZmZlcmVudA0KICAgICAgZW51bWVyYXRpb24g
dHlwZSAnU1RPUkFHRV9CVVNfVFlQRScgKGFrYSAnZW51bSBfU1RPUkFHRV9CVVNfVFlQRScp
IFstV2Vycm9yLC1XZW51bS1jb252ZXJzaW9uXQ0KICAgIFtCdXNUeXBlRmlicmVdID0gR1VF
U1RfRElTS19CVVNfVFlQRV9TU0EsDQogICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KcWdhL2NvbW1hbmRzLXdpbjMyLmM6NDY4OjIwOiBlcnJvcjogaW1w
bGljaXQgY29udmVyc2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gR3Vlc3REaXNr
QnVzVHlwZScgdG8gZGlmZmVyZW50DQogICAgICBlbnVtZXJhdGlvbiB0eXBlICdTVE9SQUdF
X0JVU19UWVBFJyAoYWthICdlbnVtIF9TVE9SQUdFX0JVU19UWVBFJykgWy1XZXJyb3IsLVdl
bnVtLWNvbnZlcnNpb25dDQogICAgW0J1c1R5cGVVc2JdID0gR1VFU1RfRElTS19CVVNfVFlQ
RV9VU0IsDQogICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCnFn
YS9jb21tYW5kcy13aW4zMi5jOjQ2OToyMTogZXJyb3I6IGltcGxpY2l0IGNvbnZlcnNpb24g
ZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIEd1ZXN0RGlza0J1c1R5cGUnIHRvIGRpZmZl
cmVudA0KICAgICAgZW51bWVyYXRpb24gdHlwZSAnU1RPUkFHRV9CVVNfVFlQRScgKGFrYSAn
ZW51bSBfU1RPUkFHRV9CVVNfVFlQRScpIFstV2Vycm9yLC1XZW51bS1jb252ZXJzaW9uXQ0K
ICAgIFtCdXNUeXBlUkFJRF0gPSBHVUVTVF9ESVNLX0JVU19UWVBFX1JBSUQsDQogICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KcWdhL2NvbW1hbmRzLXdp
bjMyLmM6NDcwOjIyOiBlcnJvcjogaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIGVudW1lcmF0
aW9uIHR5cGUgJ2VudW0gR3Vlc3REaXNrQnVzVHlwZScgdG8gZGlmZmVyZW50DQogICAgICBl
bnVtZXJhdGlvbiB0eXBlICdTVE9SQUdFX0JVU19UWVBFJyAoYWthICdlbnVtIF9TVE9SQUdF
X0JVU19UWVBFJykgWy1XZXJyb3IsLVdlbnVtLWNvbnZlcnNpb25dDQogICAgW0J1c1R5cGVp
U2NzaV0gPSBHVUVTVF9ESVNLX0JVU19UWVBFX0lTQ1NJLA0KICBDQyAgICAgIHFnYS9xYXBp
LWdlbmVyYXRlZC9xZ2EtcWFwaS12aXNpdC5vDQogICAgICAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQpxZ2EvY29tbWFuZHMtd2luMzIuYzo0NzE6MjA6IGVy
cm9yOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20gZW51bWVyYXRpb24gdHlwZSAnZW51bSBH
dWVzdERpc2tCdXNUeXBlJyB0byBkaWZmZXJlbnQNCiAgICAgIGVudW1lcmF0aW9uIHR5cGUg
J1NUT1JBR0VfQlVTX1RZUEUnIChha2EgJ2VudW0gX1NUT1JBR0VfQlVTX1RZUEUnKSBbLVdl
cnJvciwtV2VudW0tY29udmVyc2lvbl0NCiAgICBbQnVzVHlwZVNhc10gPSBHVUVTVF9ESVNL
X0JVU19UWVBFX1NBUywNCiAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KcWdhL2NvbW1hbmRzLXdpbjMyLmM6NDcyOjIxOiBlcnJvcjogaW1wbGljaXQgY29u
dmVyc2lvbiBmcm9tIGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gR3Vlc3REaXNrQnVzVHlwZScg
dG8gZGlmZmVyZW50DQogICAgICBlbnVtZXJhdGlvbiB0eXBlICdTVE9SQUdFX0JVU19UWVBF
JyAoYWthICdlbnVtIF9TVE9SQUdFX0JVU19UWVBFJykgWy1XZXJyb3IsLVdlbnVtLWNvbnZl
cnNpb25dDQogICAgW0J1c1R5cGVTYXRhXSA9IEdVRVNUX0RJU0tfQlVTX1RZUEVfU0FUQSwN
CiAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQpxZ2EvY29t
bWFuZHMtd2luMzIuYzo0NzM6MjA6IGVycm9yOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20g
ZW51bWVyYXRpb24gdHlwZSAnZW51bSBHdWVzdERpc2tCdXNUeXBlJyB0byBkaWZmZXJlbnQN
CiAgICAgIGVudW1lcmF0aW9uIHR5cGUgJ1NUT1JBR0VfQlVTX1RZUEUnIChha2EgJ2VudW0g
X1NUT1JBR0VfQlVTX1RZUEUnKSBbLVdlcnJvciwtV2VudW0tY29udmVyc2lvbl0NCiAgICBb
QnVzVHlwZVNkXSA9ICBHVUVTVF9ESVNLX0JVU19UWVBFX1NELA0KICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCnFnYS9jb21tYW5kcy13aW4zMi5jOjQ3NDoy
MDogZXJyb3I6IGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdl
bnVtIEd1ZXN0RGlza0J1c1R5cGUnIHRvIGRpZmZlcmVudA0KICAgICAgZW51bWVyYXRpb24g
dHlwZSAnU1RPUkFHRV9CVVNfVFlQRScgKGFrYSAnZW51bSBfU1RPUkFHRV9CVVNfVFlQRScp
IFstV2Vycm9yLC1XZW51bS1jb252ZXJzaW9uXQ0KICAgIFtCdXNUeXBlTW1jXSA9IEdVRVNU
X0RJU0tfQlVTX1RZUEVfTU1DLA0KICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQpxZ2EvY29tbWFuZHMtd2luMzIuYzo0ODY6MTI6IGVycm9yOiBpbXBsaWNp
dCBjb252ZXJzaW9uIGZyb20gZW51bWVyYXRpb24gdHlwZSAnU1RPUkFHRV9CVVNfVFlQRScN
CiAgICAgIChha2EgJ2VudW0gX1NUT1JBR0VfQlVTX1RZUEUnKSB0byBkaWZmZXJlbnQgZW51
bWVyYXRpb24gdHlwZSAnR3Vlc3REaXNrQnVzVHlwZScgKGFrYSAnZW51bSBHdWVzdERpc2tC
dXNUeXBlJykNCiAgICAgIFstV2Vycm9yLC1XZW51bS1jb252ZXJzaW9uXQ0KICAgIHJldHVy
biB3aW4ycWVtdVsoaW50KWJ1c107DQogICAgfn5+fn5+IF5+fn5+fn5+fn5+fn5+fn5+fg0K
DQo+IE9yIGlzIGl0IGNvbXBsYWluaW5nIHRoYXQgR3Vlc3REaXNrQnVzVHlwZSBhbmQgU1RP
UkFHRV9CVVNfVFlQRSBhcmUNCj4gZGlzdGluY3QgdHlwZXMsIGFuZCB0aGF0IHdlIGFyZSBp
bmRlZWQgY3Jvc3MtYXNzaWduaW5nIGJldHdlZW4gdGhlIHR3bw0KPiBlbnVtcyBiZWNhdXNl
IHdlIGludGVudGlvbmFsbHkgd2FudCB0aGVtIHRvIHNoYXJlIHZhbHVlcz8NCg0KSXQgbG9v
a3MgbGlrZSBpdCBpcywgYWNjb3JkaW5nIHRvIHRoZSBsYXN0IHdhcm5pbmcu




