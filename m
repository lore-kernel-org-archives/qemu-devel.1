Received: from eggs.gnu.org ([2001:4830:134:3::10]:45507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXlMf-00037V-PG
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXlMc-0005HU-Az
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:10:41 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXlMc-0005Gr-0K
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:10:38 -0500
Received: by mail-wr1-x42e.google.com with SMTP id q18so5022031wrx.9
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 03:10:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 11:10:32 +0000
Message-Id: <20181214111032.2084-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a QEMU specific version of a gitdm config for generating
reports on the contributor base of the project. I've added enough
group maps and domain aliases to ensure the current top ten is as
reflective as it can be. As of this commit running:

  git log --numstat --since "Last Year" | gitdm -n -l 10

Reports:

  Top changeset contributors by employer
  Red Hat                   3172 (44.3%)
  Linaro                    1153 (16.1%)
  (None)                     549 (7.7%)
  IBM                        348 (4.9%)
  Academics (various)        170 (2.4%)
  Virtuozzo                  168 (2.3%)
  Wave Computing             118 (1.6%)
  Xilinx                     102 (1.4%)
  Igalia                      93 (1.3%)
  Cadence Design Systems      88 (1.2%)

  Top lines changed by employer
  Red Hat                   144092 (28.1%)
  Cadence Design Systems    126554 (24.6%)
  Linaro                    77480 (15.1%)
  Wave Computing            33134 (6.5%)
  SiFive                    14392 (2.8%)
  IBM                       12219 (2.4%)
  (None)                    11948 (2.3%)
  Academics (various)       10447 (2.0%)
  Virtuozzo                 10445 (2.0%)
  CodeWeavers               9179 (1.8%)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

---
v2
  - use aliases instead of .mailmap
  - add more companies to domainmap
  - add more groups to cover non-corporate email
  - add an individuals group-map for (None)
  - limit the stats to top ten
v3
  - updates to wavecomp group
  - grouped ispras & others under academics
  - tweaked invocation
  - added tags
  - updated stats while based of master
  - slimmed down filetypes, added QEMU specific patterns
---
 contrib/gitdm/aliases               |  27 +++++
 contrib/gitdm/domain-map            |  19 ++++
 contrib/gitdm/filetypes.txt         | 146 ++++++++++++++++++++++++++++
 contrib/gitdm/group-map-cadence     |   3 +
 contrib/gitdm/group-map-codeweavers |   1 +
 contrib/gitdm/group-map-ibm         |   6 ++
 contrib/gitdm/group-map-redhat      |   7 ++
 contrib/gitdm/group-map-wavecomp    |  18 ++++
 gitdm.config                        |  50 ++++++++++
 9 files changed, 277 insertions(+)
 create mode 100644 contrib/gitdm/aliases
 create mode 100644 contrib/gitdm/domain-map
 create mode 100644 contrib/gitdm/filetypes.txt
 create mode 100644 contrib/gitdm/group-map-cadence
 create mode 100644 contrib/gitdm/group-map-codeweavers
 create mode 100644 contrib/gitdm/group-map-ibm
 create mode 100644 contrib/gitdm/group-map-redhat
 create mode 100644 contrib/gitdm/group-map-wavecomp
 create mode 100644 gitdm.config

diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
new file mode 100644
index 0000000000..07fd3391a5
--- /dev/null
+++ b/contrib/gitdm/aliases
@@ -0,0 +1,27 @@
+#
+# This is the email aliases file, mapping secondary addresses
+# onto a single, canonical address. Duplicates some info from .mailmap
+#
+
+# weird commits
+balrog@c046a42c-6fe2-441c-8c8c-71466251a162 balrogg@gmail.com
+aliguori@c046a42c-6fe2-441c-8c8c-71466251a162 anthony@codemonkey.ws
+aurel32@c046a42c-6fe2-441c-8c8c-71466251a162 aurelien@aurel32.net
+blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162 blauwirbel@gmail.com
+edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162 edgar.iglesias@gmail.com
+bellard@c046a42c-6fe2-441c-8c8c-71466251a162 fabrice@bellard.org
+j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162 l_indien@magic.fr
+pbrook@c046a42c-6fe2-441c-8c8c-71466251a162 paul@codesourcery.com
+ths@c046a42c-6fe2-441c-8c8c-71466251a162 ths@networkno.de
+malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru
+
+# There is also a:
+#    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
+# for the cvs2svn initialization commit e63c3dc74bf.
+
+# Next, translate a few commits where mailman rewrote the From: line due
+# to strict SPF, although we prefer to avoid adding more entries like that.
+"Ed Swierk via Qemu-devel" eswierk@skyportsystems.com
+"Ian McKellar via Qemu-devel" ianloic@google.com
+"Julia Suvorova via Qemu-devel" jusual@mail.ru
+"Justin Terry (VM) via Qemu-devel" juterry@microsoft.com
diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
new file mode 100644
index 0000000000..8cbbcfe93d
--- /dev/null
+++ b/contrib/gitdm/domain-map
@@ -0,0 +1,19 @@
+#
+# QEMU gitdm domain-map
+#
+# This maps email domains to nice easy to read company names
+#
+
+amd.com         AMD
+greensocs.com   GreenSocs
+ibm.com         IBM
+igalia.com      Igalia
+linaro.org      Linaro
+oracle.com      Oracle
+redhat.com      Red Hat
+siemens.com     Siemens
+sifive.com      SiFive
+suse.de         SUSE
+virtuozzo.com   Virtuozzo
+wdc.com         Western Digital
+xilinx.com      Xilinx
diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
new file mode 100644
index 0000000000..15d6f803b9
--- /dev/null
+++ b/contrib/gitdm/filetypes.txt
@@ -0,0 +1,146 @@
+# -*- coding:utf-8 -*-
+# Copyright (C)  2006 Libresoft
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option  any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU Library General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+#
+# Authors : Gregorio Robles <grex@gsyc.escet.urjc.es>
+# Authors : Germán Póo-Caamaño <gpoo@gnome.org>
+#
+# This QEMU version is a cut-down version of what originally shipped
+# in the gitdm sample-config directory.
+#
+# This file contains associations parameters regarding filetypes
+# (documentation, develompent, multimedia, images...)
+#
+# format:
+# filetype <type> <regex> [<comment>]
+#
+# Order:
+#   The list should keep an order, so filetypes can be counted properly.
+#   ie. we want ltmain.sh -> 'build' instead of 'code'.
+#
+#   If there is an filetype which is not in order but has values, it will
+#   be added at the end.
+#
+order build,tests,code,documentation,devel-doc,blobs
+
+#
+#
+# Code files (headers and the like included
+# (most common languages first
+#
+filetype code \.c$	# C
+filetype code \.inc.c$	# C
+filetype code \.C$	# C++
+filetype code \.cpp$	# C++
+filetype code \.c\+\+$	# C++
+filetype code \.cxx$	# C++
+filetype code \.cc$	# C++
+filetype code \.h$	# C or C++ header
+filetype code \.hh$	# C++ header
+filetype code \.hpp$	# C++ header
+filetype code \.hxx$	# C++ header
+filetype code \.sh$	# Shell
+filetype code \.pl$	# Perl
+filetype code \.py$	# Python
+filetype code \.s$	# Assembly
+filetype code \.S$	# Assembly
+filetype code \.asm$	# Assembly
+filetype code \.awk$	# awk
+filetype code ^common$  # script fragements
+filetype code ^common.*$  # script fragements
+filetype code (qom|qmp)-\w+$  # python script fragments
+
+#
+# Interface/api files
+#
+filetype interface \.json$   # json
+filetype interface \.hx$     # documented options
+
+#
+# Test related blobs (unfortunately we can't filter out test code)
+#
+filetype tests \.hex$
+filetype tests \d{2,3}$     # test data 00-999
+filetype tests ^[A-Z]{4}$   # ACPI test data
+filetype tests ^[A-Z]{4}\.*$   # ACPI test data
+filetype tests \.out$
+filetype tests \.out\.nocache$
+filetype tests \.err$
+filetype tests \.exit$      # bad-if-FOO.exit etc
+filetype tests \.decode$
+filetype tests \.yml$        # travis/shippable config
+
+#
+# Development documentation files (for hacking generally)
+#
+filetype devel-doc ^readme.*$
+filetype devel-doc ^changelog.*
+filetype devel-doc ^hacking.*$
+filetype devel-doc ^licen(s|c)e.*$
+filetype devel-doc ^copying.*$
+filetype devel-doc ^MAINTAINERS$
+filetype devel-doc ^BSD-2-Clause$
+filetype devel-doc ^BSD-3-Clause$
+filetype devel-doc ^GPL-2.0$
+filetype devel-doc \.txt$
+filetype devel-doc \.rst$
+filetype devel-doc \.texi$
+filetype devel-doc \.pod$
+
+#
+# Building, compiling, and configuration admin files
+#
+filetype build configure.*$
+filetype build Makefile$
+filetype build Makefile\.*$
+filetype build config$
+filetype build conf$
+filetype build \.cfg$
+filetype build \.mk$
+filetype build \.mak$
+filetype build \.docker$
+filetype build \.pre$
+filetype build ^.gitignore$
+filetype build ^.gitmodules$
+filetype build ^.gitpublish$
+filetype build ^.mailmap$
+filetype build ^.dir-locals.el$
+filetype build ^.editorconfig$
+filetype build ^.exrc$
+filetype build ^.gdbinit$
+filetype build \.cocci$         # Coccinelle semantic patches
+
+#
+# Misc blobs
+#
+filetype blobs \.bin$
+filetype blobs \.dtb$
+filetype blobs \.dts$
+filetype blobs \.rom$
+filetype blobs \.img$
+filetype blobs \.ndrv$
+filetype blobs \.bmp$
+filetype blobs \.svg$
+filetype blobs ^pi_10.com$
+
+
+#
+# Documentation files
+#
+filetype documentation \.html$
+filetype documentation \.txt$
+filetype documentation \.texi$
+filetype documentation \.po$            # translation files
diff --git a/contrib/gitdm/group-map-cadence b/contrib/gitdm/group-map-cadence
new file mode 100644
index 0000000000..ab97dd2fc3
--- /dev/null
+++ b/contrib/gitdm/group-map-cadence
@@ -0,0 +1,3 @@
+# Cadence Design Systems
+
+jcmvbkbc@gmail.com
diff --git a/contrib/gitdm/group-map-codeweavers b/contrib/gitdm/group-map-codeweavers
new file mode 100644
index 0000000000..c4803489e2
--- /dev/null
+++ b/contrib/gitdm/group-map-codeweavers
@@ -0,0 +1 @@
+sergio.g.delreal@gmail.com
diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
new file mode 100644
index 0000000000..b66db5f4a8
--- /dev/null
+++ b/contrib/gitdm/group-map-ibm
@@ -0,0 +1,6 @@
+#
+# Some IBM contributors submit via another domain
+#
+
+clg@kaod.org
+groug@kaod.org
diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
new file mode 100644
index 0000000000..6d05c6b54f
--- /dev/null
+++ b/contrib/gitdm/group-map-redhat
@@ -0,0 +1,7 @@
+#
+# Red Hat contributors using non-corporate email
+#
+
+david@gibson.dropbear.id.au
+laurent@vivier.eu
+pjp@fedoraproject.org
diff --git a/contrib/gitdm/group-map-wavecomp b/contrib/gitdm/group-map-wavecomp
new file mode 100644
index 0000000000..c571a52c65
--- /dev/null
+++ b/contrib/gitdm/group-map-wavecomp
@@ -0,0 +1,18 @@
+#
+# Wave Computing acquired MIPS in June 2018. Also, from February 2013
+# to October 2017, MIPS was owned by Imagination Technologies.
+#
+
+aleksandar.markovic@imgtec.com
+aleksandar.markovic@mips.com
+amarkovic@wavecomp.com
+arikalo@wavecomp.com
+dnikolic@wavecomp.com
+james.hogan@mips.com
+matthew.fortune@mips.com
+paul.burton@imgtec.com
+pburton@wavecomp.com
+smarkovic@wavecomp.com
+yongbok.kim@imgtec.com
+yongbok.kim@mips.com
+ysu@wavecomp.com
diff --git a/gitdm.config b/gitdm.config
new file mode 100644
index 0000000000..7472d4b8be
--- /dev/null
+++ b/gitdm.config
@@ -0,0 +1,50 @@
+#
+# This is the gitdm configuration file for QEMU.
+#
+# It is to be used with LWN's git dataminer tool for generating
+# reports about development activity in the QEMU repo. The LWN gitdm
+# tool can be found at:
+#
+#   git://git.lwn.net/gitdm.git
+#
+# A run to generate a report for the last year of activity would be
+#
+#   git log --numstat --since "Last Year" | gitdm -n -l 10
+#
+
+# EmailAliases lets us cope with developers who use more
+# than one address or have changed addresses. This duplicates some of
+# the information in the existing .mailmap but in a slightly different
+# form.
+#
+EmailAliases contrib/gitdm/aliases
+
+#
+# EmailMap does the main work of mapping addresses onto
+# employers.
+#
+EmailMap contrib/gitdm/domain-map
+
+#
+# Use GroupMap to map a file full of addresses to the
+# same employer. This is used for people that don't post from easily
+# identifiable corporate emails.
+#
+
+GroupMap contrib/gitdm/group-map-redhat Red Hat
+GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
+GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
+GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
+GroupMap contrib/gitdm/group-map-ibm IBM
+
+# Also group together our prolific individual contributors
+# and those working under academic auspices
+GroupMap contrib/gitdm/group-map-individuals (None)
+GroupMap contrib/gitdm/group-map-academics Academics (various)
+
+#
+#
+# Use FileTypeMap to map a file types to file names using regular
+# regular expressions.
+#
+FileTypeMap contrib/gitdm/filetypes.txt
-- 
2.17.1
