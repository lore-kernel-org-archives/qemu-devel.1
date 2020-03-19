Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8748C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A172070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrZUKdZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A172070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEtP9-0003t3-L6
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jEtOJ-0003T6-2r
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jEtOH-0004SS-Q3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:31:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24375)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jEtOH-0004Pt-MD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584617469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUeb7eVKHzR6huGHguldQ1yMjr8M76rwgzBlTAgtsa4=;
 b=MrZUKdZkvaqLdOnMmZpRCzjRDnAD2ZIkTXDCT7CmQQRK9Abm4D6QN3RvKWMEZXnr95cTUA
 wiaOfURcV87bexXoUHyxaXolaQlvzYZdWDsTeapmrKnYt2Q9Xh/qA1ggL3RAyVfilQZSNZ
 kMlFN92UwK+xtrDmdEszhTQsMjZSG5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-khSeknyoNy-FxIw_BNExLg-1; Thu, 19 Mar 2020 07:29:22 -0400
X-MC-Unique: khSeknyoNy-FxIw_BNExLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA21CA136B;
 Thu, 19 Mar 2020 11:29:20 +0000 (UTC)
Received: from localhost (unknown [10.36.110.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D211E5D9CD;
 Thu, 19 Mar 2020 11:29:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] slirp: update submodule to v4.2.0 + mingw-fix
Date: Thu, 19 Mar 2020 12:29:11 +0100
Message-Id: <20200319112911.353244-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200319112911.353244-1-marcandre.lureau@redhat.com>
References: <20200319112911.353244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: samuel.thibault@ens-lyon.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

git shortlog
126c04acbabd7ad32c2b018fe10dfac2a3bc1210..7012a2c62e5b54eab88c119383022ec7c=
e86e9b2

5eraph (1):
      Use specific outbound IP address

Akihiro Suda (8):
      remove confusing comment that exists from ancient slirp
      add slirp_new(SlirpConfig *, SlirpCb *, void *)
      allow custom MTU
      add disable_host_loopback (prohibit connections to 127.0.0.1)
      add SlirpConfig version
      emu: remove dead code
      emu: disable by default
      fix a typo in a comment

Anders Waldenborg (1):
      state: fix loading of guestfwd state

Giuseppe Scrivano (1):
      socket: avoid getpeername after shutdown(SHUT_WR)

Jindrich Novy (1):
      Don't leak memory when reallocation fails.

Jordi Pujol Palomer (1):
      fork_exec: correctly parse command lines that contain spaces

Marc-Andr=C3=A9 Lureau (54):
      Merge branch 'AkihiroSuda/libslirp-slirp4netns'
      Merge branch 'fix-typo' into 'master'
      meson: make it subproject friendly
      Merge branch 'meson' into 'master'
      misc: fix compilation warnings
      Merge branch 'fix-shutdown-wr' into 'master'
      sbuf: remove unused and undefined sbcopy() path
      sbuf: check more strictly sbcopy() bounds with offset
      sbuf: replace a comment with a runtime warning
      Replace remaining malloc/free user with glib
      tcp_attach() can no longer fail
      state: can't ENOMEM
      sbuf: use unsigned types
      sbuf: simplify sbreserve()
      dnssearch: use g_strv_length()
      vmstate: silence scan-build warning
      gitlab-ci: run scan-build
      Merge branch 'mem-cleanups' into 'master'
      libslirp.map: bind slirp_new to SLIRP_4.1 version
      meson: fix libtool versioning
      Release v4.1.0
      Merge branch '4.1.0' into 'master'
      CHANGELOG: start unreleased section
      Merge branch 'add-unix' into 'master'
      util: add G_SIZEOF_MEMBER() macro
      Check bootp_filename is not going to be truncated
      bootp: remove extra cast
      bootp: replace simple snprintf() with strcpy()
      tftp: clarify what is actually OACK m_len
      tcp_emu: add more fixme/warnings comments
      util: add slirp_fmt() helpers
      dhcpv6: use slirp_fmt()
      misc: use slirp_fmt0()
      tftp: use slirp_fmt0()
      tcp_ctl: use slirp_fmt()
      tcp_emu: fix unsafe snprintf() usages
      misc: improve error report
      Use g_snprintf()
      util: add gnuc format function attribute to slirp_fmt*
      Merge branch 'aw-guestfwd-state' into 'master'
      Merge branch 'slirp-fmt' into 'master'
      socket: remove extra label and variable
      socket: factor out sotranslate ipv4/ipv6 handling
      socket: remove need for extra scope_id variable
      socket: do not fallback on host loopback if get_dns_addr() failed
      socket: do not fallback on loopback addr for addresses in our mask/pr=
efix
      Prepare for v4.2.0 release
      Merge branch 'translate-fix' into 'master'
      Merge branch 'release-v4.2.0' into 'master'
      changelog: post-release
      changelog: fix link
      .gitlab-ci: add --werror, treat CI build warnings as errors
      Revert "socket: remove need for extra scope_id variable"
      Merge branch 'mingw-fix' into 'master'

PanNengyuan (1):
      libslirp: fix NULL pointer dereference in tcp_sockclosed

Philippe Mathieu-Daud=C3=A9 (1):
      Add a git-publish configuration file

Prasad J Pandit (4):
      slirp: ncsi: compute checksum for valid data length
      slirp: use correct size while emulating IRC commands
      slirp: use correct size while emulating commands
      slirp: tftp: restrict relative path access

Renzo Davoli (2):
      Add slirp_remove_guestfwd()
      Add slirp_add_unix()

Samuel Thibault (14):
      ip_reass: explain why we should not always update the q pointer
      Merge branch 'comment' into 'master'
      Merge branch 'no-emu' into 'master'
      Fix bogus indent, no source change
      ip_reass: Fix use after free
      Merge branch 'reass2' into 'master'
      Make host receive broadcast packets
      arp: Allow 0.0.0.0 destination address
      Merge branch 'warnings' into 'master'
      Merge branch 'arp_0' into 'master'
      Merge branch 'broadcast' into 'master'
      tcp_emu: Fix oob access
      Merge branch 'oob' into 'master'
      Merge branch 'master' into 'master'

Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 126c04acba..7012a2c62e 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
+Subproject commit 7012a2c62e5b54eab88c119383022ec7ce86e9b2
--=20
2.25.0.rc2.1.g09a9a1a997


