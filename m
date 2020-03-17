Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB19C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753E9205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbIemPa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753E9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECkK-0003aR-K0
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jECjU-0002Rp-E0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jECjS-0001qJ-Vd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:58:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jECjS-0001ip-Qk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584453490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YdHEdVRYP9CD6PWvGjL6Gbim9SHcDv5lA4DA3lptc2Q=;
 b=JbIemPa+hxaaGsw8GCZ1PLSVoutuST0xVCy7ZKg2ZR5mgkWUO1V5asVrf62RS9RIwhFhp6
 IU2M4rsf/5zSQFFm5B2Hfq9JNPACEv7Ka1c2FYadF5hB00eO8kY6ataigulbHWFpMLMxDX
 Us3eW37+FApQbJrvNYO7hN1mJI+zIx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-1oFp1njEN7aGrpDJks3qPQ-1; Tue, 17 Mar 2020 09:58:08 -0400
X-MC-Unique: 1oFp1njEN7aGrpDJks3qPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE8C718A6EC6;
 Tue, 17 Mar 2020 13:58:07 +0000 (UTC)
Received: from localhost (unknown [10.36.110.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 709FA5D9E2;
 Tue, 17 Mar 2020 13:58:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] slirp: update submodule to v4.2.0
Date: Tue, 17 Mar 2020 14:58:03 +0100
Message-Id: <20200317135803.2682384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 samuel.thibault@ens-lyon.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

git shortlog
126c04acbabd7ad32c2b018fe10dfac2a3bc1210..daba14c3416fa9641ab4453a9a11e7f8b=
de08875

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

Marc-Andr=C3=A9 Lureau (49):
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

Cc: samuel.thibault@ens-lyon.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 126c04acba..daba14c341 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
+Subproject commit daba14c3416fa9641ab4453a9a11e7f8bde08875
--=20
2.25.0.rc2.1.g09a9a1a997


