Received: from eggs.gnu.org ([2001:4830:134:3::10]:41487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtC-0003DX-SQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtB-0001YH-CD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:18 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtB-0001XV-1k
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:17 -0400
Received: by mail-wm0-x22b.google.com with SMTP id a67so21143770wmf.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:39 +0200
Message-Id: <1525817687-34620-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/30] qemu-doc: provide details of supported
 build platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Describe the policy the project uses to decide which OS are supported as
build platforms. This will:

  - Allow maintainers to determine when the minimum version of a 3rd
    party piece of software can be increased without negatively
    impacting supported platforms.

  - Allow tailoring of CI environments to match the intended supported
    build platforms.

Signed-off-by: Daniel P. BerrangÃ© <berrange@redhat.com>
Message-Id: <20180504160026.14017-2-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-doc.texi | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index bde542b..715bd33 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -39,6 +39,7 @@
 * QEMU User space emulator::
 * Implementation notes::
 * Deprecated features::
+* Supported build platforms::
 * License::
 * Index::
 @end menu
@@ -2976,6 +2977,73 @@ The ``xlnx-zcu102'' machine has the same features and capabilites in QEMU.
 In order to prevent QEMU from automatically opening an image's backing
 chain, use ``"backing": null'' instead.
 
+@node Supported build platforms
+@appendix Supported build platforms
+
+QEMU aims to support building and executing on multiple host OS platforms.
+This appendix outlines which platforms are the major build targets. These
+platforms are used as the basis for deciding upon the minimum required
+versions of 3rd party software QEMU depends on. The supported platforms
+are the targets for automated testing performed by the project when patches
+are submitted for review, and tested before and after merge.
+
+If a platform is not listed here, it does not imply that QEMU won't work.
+If an unlisted platform has comparable software versions to a listed platform,
+there is every expectation that it will work. Bug reports are welcome for
+problems encountered on unlisted platforms unless they are clearly older
+vintage than what is described here.
+
+Note that when considering software versions shipped in distros as support
+targets, QEMU considers only the version number, and assumes the features in
+that distro match the upstream release with the same version. In other words,
+if a distro backports extra features to the software in their distro, QEMU
+upstream code will not add explicit support for those backports, unless the
+feature is auto-detectable in a manner that works for the upstream releases
+too.
+
+The Repology site @url{https://repology.org} is a useful resource to identify
+currently shipped versions of software in various operating systems, though
+it does not cover all distros listed below.
+
+@section Linux OS
+
+For distributions with frequent, short-lifetime releases, the project will
+aim to support all versions that are not end of life by their respective
+vendors. For the purposes of identifying supported software versions, the
+project will look at Fedora, Ubuntu, and openSUSE distros. Other short-
+lifetime distros will be assumed to ship similar software versions.
+
+For distributions with long-lifetime releases, the project will aim to support
+the most recent major version at all times. Support for the previous major
+version will be dropped 2 years after the new major version is released. For
+the purposes of identifying supported software versions, the project will look
+at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros will
+be assumed to ship similar software versions.
+
+@section Windows
+
+The project supports building with current versions of the MinGW toolchain,
+hosted on Linux.
+
+@section macOS
+
+The project supports building with the two most recent versions of macOS, with
+the current homebrew package set available.
+
+@section FreeBSD
+
+The project aims to support the all the versions which are not end of life.
+
+@section NetBSD
+
+The project aims to support the most recent major version at all times. Support
+for the previous major version will be dropped 2 years after the new major
+version is released.
+
+@section OpenBSD
+
+The project aims to support the all the versions which are not end of life.
+
 @node License
 @appendix License
 
-- 
1.8.3.1
