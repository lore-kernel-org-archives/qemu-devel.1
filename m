Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89522C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1523220724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM+nO2Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1523220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJwn-0004a5-1h
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jFJvi-0003S5-8Y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jFJvg-0000xn-UD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:51:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jFJvd-0000wj-7B
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584719480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9jEYFzZyU5mkTXeI/TPzEERTY1+3h8adet6+ZVKksk=;
 b=MM+nO2VmoY4hDo9IQajpWmCeOtnqajp3gLxypKsOAZSxdwooPUv2K3SNwq9uITHIjoeu3F
 JJwLK3S2wYn8Mab7b1PYergi+UnCgbRg6ehqVzSOPwF+1lqbaDdJhiceQSQej+M/hc3+04
 IHegiqFRnuybiq7kI4lKesaqg+FKYw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-QsquwZ6-Mp2e6cZjY9PYeQ-1; Fri, 20 Mar 2020 11:51:19 -0400
X-MC-Unique: QsquwZ6-Mp2e6cZjY9PYeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240D88017CC;
 Fri, 20 Mar 2020 15:51:18 +0000 (UTC)
Received: from localhost (unknown [10.36.110.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFA695DA75;
 Fri, 20 Mar 2020 15:51:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/1] slirp: update submodule to v4.2.0+
Date: Fri, 20 Mar 2020 16:51:06 +0100
Message-Id: <20200320155106.549514-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200320155106.549514-1-marcandre.lureau@redhat.com>
References: <20200320155106.549514-1-marcandre.lureau@redhat.com>
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 samuel.thibault@ens-lyon.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

git shortlog
126c04acbabd7ad32c2b018fe10dfac2a3bc1210..99e9d4d9e6695d2f41b178d6ae03aaba8=
42fb562

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

Marc-Andr=C3=A9 Lureau (59):
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
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 126c04acba..99e9d4d9e6 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
+Subproject commit 99e9d4d9e6695d2f41b178d6ae03aaba842fb562
--=20
2.25.0.rc2.1.g09a9a1a997


