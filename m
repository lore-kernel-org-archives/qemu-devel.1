Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18296C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D890F2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D890F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAMd-0000B3-19
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6u-00012U-EC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6p-0005I6-5X
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-dpUONCv-NUGXbyeZwtB73A-1; Fri, 04 Sep 2020 07:42:20 -0400
X-MC-Unique: dpUONCv-NUGXbyeZwtB73A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA7261935146
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:44 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87A517B064
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/46] configure: do not look for install(1)
Date: Fri,  4 Sep 2020 07:41:12 -0400
Message-Id: <20200904114122.31307-37-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not used anymore, so there is no Solaris-specific check to
perform.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   | 53 ++-----------------------------------
 docs/devel/build-system.rst |  4 ---
 meson.build                 |  1 -
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/configure b/configure
index 59453ade2f..ca9a6eca93 100755
--- a/configure
+++ b/configure
@@ -174,36 +174,6 @@ has() {
     type "$1" >/dev/null 2>&1
 }
 
-# search for an executable in PATH
-path_of() {
-    local_command="$1"
-    local_ifs="$IFS"
-    local_dir=""
-
-    # pathname has a dir component?
-    if [ "${local_command#*/}" != "$local_command" ]; then
-        if [ -x "$local_command" ] && [ ! -d "$local_command" ]; then
-            echo "$local_command"
-            return 0
-        fi
-    fi
-    if [ -z "$local_command" ]; then
-        return 1
-    fi
-
-    IFS=:
-    for local_dir in $PATH; do
-        if [ -x "$local_dir/$local_command" ] && [ ! -d "$local_dir/$local_command" ]; then
-            echo "$local_dir/$local_command"
-            IFS="${local_ifs:-$(printf ' \t\n')}"
-            return 0
-        fi
-    done
-    # not found
-    IFS="${local_ifs:-$(printf ' \t\n')}"
-    return 1
-}
-
 version_ge () {
     local_ver1=`echo $1 | tr . ' '`
     local_ver2=`echo $2 | tr . ' '`
@@ -893,7 +863,6 @@ Darwin)
 SunOS)
   solaris="yes"
   make="${MAKE-gmake}"
-  install="${INSTALL-ginstall}"
   smbd="${SMBD-/usr/sfw/sbin/smbd}"
   if test -f /usr/include/sys/soundcard.h ; then
     audio_drv_list="oss try-sdl"
@@ -929,7 +898,7 @@ if [ "$bsd" = "yes" ] ; then
 fi
 
 : ${make=${MAKE-make}}
-: ${install=${INSTALL-install}}
+
 # We prefer python 3.x. A bare 'python' is traditionally
 # python 2.x, but some distros have it as python 3.x, so
 # we check that too
@@ -1016,7 +985,7 @@ for opt do
   ;;
   --make=*) make="$optarg"
   ;;
-  --install=*) install="$optarg"
+  --install=*)
   ;;
   --python=*) python="$optarg" ; explicit_python=yes
   ;;
@@ -1797,7 +1766,6 @@ Advanced options (experts only):
   --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
   --cross-cc-flags-ARCH=   use compiler flags when building ARCH guest tests
   --make=MAKE              use specified make [$make]
-  --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
   --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
   --meson=MESON            use specified meson [$meson]
@@ -2315,18 +2283,6 @@ fi
 # Solaris specific configure tool chain decisions
 
 if test "$solaris" = "yes" ; then
-  if has $install; then
-    :
-  else
-    error_exit "Solaris install program not found. Use --install=/usr/ucb/install or" \
-        "install fileutils from www.blastwave.org using pkg-get -i fileutils" \
-        "to get ginstall which is used by default (which lives in /opt/csw/bin)"
-  fi
-  if test "$(path_of $install)" = "/usr/sbin/install" ; then
-    error_exit "Solaris /usr/sbin/install is not an appropriate install program." \
-        "try ginstall from the GNU fileutils available from www.blastwave.org" \
-        "using pkg-get -i fileutils, or use --install=/usr/ucb/install"
-  fi
   if has ar; then
     :
   else
@@ -7431,11 +7387,6 @@ fi
 
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
-echo "INSTALL=$install" >> $config_host_mak
-echo "INSTALL_DIR=$install -d -m 0755" >> $config_host_mak
-echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
-echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
-echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 55f0576c07..28492cfcae 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -136,10 +136,6 @@ developers in checking for system features:
    Determine if $COMMAND exists in the current environment, either as a
    shell builtin, or executable binary, returning 0 on success.
 
-`path_of $COMMAND`
-   Return the fully qualified path of $COMMAND, printing it to stdout,
-   and returning 0 on success.
-
 `check_define $NAME`
    Determine if the macro $NAME is defined by the system C compiler
 
diff --git a/meson.build b/meson.build
index 532babff33..e62b304480 100644
--- a/meson.build
+++ b/meson.build
@@ -1357,7 +1357,6 @@ summary_info += {'CFLAGS':            config_host['CFLAGS']}
 summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
-summary_info += {'install':           config_host['INSTALL']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      config_host['SPHINX_BUILD']}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
-- 
2.26.2



