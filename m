Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F8C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B41220724
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBW5LoPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B41220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG4FT-0006HZ-I6
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 13:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jG4DX-0004yu-E7
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jG4DV-0003sv-VO
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:16:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29399)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jG4DV-0003rv-Qr
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584897408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGOQfpfFT0FqRWvbg2/qxNsvPKqij9Sxd1zqW3dmMco=;
 b=TBW5LoPrCwRMGFXmj5KjF4rSyWCvv/jaYDtA26pXYGlMWYucNCFd8pwlpzEpTBWh40Z7ne
 sSsWicOdMzUyCcPi8e4OsrI1Y6BpfAgOcsDeGF7ttf+eSwGKF74IGUw1kejiNiMLjQnvQF
 rnOp6hL3NcpWOpazPu7eBgru8kR1Olk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-YifXzGCIMO6VzEX3Ng8JzQ-1; Sun, 22 Mar 2020 13:16:46 -0400
X-MC-Unique: YifXzGCIMO6VzEX3Ng8JzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C146E8017CC;
 Sun, 22 Mar 2020 17:16:45 +0000 (UTC)
Received: from localhost (unknown [10.36.110.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6244F5C1B5;
 Sun, 22 Mar 2020 17:16:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 1/1] slirp: update submodule to v4.2.0+
Date: Sun, 22 Mar 2020 18:16:35 +0100
Message-Id: <20200322171635.678219-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200322171635.678219-1-marcandre.lureau@redhat.com>
References: <20200322171635.678219-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 samuel.thibault@ens-lyon.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

git shortlog
126c04acbabd7ad32c2b018fe10dfac2a3bc1210..55ab21c9a36852915b81f1b41ebaf3b65=
09dd8ba

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

Marc-Andr=C3=A9 Lureau (60):
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
      Teach slirp_version_string() to return vcs version
      Merge branch 'mingw-fix' into 'master'
      Merge branch 'vcs-version' into 'master'
      meson: bump required version to 0.49
      build-sys: fix NetBSD build regression
      Merge branch 'netbsd-fix' into 'master'
      build-sys: make libslirp-version.h depend on Makefile

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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 126c04acba..55ab21c9a3 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
+Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba
--=20
2.25.0.rc2.1.g09a9a1a997


