Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51736C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2DF20872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Fo5Yg6J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2DF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBgWP-00086a-Cc
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 11:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacob.prida@protonmail.com>)
 id 1kBeZB-0002ui-JF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:37:18 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:42511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacob.prida@protonmail.com>)
 id 1kBeZ7-0007Ay-A2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:37:17 -0400
Date: Fri, 28 Aug 2020 13:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1598621828;
 bh=l5F9dF6yyRQ3tVTWZpkfvGcZ6MP4zh9qcUgBDKojbu8=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=Fo5Yg6J5Nn8T7uK5tXrQ30nq+7MVkefNPURfQ3ID+UkNPi0+V5x25chuxQVJkGSA6
 9bKYniJ525VpMJ5jXBmcNmh/bQvExxZtx+400+aECQDXHYlMjd3IxnCYzfuZTB5yKF
 xNhin+UD4Zlvskhm9I4zrnDbviZMlmg56Krk0E/4=
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Jacob Prida <jacob.prida@protonmail.com>
Cc: "stefanha@gmail.com" <stefanha@gmail.com>
Subject: Question regarding packet sniffing from a guest KVM
Message-ID: <JAKyy2sEdENiHm11y9YsYIrKKGYoGLfCrQcKqEtfg6hVUr5OSmmzujHFhAdd3tdfqonybfaBzBNf7ZhipGhHpX59Uzr-LwjBwgpqGgt_aGA=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1_Dgjj6XEfQGXlIPLHAH8hD0bl1TYzuyyG1ngR9inIk"
Received-SPF: pass client-ip=185.70.40.140;
 envelope-from=jacob.prida@protonmail.com; helo=mail-40140.protonmail.ch
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:37:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 28 Aug 2020 11:41:42 -0400
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
Reply-To: Jacob Prida <jacob.prida@protonmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.

--b1_Dgjj6XEfQGXlIPLHAH8hD0bl1TYzuyyG1ngR9inIk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGVsbG8sCgpJIHNhdyB5b3VyIGJsb2cgcG9zdCAoaHR0cDovL2Jsb2cudm1zcGxpY2UubmV0LzIw
MTEvMDQvaG93LXRvLWNhcHR1cmUtdm0tbmV0d29yay10cmFmZmljLXVzaW5nLmh0bWwpIG9uIHBh
Y2tldCBzbmlmZmluZywgYW5kIHdhcyB3b25kZXJpbmcgaWYgSSBjb3VsZCBnZXQgeW91ciBhZHZp
Y2Ugb24gYSBwcm9ibGVtIEknbSBoYXZpbmcuCgpJIHBvc3RlZCB0aGlzIHF1ZXN0aW9uIHRvIHN0
YWNrZXhjaGFuZ2UgYXMgd2VsbCAoaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFuZ2UuY29tL3F1ZXN0
aW9ucy82MDY3MjIvY2FuLWktc25pZmYtcGFja2V0cy1vbi1hLWhvc3QtaW50ZXJmYWNlLW1hY3Z0
YXAtdGhyb3VnaC1hLWd1ZXN0LW9zLW9uLXFlbXUta3ZtKSBidXQgaGVyZSBpcyBteSBwcm9ibGVt
OgoKSSB3YW50IHRvIHBhY2tldCBzbmlmZiBhIHBoeXNpY2FsIE5JQyBmcm9tIGEgZ3Vlc3QgVk0u
IFRoZSBndWVzdCBWTSBpcyB3aW5kb3dzIDEwIHdpdGggV2lyZXNoYXJrL25wY2FwLiBJIHdhbnQg
dG8gc2V0dXAgdGhlIHZpcnR1YWwgbmV0d29yayBpbnRlcmZhY2UgdG8gZW5hYmxlIHRoaXMgcGFj
a2V0IHNuaWZmaW5nLiBUaGUgaG9zdCBPUyBpcyBSSEVMIDcuIEN1cnJlbnRseSwgSSBoYXZlIHRo
ZSBWTSBjb25uZWN0ZWQgdG8gYSBtYWN2dGFwIGludGVyZmFjZSBmb3IgdGhlIHBoeXNpY2FsIGRl
dmljZSBJIHdhbnQgdG8gc25pZmYsIGJ1dCBJIGFtIG5vdCBzZWVpbmcgYW55IGRhdGEgb24gV2ly
ZXNoYXJrLgoKQW55IGhlbHAvYWR2aWNlIGlzIGdyZWF0bHkgYXBwcmVjaWF0ZWQuCgpSZWdhcmRz
LAoKSmFjb2IKClNlbnQgd2l0aCBbUHJvdG9uTWFpbF0oaHR0cHM6Ly9wcm90b25tYWlsLmNvbSkg
U2VjdXJlIEVtYWlsLg==

--b1_Dgjj6XEfQGXlIPLHAH8hD0bl1TYzuyyG1ngR9inIk
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdj5IZWxsbyw8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHNhdyB5b3VyIGJsb2cg
cG9zdCAoPGEgaHJlZj0iaHR0cDovL2Jsb2cudm1zcGxpY2UubmV0LzIwMTEvMDQvaG93LXRvLWNh
cHR1cmUtdm0tbmV0d29yay10cmFmZmljLXVzaW5nLmh0bWwiPmh0dHA6Ly9ibG9nLnZtc3BsaWNl
Lm5ldC8yMDExLzA0L2hvdy10by1jYXB0dXJlLXZtLW5ldHdvcmstdHJhZmZpYy11c2luZy5odG1s
PC9hPikgb24gcGFja2V0IHNuaWZmaW5nLCBhbmQgd2FzIHdvbmRlcmluZyBpZiBJIGNvdWxkIGdl
dCB5b3VyIGFkdmljZSBvbiBhIHByb2JsZW0gSSdtIGhhdmluZy48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5JIHBvc3RlZCB0aGlzIHF1ZXN0aW9uIHRvIHN0YWNrZXhjaGFuZ2UgYXMgd2Vs
bCAoPGEgaHJlZj0iaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFuZ2UuY29tL3F1ZXN0aW9ucy82MDY3
MjIvY2FuLWktc25pZmYtcGFja2V0cy1vbi1hLWhvc3QtaW50ZXJmYWNlLW1hY3Z0YXAtdGhyb3Vn
aC1hLWd1ZXN0LW9zLW9uLXFlbXUta3ZtIj5odHRwczovL3VuaXguc3RhY2tleGNoYW5nZS5jb20v
cXVlc3Rpb25zLzYwNjcyMi9jYW4taS1zbmlmZi1wYWNrZXRzLW9uLWEtaG9zdC1pbnRlcmZhY2Ut
bWFjdnRhcC10aHJvdWdoLWEtZ3Vlc3Qtb3Mtb24tcWVtdS1rdm08L2E+KSBidXQgaGVyZSBpcyBt
eSBwcm9ibGVtOjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2FudCB0byBwYWNrZXQg
c25pZmYgYSBwaHlzaWNhbCBOSUMgZnJvbSBhIGd1ZXN0IFZNLiBUaGUgZ3Vlc3QgVk0gaXMgd2lu
ZG93cyAxMCB3aXRoIFdpcmVzaGFyay9ucGNhcC4gSSB3YW50IHRvIHNldHVwIHRoZSB2aXJ0dWFs
IG5ldHdvcmsgaW50ZXJmYWNlIHRvIGVuYWJsZSB0aGlzIHBhY2tldCBzbmlmZmluZy4gVGhlIGhv
c3QgT1MgaXMgUkhFTCA3LiBDdXJyZW50bHksIEkgaGF2ZSB0aGUgVk0gY29ubmVjdGVkIHRvIGEg
bWFjdnRhcCBpbnRlcmZhY2UgZm9yIHRoZSBwaHlzaWNhbCBkZXZpY2UgSSB3YW50IHRvIHNuaWZm
LCBidXQgSSBhbSBub3Qgc2VlaW5nIGFueSBkYXRhIG9uIFdpcmVzaGFyay48YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5BbnkgaGVscC9hZHZpY2UgaXMgZ3JlYXRseSBhcHByZWNpYXRlZC48
YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PkphY29iPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9InByb3Rv
bm1haWxfc2lnbmF0dXJlX2Jsb2NrIj48ZGl2IGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9i
bG9jay11c2VyIHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5Ij48YnI+PC9kaXY+PGRp
diBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stcHJvdG9uIj5TZW50IHdpdGggPGEg
aHJlZj0iaHR0cHM6Ly9wcm90b25tYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPlByb3Rvbk1haWw8
L2E+IFNlY3VyZSBFbWFpbC48YnI+PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+


--b1_Dgjj6XEfQGXlIPLHAH8hD0bl1TYzuyyG1ngR9inIk--


