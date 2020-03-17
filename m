Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31ACC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93ADF20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/t6AYbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ADF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGq2-0007od-PH
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jEGir-0007Ll-1o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jEGio-0007wy-F4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:13:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jEGio-0007q0-8g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584468824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qUeb7eVKHzR6huGHguldQ1yMjr8M76rwgzBlTAgtsa4=;
 b=i/t6AYbzNRRGGBfPKXgJtVkl/Ap45U8ZB0L4l1OCI+1QXCkER25XUNXUT28IsJEBwAZavB
 1JyBF3DdIc3clXzWMhnQmPRZCJrEvTAiEpO0D7mUh8HaDcqi8rRzaGypPb53Bn7AsiG+Tk
 EM1Y7vURvVknKlexOy1k5WvFf/aRlUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-A7OtpTZ2Poy8ZUU5-bX7Yg-1; Tue, 17 Mar 2020 14:13:42 -0400
X-MC-Unique: A7OtpTZ2Poy8ZUU5-bX7Yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8D5800D55;
 Tue, 17 Mar 2020 18:13:41 +0000 (UTC)
Received: from localhost (unknown [10.36.110.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39F2148;
 Tue, 17 Mar 2020 18:13:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] slirp: update submodule to v4.2.0 + mingw-fix
Date: Tue, 17 Mar 2020 19:13:36 +0100
Message-Id: <20200317181336.2730307-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
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


