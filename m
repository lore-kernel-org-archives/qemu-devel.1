Received: from eggs.gnu.org ([209.51.188.92]:39095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJFI1-00069k-Ib
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJFHz-0007cF-HR
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:38:09 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Apr 2019 12:37:43 +0200
Message-Id: <20190424103747.10173-3-thuth@redhat.com>
In-Reply-To: <20190424103747.10173-1-thuth@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a new
 "ci" group for CI pipelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Tests in this group are supposed to run in every possible QEMU configurat=
ion.
That means they should run with every QEMU binary (also non-x86), without
dependencies on an optional features, they must work at least with the qc=
ow2
image format and be able to run on all kind of host filesystems and users
(i.e. also as "nobody" or "root").

The initial list has been created as a subset of the "quick" group, where
I've disabled all tests that are failing with qemu-system-aarch64 or
qemu-system-tricore or in one of our CI pipelines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/group | 194 ++++++++++++++++++++-------------------
 1 file changed, 102 insertions(+), 92 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..2ed42dcc14 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -4,63 +4,73 @@
 # - do not start group names with a digit
 #
=20
+#
+# Some notes about the groups:
+# - Tests in the "quick" group should finish within some few seconds
+# - Tests in the "ci" group are suitable for running in CI systems. That
+#   means they should run with every QEMU binary (also non-x86), with
+#   every QEMU configuration (i.e. no dependency on an optional feature)=
,
+#   at least with the qcow2 image format and all kind of host filesystem=
s
+#   and users (i.e. also as "nobody" or "root").
+#
+
 #
 # test-group association ... one line per test
 #
-001 rw auto quick
-002 rw auto quick
+001 rw auto quick ci
+002 rw auto quick ci
 003 rw auto
-004 rw auto quick
-005 img auto quick
+004 rw auto quick ci
+005 img auto quick ci
 # 006 was removed, do not reuse
 007 snapshot auto
-008 rw auto quick
-009 rw auto quick
-010 rw auto quick
-011 rw auto quick
-012 auto quick
+008 rw auto quick ci
+009 rw auto quick ci
+010 rw auto quick ci
+011 rw auto quick ci
+012 auto quick ci
 013 rw auto
 014 rw auto
 015 rw snapshot auto
 # 016 was removed, do not reuse
-017 rw backing auto quick
-018 rw backing auto quick
-019 rw backing auto quick
-020 rw backing auto quick
-021 io auto quick
+017 rw backing auto quick ci
+018 rw backing auto quick ci
+019 rw backing auto quick ci
+020 rw backing auto quick ci
+021 io auto quick ci
 022 rw snapshot auto
 023 rw auto
-024 rw backing auto quick
-025 rw auto quick
+024 rw backing auto quick ci
+025 rw auto quick ci
 026 rw blkdbg auto
-027 rw auto quick
+027 rw auto quick ci
 028 rw backing auto quick
-029 rw auto quick
+029 rw auto quick ci
 030 rw auto backing
-031 rw auto quick
-032 rw auto quick
-033 rw auto quick
-034 rw auto backing quick
-035 rw auto quick
-036 rw auto quick
-037 rw auto backing quick
-038 rw auto backing quick
-039 rw auto quick
+031 rw auto quick ci
+032 rw auto quick ci
+033 rw auto quick ci
+034 rw auto backing quick ci
+035 rw auto quick ci
+036 rw auto quick ci
+037 rw auto backing quick ci
+038 rw auto backing quick ci
+039 rw auto quick ci
 040 rw auto
 041 rw auto backing
-042 rw auto quick
+042 rw auto quick ci
 043 rw auto backing
 044 rw auto
 045 rw auto quick
-046 rw auto aio quick
-047 rw auto quick
-048 img auto quick
+046 rw auto aio quick ci
+047 rw auto quick ci
+048 img auto quick ci
 049 rw auto
-050 rw auto backing quick
+050 rw auto backing quick ci
 051 rw auto
-052 rw auto backing quick
-053 rw auto quick
-054 rw auto quick
+052 rw auto backing quick ci
+053 rw auto quick ci
+054 rw auto quick ci
 055 rw auto
 056 rw auto backing
 057 rw auto
@@ -68,19 +78,19 @@
 059 rw auto quick
 060 rw auto quick
 061 rw auto
-062 rw auto quick
-063 rw auto quick
+062 rw auto quick ci
+063 rw auto quick ci
 064 rw auto quick
 065 rw auto quick
-066 rw auto quick
+066 rw auto quick ci
 067 rw auto quick
 068 rw auto quick
-069 rw auto quick
+069 rw auto quick ci
 070 rw auto quick
-071 rw auto quick
-072 rw auto quick
-073 rw auto quick
-074 rw auto quick
+071 rw auto quick ci
+072 rw auto quick ci
+073 rw auto quick ci
+074 rw auto quick ci
 075 rw auto quick
 076 auto
 077 rw auto quick
@@ -88,15 +98,15 @@
 079 rw auto
 080 rw auto
 081 rw auto quick
-082 rw auto quick
+082 rw auto quick ci
 083 rw auto
 084 img auto quick
 085 rw auto
-086 rw auto quick
+086 rw auto quick ci
 087 rw auto quick
 088 rw auto quick
-089 rw auto quick
-090 rw auto quick
+089 rw auto quick ci
+090 rw auto quick ci
 091 rw auto migration
 092 rw auto quick
 093 auto
@@ -104,29 +114,29 @@
 095 rw auto quick
 096 rw auto quick
 097 rw auto backing
-098 rw auto backing quick
-099 rw auto quick
+098 rw auto backing quick ci
+099 rw auto quick ci
 # 100 was removed, do not reuse
 101 rw auto quick
-102 rw auto quick
-103 rw auto quick
+102 rw auto quick ci
+103 rw auto quick ci
 104 rw auto
-105 rw auto quick
+105 rw auto quick ci
 106 rw auto quick
-107 rw auto quick
-108 rw auto quick
+107 rw auto quick ci
+108 rw auto quick ci
 109 rw auto
-110 rw auto backing quick
-111 rw auto quick
+110 rw auto backing quick ci
+111 rw auto quick ci
 112 rw auto
 113 rw auto quick
-114 rw auto quick
+114 rw auto quick ci
 115 rw auto
 116 rw auto quick
 117 rw auto
 118 rw auto
 119 rw auto quick
-120 rw auto quick
+120 rw auto quick ci
 121 rw auto
 122 rw auto
 123 rw auto quick
@@ -136,73 +146,73 @@
 127 rw auto backing quick
 128 rw auto quick
 129 rw auto quick
-130 rw auto quick
+130 rw auto quick ci
 131 rw auto quick
 132 rw auto quick
-133 auto quick
-134 rw auto quick
+133 auto quick ci
+134 rw auto quick ci
 135 rw auto
 136 rw auto
 137 rw auto
 138 rw auto quick
 139 rw auto quick
-140 rw auto quick
-141 rw auto quick
+140 rw auto quick ci
+141 rw auto quick ci
 142 auto
-143 auto quick
+143 auto quick ci
 144 rw auto quick
-145 auto quick
+145 auto quick ci
 146 auto quick
 147 auto
 148 rw auto quick
 149 rw auto sudo
-150 rw auto quick
+150 rw auto quick ci
 151 rw auto
 152 rw auto quick
 153 rw auto quick
-154 rw auto backing quick
+154 rw auto backing quick ci
 155 rw auto
-156 rw auto quick
+156 rw auto quick ci
 157 auto
-158 rw auto quick
-159 rw auto quick
+158 rw auto quick ci
+159 rw auto quick ci
 160 rw auto quick
-161 rw auto quick
+161 rw auto quick ci
 162 auto quick
 163 rw auto
 165 rw auto quick
 169 rw auto quick migration
-170 rw auto quick
+170 rw auto quick ci
 171 rw auto quick
 172 auto
 173 rw auto
 174 auto
 175 auto quick
 176 rw auto backing
-177 rw auto quick
+177 rw auto quick ci
 178 auto
-179 rw auto quick
+179 rw auto quick ci
 181 rw auto migration
 182 rw auto quick
 183 rw auto migration
-184 rw auto quick
+184 rw auto quick ci
 185 rw auto
 186 rw auto
 187 rw auto
 188 rw auto quick
 189 rw auto
-190 rw auto quick
+190 rw auto quick ci
 191 rw auto
 192 rw auto quick
 194 rw auto migration quick
-195 rw auto quick
+195 rw auto quick ci
 196 rw auto quick migration
-197 rw auto quick
+197 rw auto quick ci
 198 rw auto
 199 rw auto migration
 200 rw auto
 201 rw auto migration
-202 rw auto quick
+202 rw auto quick ci
 203 rw auto migration
 204 rw auto quick
 205 rw auto quick
@@ -215,25 +225,25 @@
 212 rw auto quick
 213 rw auto quick
 214 rw auto
-215 rw auto quick
-216 rw auto quick
-217 rw auto quick
-218 rw auto quick
+215 rw auto quick ci
+216 rw auto quick ci
+217 rw auto quick ci
+218 rw auto quick ci
 219 rw auto
 220 rw auto
 221 rw auto quick
 222 rw auto quick
 223 rw auto quick
-224 rw auto quick
+224 rw auto quick ci
 225 rw auto quick
-226 auto quick
+226 auto quick ci
 227 auto quick
-228 rw auto quick
-229 auto quick
+228 rw auto quick ci
+229 auto quick ci
 231 auto quick
 232 auto quick
-233 auto quick
-234 auto quick migration
+233 auto quick ci
+234 auto quick ci migration
 235 auto quick
 236 auto quick
 237 rw auto quick
@@ -242,9 +252,9 @@
 240 auto quick
 241 rw auto quick
 242 rw auto quick
-243 rw auto quick
-244 rw auto quick
+243 rw auto quick ci
+244 rw auto quick ci
 245 rw auto
 246 rw auto quick
-247 rw auto quick
+247 rw auto quick ci
 248 rw auto quick
--=20
2.21.0
