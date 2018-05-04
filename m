Received: from eggs.gnu.org ([2001:4830:134:3::10]:55334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEd8O-0003VY-7T
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEd8M-0001yh-MW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEd8M-0001y1-40
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:34 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  4 May 2018 17:00:24 +0100
Message-Id: <20180504160026.14017-2-berrange@redhat.com>
In-Reply-To: <20180504160026.14017-1-berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] qemu-doc: provide details of supported
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Describe the policy the project uses to decide which OS are supported as
build platforms. This will:

  - Allow maintainers to determine when the minimum version of a 3rd
    party piece of software can be increased without negatively
    impacting supported platforms.

  - Allow tailoring of CI environments to match the intended supported
    build platforms.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qemu-doc.texi | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 68 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5813d27615..d44b778764 100644
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
@@ -2976,6 +2977,73 @@ The ``xlnx-zcu102'' machine has the same features =
and capabilites in QEMU.
 In order to prevent QEMU from automatically opening an image's backing
 chain, use ``"backing": null'' instead.
=20
+@node Supported build platforms
+@appendix Supported build platforms
+
+QEMU aims to support building and executing on multiple host OS platform=
s.
+This appendix outlines which platforms are the major build targets. Thes=
e
+platforms are used as the basis for deciding upon the minimum required
+versions of 3rd party software QEMU depends on. The supported platforms
+are the targets for automated testing performed by the project when patc=
hes
+are submitted for review, and tested before and after merge.
+
+If a platform is not listed here, it does not imply that QEMU won't work=
.
+If an unlisted platform has comparable software versions to a listed pla=
tform,
+there is every expectation that it will work. Bug reports are welcome fo=
r
+problems encountered on unlisted platforms unless they are clearly older
+vintage than what is described here.
+
+Note that when considering software versions shipped in distros as suppo=
rt
+targets, QEMU considers only the version number, and assumes the feature=
s in
+that distro match the upstream release with the same version. In other w=
ords,
+if a distro backports extra features to the software in their distro, QE=
MU
+upstream code will not add explicit support for those backports, unless =
the
+feature is auto-detectable in a manner that works for the upstream relea=
ses
+too.
+
+The Repology site @url{https://repology.org} is a useful resource to ide=
ntify
+currently shipped versions of software in various operating systems, tho=
ugh
+it does not cover all distros listed below.
+
+@section Linux OS
+
+For distributions with frequent, short-lifetime releases, the project wi=
ll
+aim to support all versions that are not end of life by their respective
+vendors. For the purposes of identifying supported software versions, th=
e
+project will look at Fedora, Ubuntu, and openSUSE distros. Other short-
+lifetime distros will be assumed to ship similar software versions.
+
+For distributions with long-lifetime releases, the project will aim to s=
upport
+the most recent major version at all times. Support for the previous maj=
or
+version will be dropped 2 years after the new major version is released.=
 For
+the purposes of identifying supported software versions, the project wil=
l look
+at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distr=
os will
+be assumed to ship similar software versions.
+
+@section Windows
+
+The project supports building with current versions of the MinGW toolcha=
in,
+hosted on Linux.
+
+@section macOS
+
+The project supports building with the two most recent versions of macOS=
, with
+the current homebrew package set available.
+
+@section FreeBSD
+
+The project aims to support the all the versions which are not end of li=
fe.
+
+@section NetBSD
+
+The project aims to support the most recent major version at all times. =
Support
+for the previous major version will be dropped 2 years after the new maj=
or
+version is released.
+
+@section OpenBSD
+
+The project aims to support the all the versions which are not end of li=
fe.
+
 @node License
 @appendix License
=20
--=20
2.14.3
