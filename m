Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D47FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA10D206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKiuo0AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA10D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnFv-0004pD-4Z
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jbnFC-0003oL-0u
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:36:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jbnFB-0007tH-7r
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hXDueTUGkhv7ebObH+z2sde/3y2Ea3oVitQ+E7WruxQ=;
 b=KKiuo0AQMkQFqxu4yCzSoAa3xmMa8asIa2Z2Dc/otkseOXh4NOGbU6ehNvXmRQbHTsfPCM
 VwazE9xi0zW22dDYKP45RkUhMJP+CUlhseLuYKcOfSvMe6mvmJxRLHyzLdzv7lcOHqcrI6
 1fGN5+8u0XplZo43ZMC0uH9d61ckIFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-uCWRpFXcPw-ybtkNUOtZJg-1; Thu, 21 May 2020 11:36:22 -0400
X-MC-Unique: uCWRpFXcPw-ybtkNUOtZJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21682107ACCD
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 15:36:21 +0000 (UTC)
Received: from localhost (ovpn-114-14.ams2.redhat.com [10.36.114.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5BF670461;
 Thu, 21 May 2020 15:36:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] minikconf: explicitly set encoding to UTF-8
Date: Thu, 21 May 2020 16:36:16 +0100
Message-Id: <20200521153616.307100-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSBjdXJyZW50bHkgb25seSBoYXMgQVNDSUkgS2NvbmZpZyBmaWxlcyBidXQgTGludXggYWN0
dWFsbHkgdXNlcwpVVEYtOC4gRXhwbGljaXRseSBzcGVjaWZ5IHRoZSBlbmNvZGluZyBhbmQgdGhh
dCB3ZSdyZSBkb2luZyB0ZXh0IGZpbGUKSS9PLgoKSXQncyB1bmNsZWFyIHdoZXRoZXIgb3Igbm90
IFFFTVUgd2lsbCBldmVyIG5lZWQgVW5pY29kZSBpbiBpdHMgS2NvbmZpZwpmaWxlcy4gSWYgd2Ug
c3RhcnQgdXNpbmcgdGhlIGhlbHAgdGV4dCB0aGVuIGl0IHdpbGwgYmVjb21lIGFuIGlzc3VlCnNv
b25lciBvciBsYXRlci4gTWFrZSB0aGlzIGNoYW5nZSBub3cgZm9yIGNvbnNpc3RlbmN5IHdpdGgg
TGludXgKS2NvbmZpZy4KClJlcG9ydGVkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KLS0tCiBzY3JpcHRzL21pbmlrY29uZi5weSB8IDYgKysrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nj
cmlwdHMvbWluaWtjb25mLnB5IGIvc2NyaXB0cy9taW5pa2NvbmYucHkKaW5kZXggOTBiOTk1MTdj
MS4uYmNkOTEwMTVkMyAxMDA3NTUKLS0tIGEvc2NyaXB0cy9taW5pa2NvbmYucHkKKysrIGIvc2Ny
aXB0cy9taW5pa2NvbmYucHkKQEAgLTQwMiw3ICs0MDIsNyBAQCBjbGFzcyBLY29uZmlnUGFyc2Vy
OgogICAgICAgICBpZiBpbmNsX2Fic19mbmFtZSBpbiBzZWxmLmRhdGEucHJldmlvdXNseV9pbmNs
dWRlZDoKICAgICAgICAgICAgIHJldHVybgogICAgICAgICB0cnk6Ci0gICAgICAgICAgICBmcCA9
IG9wZW4oaW5jbF9hYnNfZm5hbWUsICdyJykKKyAgICAgICAgICAgIGZwID0gb3BlbihpbmNsX2Fi
c19mbmFtZSwgJ3J0JywgZW5jb2Rpbmc9J3V0Zi04JykKICAgICAgICAgZXhjZXB0IElPRXJyb3Ig
YXMgZToKICAgICAgICAgICAgIHJhaXNlIEtjb25maWdQYXJzZXJFcnJvcihzZWxmLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAnJXM6ICVzJyAlIChlLnN0cmVycm9yLCBpbmNsdWRl
KSkKQEAgLTY5Niw3ICs2OTYsNyBAQCBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgogICAgICAg
ICAgICAgcGFyc2VyLmRvX2Fzc2lnbm1lbnQobmFtZSwgdmFsdWUgPT0gJ3knKQogICAgICAgICAg
ICAgZXh0ZXJuYWxfdmFycy5hZGQobmFtZVs3Ol0pCiAgICAgICAgIGVsc2U6Ci0gICAgICAgICAg
ICBmcCA9IG9wZW4oYXJnLCAncicpCisgICAgICAgICAgICBmcCA9IG9wZW4oYXJnLCAncnQnLCBl
bmNvZGluZz0ndXRmLTgnKQogICAgICAgICAgICAgcGFyc2VyLnBhcnNlX2ZpbGUoZnApCiAgICAg
ICAgICAgICBmcC5jbG9zZSgpCiAKQEAgLTcwNSw3ICs3MDUsNyBAQCBpZiBfX25hbWVfXyA9PSAn
X19tYWluX18nOgogICAgICAgICBpZiBrZXkgbm90IGluIGV4dGVybmFsX3ZhcnMgYW5kIGNvbmZp
Z1trZXldOgogICAgICAgICAgICAgcHJpbnQgKCdDT05GSUdfJXM9eScgJSBrZXkpCiAKLSAgICBk
ZXBzID0gb3Blbihhcmd2WzJdLCAndycpCisgICAgZGVwcyA9IG9wZW4oYXJndlsyXSwgJ3d0Jywg
ZW5jb2Rpbmc9J3V0Zi04JykKICAgICBmb3IgZm5hbWUgaW4gZGF0YS5wcmV2aW91c2x5X2luY2x1
ZGVkOgogICAgICAgICBwcmludCAoJyVzOiAlcycgJSAoYXJndlsxXSwgZm5hbWUpLCBmaWxlPWRl
cHMpCiAgICAgZGVwcy5jbG9zZSgpCi0tIAoyLjI1LjMKCg==


