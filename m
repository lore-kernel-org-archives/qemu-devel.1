Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 15:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C802065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="C5Hc9nzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C802065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZylm-0000ir-9h
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 11:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victor.lavaud@protonmail.com>)
 id 1jZy7E-0008B9-3L
 for qemu-devel@nongnu.org; Sat, 16 May 2020 10:48:40 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:34673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victor.lavaud@protonmail.com>)
 id 1jZy7B-0001j5-Og
 for qemu-devel@nongnu.org; Sat, 16 May 2020 10:48:39 -0400
Date: Sat, 16 May 2020 14:42:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1589640174;
 bh=SsCpBDNAIQ3v58OWvOEydwcu9WNsco8XmUdn2Sorlog=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=C5Hc9nzIDKi47Sgh/tqylfT/uAjELSSXjSfzQlPtxDNKnqlV2BF70A3BawNEccWpB
 4cZOvTfGlK7u6Cp5H+WF2QTnw+nHjpmTl9RbpOPicUKGvNBXKyTB1wYJrfXxoaIRDv
 F6gSkkPuZthvsN/HLO1Y+lcBN/xn/lsXCeT2PeYg=
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: Patch to fix missing Exec field in qemu.desktop
Message-ID: <zrVSyE1D2Xtxcr723wTf2sJRtM0IPuBRH0S-Gyx2XsvooDqbMYhqrK_aVk3AZM8RkjyOzYKWQH3VrnWDjwVUspDJHYUKXOyLZEZlvAzz6Ww=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="---------------------b60704120c712c8953f031f4042c4404";
 charset=UTF-8
Received-SPF: pass client-ip=185.70.40.134;
 envelope-from=victor.lavaud@protonmail.com; helo=mail-40134.protonmail.ch
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 10:42:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 16 May 2020 11:29:20 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Victor Lavaud <victor.lavaud@protonmail.com>, Victor Lavaud <victor.lavaud@protonmail.com>
From: Victor Lavaud via <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------b60704120c712c8953f031f4042c4404
Content-Type: multipart/mixed;boundary=---------------------5c8d758721f74f3fcee08b6133b9dea2

-----------------------5c8d758721f74f3fcee08b6133b9dea2
Content-Type: multipart/alternative;boundary=---------------------4f0d7dc96b6a713bd2eb1cca549316f4

-----------------------4f0d7dc96b6a713bd2eb1cca549316f4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8




Sent with ProtonMail Secure Email.


-----------------------4f0d7dc96b6a713bd2eb1cca549316f4
Content-Type: multipart/related;boundary=---------------------5d95b9c6d1cd288cbde1fa0773d162a6

-----------------------5d95b9c6d1cd288cbde1fa0773d162a6
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdiBjbGFzcz0icHJvdG9ubWFpbF9zaWdu
YXR1cmVfYmxvY2siPjxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXVzZXIg
cHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stZW1wdHkiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJw
cm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1wcm90b24iPlNlbnQgd2l0aCA8YSBocmVmPSJodHRw
czovL3Byb3Rvbm1haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+UHJvdG9uTWFpbDwvYT4gU2VjdXJl
IEVtYWlsLjxicj48L2Rpdj48L2Rpdj4=
-----------------------5d95b9c6d1cd288cbde1fa0773d162a6--

-----------------------4f0d7dc96b6a713bd2eb1cca549316f4--

-----------------------5c8d758721f74f3fcee08b6133b9dea2
Content-Type: text/x-patch; filename="fix-exec-field-in-qemu-desktop.patch"; name="fix-exec-field-in-qemu-desktop.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fix-exec-field-in-qemu-desktop.patch"; name="fix-exec-field-in-qemu-desktop.patch"

RnJvbSAyMDdhMWEzNGFjY2RjNWI1NjNkMjk0ODQyOTI4MjlhNDE5M2MzNWY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWN0b3IgTGF2YXVkIDx2aWN0b3IubGF2YXVkQGdtYWlsLmNv
bT4KRGF0ZTogU2F0LCAxNiBNYXkgMjAyMCAxNjozMzowMCArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IEZpeCBtaXNzaW5nIEV4ZWMgZmllbGQgaW4gcWVtdS5kZXNrdG9wCgpTaWduZWQtb2ZmLWJ5OiBW
aWN0b3IgTGF2YXVkIDx2aWN0b3IubGF2YXVkQHBtLm1lPgotLS0KIHVpL3FlbXUuZGVza3RvcCB8
IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvdWkvcWVt
dS5kZXNrdG9wIGIvdWkvcWVtdS5kZXNrdG9wCmluZGV4IDIwZjA5ZjU2YmUuLjFiOWYwMmEwY2Mg
MTAwNjQ0Ci0tLSBhL3VpL3FlbXUuZGVza3RvcAorKysgYi91aS9xZW11LmRlc2t0b3AKQEAgLTYs
MyArNiw0IEBAIFR5cGU9QXBwbGljYXRpb24KIFRlcm1pbmFsPWZhbHNlCiBLZXl3b3Jkcz1FbXVs
YXRvcnM7VmlydHVhbGl6YXRpb247S1ZNOwogTm9EaXNwbGF5PXRydWUKK0V4ZWM9cWVtdQotLSAK
Mi4yNi4yCgo=
-----------------------5c8d758721f74f3fcee08b6133b9dea2
Content-Type: application/pgp-keys; filename="publickey - victor.lavaud@protonmail.com - 0x54FBFBBD.asc"; name="publickey - victor.lavaud@protonmail.com - 0x54FBFBBD.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - victor.lavaud@protonmail.com - 0x54FBFBBD.asc"; name="publickey - victor.lavaud@protonmail.com - 0x54FBFBBD.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjENCkNvbW1lbnQ6IGh0dHBzOi8vb3BlbnBncGpzLm9yZw0KDQp4c0JOQkZ3dWIxTUJD
QURjVlhTU0JhZHUrOHNxMExvbitlSXdXcHVZUGt6NFcxVUxqMTMyUHdzUGIxNjUNClE2OU5yVUF6
R2ljak1zclgwNUpzS2lhdThzUW9oVkY1U01saUJ5T1JDelBiSGFWK0ZXNWEvRnBWRHNDZg0KaUFw
RWxLT2Q5QVZLcURveHpJYW82NVhDUnVFVG1jN2FDQWk1ZDJTV3Y1akNNZEpNdUhlR20rbTRoaW9z
DQpPaW0reFpCdzFnQ3F4TVdvTUFCeXAwTmxsSmliUHBIR2hYd2o4RzF4UUM2N2hYY3Vuc1QyQjFN
OEFDY3kNCk9kd2s0RUkrRHh6cVk1L0c0ZmlwMmpHZVJiVFM0UUFEQkZXMnhNNi8xQUp6V0ZoM0pQ
UU9md2Zwc2ZETA0KaWJsRHFFMzlDMm15dldWWnltR05NZWlJZVJmaGZrN3ZxbkpFRDlPZEh6QWZB
RkUwd2lSK0liYVRBQkVCDQpBQUhOUFNKMmFXTjBiM0l1YkdGMllYVmtRSEJ5YjNSdmJtMWhhV3d1
WTI5dElpQThkbWxqZEc5eUxteGgNCmRtRjFaRUJ3Y205MGIyNXRZV2xzTG1OdmJUN0N3SFVFRUFF
SUFCOEZBbHd1YjFNR0N3a0hDQU1DQkJVSQ0KQ2dJREZnSUJBaGtCQWhzREFoNEJBQW9KRUp3VlJ4
eFVqdThlSERNSCtnTmhKL3ROeG0zdHViTk0wVEpODQpNR0Rrbm1qM0huVlNaUldVTWsyUzRnTmJj
QnV6eXcyVlUzVm1xaFVLNUR6RVdLaDJrU25yR2xmV3JGTkcNCnJCZEg2UERrZ3p4bUxUbnhYNE5n
cFVQM1l6Q3dLaW42V2dZdUNJTDd4ZnRVVnRoYkpQemZ4c2FhYy9vQQ0KaVphTjhGZmdZbTlJc2NX
TGxxaFUycnZ3dEpuZW50endjU2ZwOGN4SE1aVjhwdVBxOExIVHFpd3haTTZDDQppZENYMEhRWjZs
Rzk4REhRdC9Ed21kNlk0SnIycU9Lekw0Qytad0FyeTk3dXdKbWxvS1F2eTB0WnRrNCsNCmRjRnhB
MDc2b1pNSTBSbjdkZVJ4ejNybzJId3VCZW5aTFJTajl6Tk1ReHNVTXRTUkUrclZJejRGTDdRRg0K
V1ZNKzBqMEVLbjJjYzdaQWZ6bmI5elBPd0UwRVhDNXZVd0VJQUxsVm9MYXgxRUN0UDBtdDI2UTRV
QytEDQpxazJrcVFCMDcwVzZCQjdNdEhiM2p4OHZ1WEFyUm1CTWIvTlpaQU5BV09mekU0dG9xdGFz
RmhZTy9ra28NCjVybi9ZRHVCc0FqOXJXRjRRUHBKWWo2U2M5anBLZWI2NkZCL1p0N0VsbzBOWTFE
QmFldEwwNmMyZDE1ZA0KcVJ0cFUySnprbE81ZUI1UUI0aFpYTWZFd0NkbUo4d2NoWlhpdjhXSS9Y
eG4zRVhSbGw5OEplbk9ObjBtDQp2K1FKV3QzbGZJV0pQY09kVHFwT0RCdGlFdlJNTDB3RFZHVjRW
cWtmU3BSWi9CMVgxM0RQZ1hodkVXaGMNCkVhVlp2QTd0VjU1YkxKTURGcmNhZnFXWmp1VFNaUGIz
Z2FLc2lFbDBwa3lWNVRCNjFDZXU3aDhBOThQMA0KYmgwZU5EQU1WdGllQmZCWjVWY0FFUUVBQWNM
QVh3UVlBUWdBQ1FVQ1hDNXZVd0liREFBS0NSQ2NGVWNjDQpWSTd2SGtBekNBRExjNHpGL21Hc2th
SFZ2MFFocm1JU2NpaGlGTFpCYno1ZWI0anV0RkwySlJTVVZWMHANCnRmb01TcjVqS3RlYUN0Q1FQ
MzNwbGRERjVNNXNrdm9tRnNUMEpvR0M1T0RIMXY1alcrUXhNUzJjL1lVdA0KVjNTWDVtclZxYmt6
OVRxZytKK0w1YlI0YU0weVNzN3pOQlJxTnduQmFNSTNLdHNUOCs2T2paY0tsWStqDQovVDBpdUp6
VWJLWE9jaHBaWWdCVGJHYVIxV0dNMFVaRXRwNjVIV0ZYbUNEaWJyUnkzN0pXS0VIV2tmZkENCjJk
L2dBOGNqNzJkNHU1RnVoMXFDSVVydWk4MjNMUnQ4WTViNjF2RzZzVERpQ0tzL216czBQSWJHaWlM
Ng0KNW1nQ1BXbE5zcGhVVng2Q3pLRjF5WEphcGtlb3d0NTEvNndxRzVrYVkweitJSFZ4UzZJSg0K
PUVzYmoNCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg==
-----------------------5c8d758721f74f3fcee08b6133b9dea2--

-----------------------b60704120c712c8953f031f4042c4404
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBcBAEBCAAGBQJev/vlAAoJEJwVRxxUju8eE5EIAIjyyiEGbcwqd7brXwJa
pp43dSl2ccFRaW+9/kPUAUMQJcbTdaceYHt9tdiGbHqxweWUhxyD+mWM9itG
HiGQWNvKAlU5npb5rya8oMFBC09xOAeJbtjmGzaHobrM5/9laG3nX1P0ijpR
B1mUqvWI7uD3r0K5fcxcz6r2fe87UnIKgN6qSYPzi3fuIW3Qw4/92JBWzX3p
qwTV5BJer27MRsm8+7QlLGA/Smab8jnEFtHMOokuD7gQta0RXyQpO+aF7K18
BaZwmNbbhZqyLFIpfzLCiqqlJ9qCXIMSAxVqSOB468bc5gMS627ZcdG92TzL
Kce8GD+Y82aDnK4YF6TGA9Y=
=MSm5
-----END PGP SIGNATURE-----


-----------------------b60704120c712c8953f031f4042c4404--


