Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9fe-00070e-Vd
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9fD-0000cx-JH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gD9fC-0000Nq-5j
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:39 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 18 Oct 2018 15:52:03 +0100
Message-Id: <20181018145203.11336-5-berrange@redhat.com>
In-Reply-To: <20181018145203.11336-1-berrange@redhat.com>
References: <20181018145203.11336-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [web PATCH 4/4] Update pre-rendered content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 secnotice/2018/001.html   | 1043 ++++++++++++++++++++++++++++++++++++
 secnotice/2018/001.txt    |  210 ++++++++
 secnotice/2018/002.html   | 1044 ++++++++++++++++++++++++++++++++++++
 secnotice/2018/002.txt    |  206 ++++++++
 secnotice/2018/003.html   |  766 +++++++++++++++++++++++++++
 secnotice/2018/003.txt    |  160 ++++++
 secnotice/2018/004.html   | 1045 ++++++++++++++++++++++++++++++++++++
 secnotice/2018/004.txt    |  206 ++++++++
 secnotice/2018/005.html   |  952 +++++++++++++++++++++++++++++++++
 secnotice/2018/005.txt    |  191 +++++++
 secnotice/2018/006.html   | 1056 +++++++++++++++++++++++++++++++++++++
 secnotice/2018/006.txt    |  210 ++++++++
 secnotice/2018/007.html   |  820 ++++++++++++++++++++++++++++
 secnotice/2018/007.txt    |  169 ++++++
 secnotice/2018/008.html   |  952 +++++++++++++++++++++++++++++++++
 secnotice/2018/008.txt    |  191 +++++++
 secnotice/2018/009.html   |  952 +++++++++++++++++++++++++++++++++
 secnotice/2018/009.txt    |  192 +++++++
 secnotice/2018/010.html   |  940 +++++++++++++++++++++++++++++++++
 secnotice/2018/010.txt    |  188 +++++++
 secnotice/2018/011.html   |  823 +++++++++++++++++++++++++++++
 secnotice/2018/011.txt    |  169 ++++++
 secnotice/2018/index.html |   46 ++
 secnotice/2018/index.xml  |   13 +
 secnotice/index.html      |   46 ++
 secnotice/index.xml       |   13 +
 26 files changed, 12603 insertions(+)
 create mode 100644 secnotice/2018/001.html
 create mode 100644 secnotice/2018/001.txt
 create mode 100644 secnotice/2018/002.html
 create mode 100644 secnotice/2018/002.txt
 create mode 100644 secnotice/2018/003.html
 create mode 100644 secnotice/2018/003.txt
 create mode 100644 secnotice/2018/004.html
 create mode 100644 secnotice/2018/004.txt
 create mode 100644 secnotice/2018/005.html
 create mode 100644 secnotice/2018/005.txt
 create mode 100644 secnotice/2018/006.html
 create mode 100644 secnotice/2018/006.txt
 create mode 100644 secnotice/2018/007.html
 create mode 100644 secnotice/2018/007.txt
 create mode 100644 secnotice/2018/008.html
 create mode 100644 secnotice/2018/008.txt
 create mode 100644 secnotice/2018/009.html
 create mode 100644 secnotice/2018/009.txt
 create mode 100644 secnotice/2018/010.html
 create mode 100644 secnotice/2018/010.txt
 create mode 100644 secnotice/2018/011.html
 create mode 100644 secnotice/2018/011.txt
 create mode 100644 secnotice/2018/index.html
 create mode 100644 secnotice/2018/index.xml
 create mode 100644 secnotice/index.html
 create mode 100644 secnotice/index.xml

diff --git a/secnotice/2018/001.html b/secnotice/2018/001.html
new file mode 100644
index 0000000..5395079
--- /dev/null
+++ b/secnotice/2018/001.html
@@ -0,0 +1,1043 @@
+---
+title: 'QSN-2018-001: Speculative store bypass'
+layout: secnotice
+permalink: /secnotice/2018/001
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>Speculative store bypass</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180312</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180521</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td>20180626</td>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:">Ken Johnson (Microsoft Security Response C=
enter)</a>
+        </td>
+      </tr>
+      <tr>
+        <th/>
+        <td>
+          <a href=3D"mailto:">Jann Horn (Google Project Zero)</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:berrange@redhat.com">Daniel P. Berrang=C3=A9=
</a>
+        </td>
+      </tr>
+      <tr>
+        <th/>
+        <td>
+          <a href=3D"mailto:konrad.wilk@oracle.com">Konrad Rzeszutek Wil=
k</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-3639">CVE-2=
018-3639</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+An industry-wide issue was found in the way many modern microprocessor d=
esigns have implemented speculative execution of Load &amp; Store instruc=
tions (a commonly used performance optimization).
+
+It relies on the presence of a precisely-defined instruction sequence in=
 the privileged code as well as the fact that memory read from address to=
 which a recent memory write has occurred may see an older value and subs=
equently cause an update into the microprocessor's data cache even for sp=
eculatively executed instructions that never actually commit (retire).
+
+  </p>
+    <h3>Impact</h3>
+    <p>
+As a result, an unprivileged attacker could use this flaw to read privil=
eged memory by conducting targeted cache side-channel attacks.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+None
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/001.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/001.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D"=
/>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
d19d1f965904a533998739698020ff4ee8a103da">d19d1f965904a533998739698020ff4=
ee8a103da</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
403503b162ffc33fb64cfefdf7b880acf41772cd">403503b162ffc33fb64cfefdf7b880a=
cf41772cd</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
a764f3f7197f4d7ad8fe8424269933de912224cb">a764f3f7197f4d7ad8fe8424269933d=
e912224cb</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f50c1673a89b07f376ce5c42d22d79a79cd466d">4f50c1673a89b07f376ce5c42d22d79=
a79cd466d</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e409d9a158c77c650651e8118f6c86c8dc76eba6">e409d9a158c77c650651e8118f6c86c=
8dc76eba6</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.1">v0.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.2">v0.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.10">stable-0.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.0">v0.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.3">v0.10.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.4">v0.10.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.5">v0.10.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.6">v0.10.6</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7ba1e61953f4592606e60b2e7507ff6a6faf861a">7ba1e61953f4592606e60b2e7507ff6=
a6faf861a</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/001.txt b/secnotice/2018/001.txt
new file mode 100644
index 0000000..3d75341
--- /dev/null
+++ b/secnotice/2018/001.txt
@@ -0,0 +1,210 @@
+        QEMU Security Notice: QSN-2018-001
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: Speculative store bypass
+   Reported on: 20180312
+  Published on: 20180521
+      Fixed on: 20180626
+   Reported by: Ken Johnson (Microsoft Security Response Center) <>
+                Jann Horn (Google Project Zero) <>
+    Patched by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>,
+                Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+      See also: CVE-2018-3639
+
+Description
+-----------
+
+An industry-wide issue was found in the way many modern
+microprocessor designs have implemented speculative execution of
+Load & Store instructions (a commonly used performance
+optimization). It relies on the presence of a precisely-defined
+instruction sequence in the privileged code as well as the fact that
+memory read from address to which a recent memory write has occurred
+may see an older value and subsequently cause an update into the
+microprocessor's data cache even for speculatively executed
+instructions that never actually commit (retire).
+
+Impact
+------
+
+As a result, an unprivileged attacker could use this flaw to read
+privileged memory by conducting targeted cache side-channel attacks.
+
+Mitigation
+----------
+
+None
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v0.10.1
+   Broken in: v0.10.2
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+   Broken in: v3.0.0
+    Fixed in:=20
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+    Fixed by: d19d1f965904a533998739698020ff4ee8a103da
+    Fixed by: 403503b162ffc33fb64cfefdf7b880acf41772cd
+    Fixed by: a764f3f7197f4d7ad8fe8424269933de912224cb
+
+      Branch: stable-0.10
+   Broken in: v0.10.0
+   Broken in: v0.10.3
+   Broken in: v0.10.4
+   Broken in: v0.10.5
+   Broken in: v0.10.6
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: 7ba1e61953f4592606e60b2e7507ff6a6faf861a
+
diff --git a/secnotice/2018/002.html b/secnotice/2018/002.html
new file mode 100644
index 0000000..ea8d96f
--- /dev/null
+++ b/secnotice/2018/002.html
@@ -0,0 +1,1044 @@
+---
+title: 'QSN-2018-002: VGA out of bounds in vga_draw_text'
+layout: secnotice
+permalink: /secnotice/2018/002
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>VGA out of bounds in vga_draw_text</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20171228</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20171225</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td>20180125</td>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:jiangxin1@huawei.com">Jiang Xin</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:linzhecheng@huawei.com">Lin ZheCheng</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-5683">CVE-2=
018-5683</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+Quick Emulator(QEMU) built with the VGA emulator support is vulnerable t=
o an out-of-bounds access issue in vga_draw_text. It could occur while up=
dating vga display area.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A privileged user inside guest could use this flaw to crash the Qemu pro=
cess
+resulting in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Disable graphics adapters if the virtual machines can be operated
+via the serial console
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/002.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/002.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
191f59dc17396bb5a8da50f8c59b6e0a430711a4">191f59dc17396bb5a8da50f8c59b6e0=
a430711a4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
b3bbe959b5dc3bf07041946455cc8e8d562bfd1f">b3bbe959b5dc3bf07041946455cc8e8=
d562bfd1f</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.4.4">v0.4.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.5.0">v0.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.5.1">v0.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.6.0">v0.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.6.1">v0.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.7.0">v0.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.7.1">v0.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.8.1">v0.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.8.2">v0.8.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.9.0">v0.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.9.1">v0.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.10">stable-0.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.0">v0.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.1">v0.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.2">v0.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.3">v0.10.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.4">v0.10.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.5">v0.10.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.6">v0.10.6</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/002.txt b/secnotice/2018/002.txt
new file mode 100644
index 0000000..b817b7f
--- /dev/null
+++ b/secnotice/2018/002.txt
@@ -0,0 +1,206 @@
+        QEMU Security Notice: QSN-2018-002
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: VGA out of bounds in vga_draw_text
+   Reported on: 20171228
+  Published on: 20171225
+      Fixed on: 20180125
+   Reported by: Jiang Xin <jiangxin1@huawei.com>
+    Patched by: Lin ZheCheng <linzhecheng@huawei.com>
+      See also: CVE-2018-5683
+
+Description
+-----------
+
+Quick Emulator(QEMU) built with the VGA emulator support is
+vulnerable to an out-of-bounds access issue in vga_draw_text. It
+could occur while updating vga display area.
+
+Impact
+------
+
+A privileged user inside guest could use this flaw to crash the Qemu
+process resulting in DoS.
+
+Mitigation
+----------
+
+Disable graphics adapters if the virtual machines can be operated
+via the serial console
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v0.4.4
+   Broken in: v0.5.0
+   Broken in: v0.5.1
+   Broken in: v0.6.0
+   Broken in: v0.6.1
+   Broken in: v0.7.0
+   Broken in: v0.7.1
+   Broken in: v0.8.1
+   Broken in: v0.8.2
+   Broken in: v0.9.0
+   Broken in: v0.9.1
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+    Fixed in: v2.12.0
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+    Fixed by: 191f59dc17396bb5a8da50f8c59b6e0a430711a4
+
+      Branch: stable-0.10
+   Broken in: v0.10.0
+   Broken in: v0.10.1
+   Broken in: v0.10.2
+   Broken in: v0.10.3
+   Broken in: v0.10.4
+   Broken in: v0.10.5
+   Broken in: v0.10.6
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
diff --git a/secnotice/2018/003.html b/secnotice/2018/003.html
new file mode 100644
index 0000000..8e8530a
--- /dev/null
+++ b/secnotice/2018/003.html
@@ -0,0 +1,766 @@
+---
+title: 'QSN-2018-003: Multiboot out of bounds loading kernel'
+layout: secnotice
+permalink: /secnotice/2018/003
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>Multiboot out of bounds loading kernel</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180221</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180227</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td>20180328</td>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:"/>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:"/>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-7550">CVE-2=
018-7550</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+Quick Emulator(QEMU) built with the PC System Emulator with multiboot fe=
ature
+support is vulnerable to an OOB memory access issue. It could occur whil=
e
+loading a kernel image during a guest boot if multiboot head addresses
+mh_load_end_addr was greater than mh_bss_end_addr.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user/process could use this flaw to potentially achieve arbitrary code
+execution on a host.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Do not use the -kernel argument to QEMU for providing the boot kernel.
+Allow the guest firmware and bootloader (eg grub) to load the boot kerne=
l from
+inside the confined guest execution environment
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/003.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/003.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
2a8fcd119eb7c6bb3837fc3669eb1b2dfb31daf8">2a8fcd119eb7c6bb3837fc3669eb1b2=
dfb31daf8</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
854a4436dd313eaeb51c275d00526d60437915d2">854a4436dd313eaeb51c275d00526d6=
0437915d2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
6b8273a1b97876950d91c228a420a851e10e12bb">6b8273a1b97876950d91c228a420a85=
1e10e12bb</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/003.txt b/secnotice/2018/003.txt
new file mode 100644
index 0000000..b33b5cb
--- /dev/null
+++ b/secnotice/2018/003.txt
@@ -0,0 +1,160 @@
+        QEMU Security Notice: QSN-2018-003
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: Multiboot out of bounds loading kernel
+   Reported on: 20180221
+  Published on: 20180227
+      Fixed on: 20180328
+   Reported by:  <>
+    Patched by:  <>
+      See also: CVE-2018-7550
+
+Description
+-----------
+
+Quick Emulator(QEMU) built with the PC System Emulator with
+multiboot feature support is vulnerable to an OOB memory access
+issue. It could occur while loading a kernel image during a guest
+boot if multiboot head addresses mh_load_end_addr was greater than
+mh_bss_end_addr.
+
+Impact
+------
+
+A user/process could use this flaw to potentially achieve arbitrary
+code execution on a host.
+
+Mitigation
+----------
+
+Do not use the -kernel argument to QEMU for providing the boot
+kernel. Allow the guest firmware and bootloader (eg grub) to load
+the boot kernel from inside the confined guest execution environment
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+    Fixed in: v2.12.0
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+    Fixed by: 2a8fcd119eb7c6bb3837fc3669eb1b2dfb31daf8
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: 6b8273a1b97876950d91c228a420a851e10e12bb
+
diff --git a/secnotice/2018/004.html b/secnotice/2018/004.html
new file mode 100644
index 0000000..aee9788
--- /dev/null
+++ b/secnotice/2018/004.html
@@ -0,0 +1,1045 @@
+---
+title: 'QSN-2018-004: Cirrus out of bounds access updating VGA display'
+layout: secnotice
+permalink: /secnotice/2018/004
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>Cirrus out of bounds access updating VGA display</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180228</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180308</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td>20180312</td>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:ross.lagerwall@citrix.com">Ross Lagerwall</a=
>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:kraxel@redhat.com">Gerd Hoffmann</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-7858">CVE-2=
018-7858</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+Quick emulator(QEMU) built with the Cirrus CLGD 54xx VGA Emulator suppor=
t is
+vulnerable to an out-of-bounds access issue. It could occur while updati=
ng
+VGA display, after guest has adjusted the display dimensions.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A privileged user inside guest could use this flaw to crash the Qemu pro=
cess
+resulting in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Replace use of the cirrus video adapter with an alternative model
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/004.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/004.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
7cdc61becd095b64a786b2625f321624e7111f3d">7cdc61becd095b64a786b2625f32162=
4e7111f3d</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
fb5fff15881ba7a002924b967eb211c002897983">fb5fff15881ba7a002924b967eb211c=
002897983</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.4.4">v0.4.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.5.0">v0.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.5.1">v0.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.6.0">v0.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.6.1">v0.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.7.0">v0.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.7.1">v0.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.8.1">v0.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.8.2">v0.8.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.9.0">v0.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.9.1">v0.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.10">stable-0.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.0">v0.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.1">v0.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.2">v0.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.3">v0.10.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.4">v0.10.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.5">v0.10.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.6">v0.10.6</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e89f66eca974d2a9d5d89271c6041daefdab2105">e89f66eca974d2a9d5d89271c6041da=
efdab2105</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/004.txt b/secnotice/2018/004.txt
new file mode 100644
index 0000000..940aab3
--- /dev/null
+++ b/secnotice/2018/004.txt
@@ -0,0 +1,206 @@
+        QEMU Security Notice: QSN-2018-004
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: Cirrus out of bounds access updating VGA display
+   Reported on: 20180228
+  Published on: 20180308
+      Fixed on: 20180312
+   Reported by: Ross Lagerwall <ross.lagerwall@citrix.com>
+    Patched by: Gerd Hoffmann <kraxel@redhat.com>
+      See also: CVE-2018-7858
+
+Description
+-----------
+
+Quick emulator(QEMU) built with the Cirrus CLGD 54xx VGA Emulator
+support is vulnerable to an out-of-bounds access issue. It could
+occur while updating VGA display, after guest has adjusted the
+display dimensions.
+
+Impact
+------
+
+A privileged user inside guest could use this flaw to crash the Qemu
+process resulting in DoS.
+
+Mitigation
+----------
+
+Replace use of the cirrus video adapter with an alternative model
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v0.4.4
+   Broken in: v0.5.0
+   Broken in: v0.5.1
+   Broken in: v0.6.0
+   Broken in: v0.6.1
+   Broken in: v0.7.0
+   Broken in: v0.7.1
+   Broken in: v0.8.1
+   Broken in: v0.8.2
+   Broken in: v0.9.0
+   Broken in: v0.9.1
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+    Fixed in: v2.12.0
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+    Fixed by: 7cdc61becd095b64a786b2625f321624e7111f3d
+
+      Branch: stable-0.10
+   Broken in: v0.10.0
+   Broken in: v0.10.1
+   Broken in: v0.10.2
+   Broken in: v0.10.3
+   Broken in: v0.10.4
+   Broken in: v0.10.5
+   Broken in: v0.10.6
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: e89f66eca974d2a9d5d89271c6041daefdab2105
+
diff --git a/secnotice/2018/005.html b/secnotice/2018/005.html
new file mode 100644
index 0000000..f3ba09d
--- /dev/null
+++ b/secnotice/2018/005.html
@@ -0,0 +1,952 @@
+---
+title: 'QSN-2018-005: ne2000 integer overflow in buffer access'
+layout: secnotice
+permalink: /secnotice/2018/005
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>ne2000 integer overflow in buffer access</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180522</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180926</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td/>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:daniel@twistlock.com">Daniel Shapira</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:jasonwang@redhat.com">Jason Wang</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-10839">CVE-=
2018-10839</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+Qemu emulator built with the NE2000 NIC emulation support is vulnerable =
to an integer overflow, which could lead to buffer overflow issue. It cou=
ld occur when receiving packets over the network.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user inside guest could use this flaw to crash the Qemu process result=
ing in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Replace use of the NE2000 network adapter with an alternative model
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/005.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/005.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D"=
/>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
0caf499e2f26ae305a16ae2c4e7a2f295ddf64d1">0caf499e2f26ae305a16ae2c4e7a2f2=
95ddf64d1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
"/>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/005.txt b/secnotice/2018/005.txt
new file mode 100644
index 0000000..c80107b
--- /dev/null
+++ b/secnotice/2018/005.txt
@@ -0,0 +1,191 @@
+        QEMU Security Notice: QSN-2018-005
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: ne2000 integer overflow in buffer access
+   Reported on: 20180522
+  Published on: 20180926
+      Fixed on:=20
+   Reported by: Daniel Shapira <daniel@twistlock.com>
+    Patched by: Jason Wang <jasonwang@redhat.com>
+      See also: CVE-2018-10839
+
+Description
+-----------
+
+Qemu emulator built with the NE2000 NIC emulation support is
+vulnerable to an integer overflow, which could lead to buffer
+overflow issue. It could occur when receiving packets over the
+network.
+
+Impact
+------
+
+A user inside guest could use this flaw to crash the Qemu process
+resulting in DoS.
+
+Mitigation
+----------
+
+Replace use of the NE2000 network adapter with an alternative model
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+   Broken in: v3.0.0
+    Fixed in:=20
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+    Fixed by: 0caf499e2f26ae305a16ae2c4e7a2f295ddf64d1
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
diff --git a/secnotice/2018/006.html b/secnotice/2018/006.html
new file mode 100644
index 0000000..16039d4
--- /dev/null
+++ b/secnotice/2018/006.html
@@ -0,0 +1,1056 @@
+---
+title: 'QSN-2018-006: slirp buffer overflow assembling fragmented datast=
ream'
+layout: secnotice
+permalink: /secnotice/2018/006
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>slirp buffer overflow assembling fragmented datastream</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180427</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180605</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td>20180608</td>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:zdi-disclosures@trendmicro.com">ZDI Disclosu=
res</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:pjp@fedoraproject.org">Prasad J Pandit</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-11806">CVE-=
2018-11806</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+A heap buffer overflow issue was found in the way Slirp networking back-=
end
+in QEMU processes fragmented packets. It could occur while reassembling =
the
+fragmented datagrams of an incoming packet.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A privileged user/process inside guest could use this flaw to crash the =
QEMU
+process resulting in DoS OR potentially leverage it to execute arbitrary=
 code
+on the host with privileges of the QEMU process.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Replace use of the "user" network backend with an alternative choice
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/006.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/006.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
864036e251f54c99d31df124aad7f34f01f5344c">864036e251f54c99d31df124aad7f34=
f01f5344c</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
bac5ba3dc5da706f52c149fa6c0bd1dc96899bec">bac5ba3dc5da706f52c149fa6c0bd1d=
c96899bec</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.6.0">v0.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.6.1">v0.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.7.0">v0.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.7.1">v0.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.8.1">v0.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.8.2">v0.8.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.9.0">v0.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.9.1">v0.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.10">stable-0.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.0">v0.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.1">v0.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.2">v0.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.3">v0.10.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.4">v0.10.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.5">v0.10.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.10.6">v0.10.6</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
f0cbd3ec9f4a3de1a9ef94deda09704543889f44">f0cbd3ec9f4a3de1a9ef94deda09704=
543889f44</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/006.txt b/secnotice/2018/006.txt
new file mode 100644
index 0000000..cbb2b8d
--- /dev/null
+++ b/secnotice/2018/006.txt
@@ -0,0 +1,210 @@
+        QEMU Security Notice: QSN-2018-006
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: slirp buffer overflow assembling fragmented
+                datastream
+   Reported on: 20180427
+  Published on: 20180605
+      Fixed on: 20180608
+   Reported by: ZDI Disclosures <zdi-disclosures@trendmicro.com>
+    Patched by: Prasad J Pandit <pjp@fedoraproject.org>
+      See also: CVE-2018-11806
+
+Description
+-----------
+
+A heap buffer overflow issue was found in the way Slirp networking
+back-end in QEMU processes fragmented packets. It could occur while
+reassembling the fragmented datagrams of an incoming packet.
+
+Impact
+------
+
+A privileged user/process inside guest could use this flaw to crash
+the QEMU process resulting in DoS OR potentially leverage it to
+execute arbitrary code on the host with privileges of the QEMU
+process.
+
+Mitigation
+----------
+
+Replace use of the "user" network backend with an alternative choice
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v0.6.0
+   Broken in: v0.6.1
+   Broken in: v0.7.0
+   Broken in: v0.7.1
+   Broken in: v0.8.1
+   Broken in: v0.8.2
+   Broken in: v0.9.0
+   Broken in: v0.9.1
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+    Fixed in: v3.0.0
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+    Fixed by: 864036e251f54c99d31df124aad7f34f01f5344c
+
+      Branch: stable-0.10
+   Broken in: v0.10.0
+   Broken in: v0.10.1
+   Broken in: v0.10.2
+   Broken in: v0.10.3
+   Broken in: v0.10.4
+   Broken in: v0.10.5
+   Broken in: v0.10.6
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: f0cbd3ec9f4a3de1a9ef94deda09704543889f44
+
diff --git a/secnotice/2018/007.html b/secnotice/2018/007.html
new file mode 100644
index 0000000..3084493
--- /dev/null
+++ b/secnotice/2018/007.html
@@ -0,0 +1,820 @@
+---
+title: 'QSN-2018-007: qemu-guest-agent integer overflow reading guest fi=
le'
+layout: secnotice
+permalink: /secnotice/2018/007
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>qemu-guest-agent integer overflow reading guest file</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180622</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180622</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td>20180705</td>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:mohdfakhrizulkifli@gmail.com">Fakhri Zulkifl=
i</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:pjp@fedoraproject.org">Prasad J Pandit</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-12617">CVE-=
2018-12617</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+The QEMU Guest Agent in QEMU is vulnerable to an integer overflow in the=
=20
+qmp_guest_file_read(). An attacker could exploit this by sending a craft=
ed QMP=20
+command (including guest-file-read with a large count value) to the agen=
t via=20
+the listening socket to trigger a g_malloc() call with a large memory ch=
unk=20
+resulting in a segmentation fault.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user could use this flaw to crash the QEMU guest agent process resulti=
ng in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Disable the QEMU guest agent or blacklist the guest-file-read command
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/007.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/007.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
141b197408ab398c4f474ac1a728ab316e921f2b">141b197408ab398c4f474ac1a728ab3=
16e921f2b</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
8beb8cc64da2868acec270e4becb9fea8f9093dc">8beb8cc64da2868acec270e4becb9fe=
a8f9093dc</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
e3d4d25206a13ca48936e4357a53591997ce6d57">e3d4d25206a13ca48936e4357a53591=
997ce6d57</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/007.txt b/secnotice/2018/007.txt
new file mode 100644
index 0000000..5bbb6cc
--- /dev/null
+++ b/secnotice/2018/007.txt
@@ -0,0 +1,169 @@
+        QEMU Security Notice: QSN-2018-007
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: qemu-guest-agent integer overflow reading guest
+                file
+   Reported on: 20180622
+  Published on: 20180622
+      Fixed on: 20180705
+   Reported by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
+    Patched by: Prasad J Pandit <pjp@fedoraproject.org>
+      See also: CVE-2018-12617
+
+Description
+-----------
+
+The QEMU Guest Agent in QEMU is vulnerable to an integer overflow in
+the qmp_guest_file_read(). An attacker could exploit this by sending
+a crafted QMP command (including guest-file-read with a large count
+value) to the agent via the listening socket to trigger a g_malloc()
+call with a large memory chunk resulting in a segmentation fault.
+
+Impact
+------
+
+A user could use this flaw to crash the QEMU guest agent process
+resulting in DoS.
+
+Mitigation
+----------
+
+Disable the QEMU guest agent or blacklist the guest-file-read command
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+    Fixed in: v3.0.0
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+    Fixed by: 141b197408ab398c4f474ac1a728ab316e921f2b
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: e3d4d25206a13ca48936e4357a53591997ce6d57
+
diff --git a/secnotice/2018/008.html b/secnotice/2018/008.html
new file mode 100644
index 0000000..68b326e
--- /dev/null
+++ b/secnotice/2018/008.html
@@ -0,0 +1,952 @@
+---
+title: 'QSN-2018-008: rtl8139 integer overflow accessing buffer'
+layout: secnotice
+permalink: /secnotice/2018/008
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>rtl8139 integer overflow accessing buffer</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180521</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180926</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td/>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:daniel@twistlock.com">Daniel Shapira</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:jasonwang@redhat.com">Jason Wang</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-17958">CVE-=
2018-17958</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+Qemu emulator built with the RTL8139 NIC emulation support is vulnerable=
 to an integer overflow, which could lead to buffer overflow issue. It co=
uld occur when receiving packets over the network.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user inside guest could use this flaw to crash the Qemu process result=
ing in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Replace use of the RTL8139 network adapter with an alternative model
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/008.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/008.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D"=
/>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
784b912f722bc86126b290c00de72c1bc8d34950">784b912f722bc86126b290c00de72c1=
bc8d34950</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
"/>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/008.txt b/secnotice/2018/008.txt
new file mode 100644
index 0000000..d05705b
--- /dev/null
+++ b/secnotice/2018/008.txt
@@ -0,0 +1,191 @@
+        QEMU Security Notice: QSN-2018-008
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: rtl8139 integer overflow accessing buffer
+   Reported on: 20180521
+  Published on: 20180926
+      Fixed on:=20
+   Reported by: Daniel Shapira <daniel@twistlock.com>
+    Patched by: Jason Wang <jasonwang@redhat.com>
+      See also: CVE-2018-17958
+
+Description
+-----------
+
+Qemu emulator built with the RTL8139 NIC emulation support is
+vulnerable to an integer overflow, which could lead to buffer
+overflow issue. It could occur when receiving packets over the
+network.
+
+Impact
+------
+
+A user inside guest could use this flaw to crash the Qemu process
+resulting in DoS.
+
+Mitigation
+----------
+
+Replace use of the RTL8139 network adapter with an alternative model
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+   Broken in: v3.0.0
+    Fixed in:=20
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+    Fixed by: 784b912f722bc86126b290c00de72c1bc8d34950
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
diff --git a/secnotice/2018/009.html b/secnotice/2018/009.html
new file mode 100644
index 0000000..327b022
--- /dev/null
+++ b/secnotice/2018/009.html
@@ -0,0 +1,952 @@
+---
+title: 'QSN-2018-009: pcnet integer overflow accessing buffer'
+layout: secnotice
+permalink: /secnotice/2018/009
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>pcnet integer overflow accessing buffer</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180521</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180926</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td/>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:daniel@twistlock.com">Daniel Shapira</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:jasonwang@redhat.com">Jason Wang</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-17962">CVE-=
2018-17962</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+Qemu emulator built with the AMD PC-Net II (Am79C970A) emulation support=
 is vulnerable to an integer overflow, which could lead to buffer overflo=
w issue. It could occur when receiving packets over the network.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user inside guest could use this flaw to crash the Qemu process result=
ing in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Replace use of the AMD PC-Net II network adapter with an alternative mod=
el
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/009.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/009.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D"=
/>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
2fc84f6b39577ccd6fd57bdd270902f5098c3a88">2fc84f6b39577ccd6fd57bdd270902f=
5098c3a88</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
"/>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.11">stable-0.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.0">v0.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.11.1">v0.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
4f1c942b7fb29864ad86cb3af9076da38f38f74e">4f1c942b7fb29864ad86cb3af9076da=
38f38f74e</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/009.txt b/secnotice/2018/009.txt
new file mode 100644
index 0000000..ab19a83
--- /dev/null
+++ b/secnotice/2018/009.txt
@@ -0,0 +1,192 @@
+        QEMU Security Notice: QSN-2018-009
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: pcnet integer overflow accessing buffer
+   Reported on: 20180521
+  Published on: 20180926
+      Fixed on:=20
+   Reported by: Daniel Shapira <daniel@twistlock.com>
+    Patched by: Jason Wang <jasonwang@redhat.com>
+      See also: CVE-2018-17962
+
+Description
+-----------
+
+Qemu emulator built with the AMD PC-Net II (Am79C970A) emulation
+support is vulnerable to an integer overflow, which could lead to
+buffer overflow issue. It could occur when receiving packets over
+the network.
+
+Impact
+------
+
+A user inside guest could use this flaw to crash the Qemu process
+resulting in DoS.
+
+Mitigation
+----------
+
+Replace use of the AMD PC-Net II network adapter with an alternative
+model
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+   Broken in: v3.0.0
+    Fixed in:=20
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+    Fixed by: 2fc84f6b39577ccd6fd57bdd270902f5098c3a88
+
+      Branch: stable-0.11
+   Broken in: v0.11.0
+   Broken in: v0.11.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: 4f1c942b7fb29864ad86cb3af9076da38f38f74e
+
diff --git a/secnotice/2018/010.html b/secnotice/2018/010.html
new file mode 100644
index 0000000..192c21c
--- /dev/null
+++ b/secnotice/2018/010.html
@@ -0,0 +1,940 @@
+---
+title: 'QSN-2018-010: Ignore network packet sizes larger than INT_MAX'
+layout: secnotice
+permalink: /secnotice/2018/010
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>Ignore network packet sizes larger than INT_MAX</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180521</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20180926</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td/>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:daniel@twistlock.com">Daniel Shapira</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:jasonwang@redhat.com">Jason Wang</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-17963">CVE-=
2018-17963</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+A potential integer overflow issue was found in the QEMU emulator. It co=
uld occur when a packet with large packet size is accepted and processed.
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user inside guest could use this flaw to crash the Qemu process result=
ing in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+None
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/010.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/010.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D"=
/>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
36772a6341af7c0f100b8e55a1e779db5fe818da">36772a6341af7c0f100b8e55a1e779d=
b5fe818da</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
"/>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.12">stable-0.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.0">v0.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.1">v0.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.2">v0.12.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.3">v0.12.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.4">v0.12.4</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.12.5">v0.12.5</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.13">stable-0.13</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.13.0">v0.13.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.14">stable-0.14</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.0">v0.14.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.14.1">v0.14.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
9a6ecb308b1c668fff84d56a356dbd595c51d556">9a6ecb308b1c668fff84d56a356dbd5=
95c51d556</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/010.txt b/secnotice/2018/010.txt
new file mode 100644
index 0000000..918ac7f
--- /dev/null
+++ b/secnotice/2018/010.txt
@@ -0,0 +1,188 @@
+        QEMU Security Notice: QSN-2018-010
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: Ignore network packet sizes larger than INT_MAX
+   Reported on: 20180521
+  Published on: 20180926
+      Fixed on:=20
+   Reported by: Daniel Shapira <daniel@twistlock.com>
+    Patched by: Jason Wang <jasonwang@redhat.com>
+      See also: CVE-2018-17963
+
+Description
+-----------
+
+A potential integer overflow issue was found in the QEMU emulator.
+It could occur when a packet with large packet size is accepted and
+processed.
+
+Impact
+------
+
+A user inside guest could use this flaw to crash the Qemu process
+resulting in DoS.
+
+Mitigation
+----------
+
+None
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+   Broken in: v3.0.0
+    Fixed in:=20
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+    Fixed by: 36772a6341af7c0f100b8e55a1e779db5fe818da
+
+      Branch: stable-0.12
+   Broken in: v0.12.0
+   Broken in: v0.12.1
+   Broken in: v0.12.2
+   Broken in: v0.12.3
+   Broken in: v0.12.4
+   Broken in: v0.12.5
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-0.13
+   Broken in: v0.13.0
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-0.14
+   Broken in: v0.14.0
+   Broken in: v0.14.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: 9a6ecb308b1c668fff84d56a356dbd595c51d556
+
diff --git a/secnotice/2018/011.html b/secnotice/2018/011.html
new file mode 100644
index 0000000..7f56380
--- /dev/null
+++ b/secnotice/2018/011.html
@@ -0,0 +1,823 @@
+---
+title: 'QSN-2018-011: CCID integer overflow reading data'
+layout: secnotice
+permalink: /secnotice/2018/011
+---
+
+    <div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"main">
+  <div class=3D"container">
+    <h2>CCID integer overflow reading data</h2>
+    <h3>Lifecycle</h3>
+    <table>
+      <tr>
+        <th>Reported on:</th>
+        <td>20180726</td>
+      </tr>
+      <tr>
+        <th>Published on:</th>
+        <td>20181011</td>
+      </tr>
+      <tr>
+        <th>Fixed on:</th>
+        <td/>
+      </tr>
+    </table>
+    <h3>Credits</h3>
+    <table>
+      <tr>
+        <th>Reported by:</th>
+        <td>
+          <a href=3D"mailto:tohidi.arash@gmail.com">Arash Tohidi</a>
+        </td>
+      </tr>
+      <tr>
+        <th>Patched by:</th>
+        <td>
+          <a href=3D"mailto:philmd@redhat.com">Philippe Mathieu-Daud=C3=A9=
</a>
+        </td>
+      </tr>
+    </table>
+    <h3>See also</h3>
+    <ul>
+      <li>
+        <a href=3D"https://nvd.nist.gov/vuln/detail/CVE-2018-18438">CVE-=
2018-18438</a>
+      </li>
+    </ul>
+    <h3>Description</h3>
+    <p>
+An integer overflow issue was found in the CCID Passthru card device emu=
lation, while reading card data in ccid_card_vscard_read() function. The =
ccid_card_vscard_read() function accepts a signed integer 'size' argument=
, which is subsequently used as unsigned size_t value in memcpy(), copyin=
g large amounts of memory.
+
+  </p>
+    <h3>Impact</h3>
+    <p>
+A user inside guest could use this flaw to crash the Qemu process result=
ing in DoS.
+  </p>
+    <h3>Mitigation</h3>
+    <p>
+Remove the CCID device emulation from virtual machines
+  </p>
+    <p class=3D"altformat">
+      Alternative formats:
+      <a href=3D"/secnotice/2018/011.xml">[xml]</a> <a href=3D"/secnotic=
e/2018/011.txt">[text]</a></p>
+  </div>
+</div><div xmlns=3D"http://www.w3.org/1999/xhtml" id=3D"sidebar">
+  <div class=3D"container">
+    <section>
+      <header>
+        <h2>Related commits</h2>
+      </header>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/master">master</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Fixed in:</th>
+            <td class=3D"fixedtag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3D"=
/>
+            </td>
+          </tr>
+          <tr>
+            <th>Fixed by:</th>
+            <td class=3D"fixedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
"/>
+            </td>
+          </tr>
+          <tr>
+            <th>Merged by:</th>
+            <td class=3D"mergedcommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
"/>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0">v1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.0">v1.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.0">v1.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.0">v1.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.0">v1.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.0">v1.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.0">v1.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.0">v1.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.0">v2.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.0">v2.1.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.0">v2.2.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.0">v2.3.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0">v2.4.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.0">v2.5.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.0">v2.6.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.0">v2.7.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.0">v2.8.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.0">v2.9.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.0">v2.10.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.0">v2.11.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.0">v2.12.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
3.0.0">v3.0.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-0.15">stable-0.15</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.0">v0.15.0</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
0.15.1">v0.15.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.0">stable-1.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.0.1">v1.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.1">stable-1.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.1">v1.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.1.2">v1.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.2">stable-1.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.1">v1.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.2.2">v1.2.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.3">stable-1.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.3.1">v1.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.4">stable-1.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.1">v1.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.4.2">v1.4.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.5">stable-1.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.1">v1.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.2">v1.5.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.5.3">v1.5.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.6">stable-1.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.1">v1.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.6.2">v1.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-1.7">stable-1.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.1">v1.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
1.7.2">v1.7.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.0">stable-2.0</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.1">v2.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.0.2">v2.0.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.1">stable-2.1</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.1">v2.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.2">v2.1.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.1.3">v2.1.3</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.2">stable-2.2</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.2.1">v2.2.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.3">stable-2.3</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.3.1">v2.3.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.4">stable-2.4</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.0.1">v2.4.0.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.4.1">v2.4.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.5">stable-2.5</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1">v2.5.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.5.1.1">v2.5.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.6">stable-2.6</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.1">v2.6.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.6.2">v2.6.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.7">stable-2.7</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.7.1">v2.7.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.8">stable-2.8</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1">v2.8.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.8.1.1">v2.8.1.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.9">stable-2.9</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.9.1">v2.9.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.10">stable-2.10</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.1">v2.10.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.10.2">v2.10.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.11">stable-2.11</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.1">v2.11.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.11.2">v2.11.2</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+      <table class=3D"repository">
+        <thead>
+          <tr>
+            <th colspan=3D"2">Branch:
+	      <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Dref=
s/heads/stable-2.12">stable-2.12</a></th>
+          </tr>
+        </thead>
+        <tbody>
+          <tr>
+            <th>Broken in:</th>
+            <td class=3D"brokentag">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dtag;h=3Dv=
2.12.1">v2.12.1</a>
+            </td>
+          </tr>
+          <tr>
+            <th>Broken by:</th>
+            <td class=3D"brokencommit">
+              <a href=3D"http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D=
edbb21363fbfe40e050f583df921484cbc31c79d">edbb21363fbfe40e050f583df921484=
cbc31c79d</a>
+            </td>
+          </tr>
+        </tbody>
+      </table>
+    </section>
+  </div>
+</div>
diff --git a/secnotice/2018/011.txt b/secnotice/2018/011.txt
new file mode 100644
index 0000000..6907178
--- /dev/null
+++ b/secnotice/2018/011.txt
@@ -0,0 +1,169 @@
+        QEMU Security Notice: QSN-2018-011
+        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+       Summary: CCID integer overflow reading data
+   Reported on: 20180726
+  Published on: 20181011
+      Fixed on:=20
+   Reported by: Arash Tohidi <tohidi.arash@gmail.com>
+    Patched by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+      See also: CVE-2018-18438
+
+Description
+-----------
+
+An integer overflow issue was found in the CCID Passthru card device
+emulation, while reading card data in ccid_card_vscard_read()
+function. The ccid_card_vscard_read() function accepts a signed
+integer 'size' argument, which is subsequently used as unsigned
+size_t value in memcpy(), copying large amounts of memory.
+
+Impact
+------
+
+A user inside guest could use this flaw to crash the Qemu process
+resulting in DoS.
+
+Mitigation
+----------
+
+Remove the CCID device emulation from virtual machines
+
+Related commits
+----------------
+
+  git://git.qemu.org/qemu.git
+  https://git.qemu.org/?p=3Dqemu.git
+
+      Branch: master
+   Broken in: v1.0
+   Broken in: v1.1.0
+   Broken in: v1.2.0
+   Broken in: v1.3.0
+   Broken in: v1.4.0
+   Broken in: v1.5.0
+   Broken in: v1.6.0
+   Broken in: v1.7.0
+   Broken in: v2.0.0
+   Broken in: v2.1.0
+   Broken in: v2.2.0
+   Broken in: v2.3.0
+   Broken in: v2.4.0
+   Broken in: v2.5.0
+   Broken in: v2.6.0
+   Broken in: v2.7.0
+   Broken in: v2.8.0
+   Broken in: v2.9.0
+   Broken in: v2.10.0
+   Broken in: v2.11.0
+   Broken in: v2.12.0
+   Broken in: v3.0.0
+    Fixed in:=20
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+    Fixed by:=20
+
+      Branch: stable-0.15
+   Broken in: v0.15.0
+   Broken in: v0.15.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.0
+   Broken in: v1.0.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.1
+   Broken in: v1.1.1
+   Broken in: v1.1.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.2
+   Broken in: v1.2.1
+   Broken in: v1.2.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.3
+   Broken in: v1.3.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.4
+   Broken in: v1.4.1
+   Broken in: v1.4.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.5
+   Broken in: v1.5.1
+   Broken in: v1.5.2
+   Broken in: v1.5.3
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.6
+   Broken in: v1.6.1
+   Broken in: v1.6.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-1.7
+   Broken in: v1.7.1
+   Broken in: v1.7.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.0
+   Broken in: v2.0.1
+   Broken in: v2.0.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.1
+   Broken in: v2.1.1
+   Broken in: v2.1.2
+   Broken in: v2.1.3
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.2
+   Broken in: v2.2.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.3
+   Broken in: v2.3.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.4
+   Broken in: v2.4.0.1
+   Broken in: v2.4.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.5
+   Broken in: v2.5.1
+   Broken in: v2.5.1.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.6
+   Broken in: v2.6.1
+   Broken in: v2.6.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.7
+   Broken in: v2.7.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.8
+   Broken in: v2.8.1
+   Broken in: v2.8.1.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.9
+   Broken in: v2.9.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.10
+   Broken in: v2.10.1
+   Broken in: v2.10.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.11
+   Broken in: v2.11.1
+   Broken in: v2.11.2
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
+      Branch: stable-2.12
+   Broken in: v2.12.1
+   Broken by: edbb21363fbfe40e050f583df921484cbc31c79d
+
diff --git a/secnotice/2018/index.html b/secnotice/2018/index.html
new file mode 100644
index 0000000..cdc9bf6
--- /dev/null
+++ b/secnotice/2018/index.html
@@ -0,0 +1,46 @@
+---
+title: QEMU Security Notices
+permalink: /secnotice/2018/
+---
+
+   <p xmlns=3D"http://www.w3.org/1999/xhtml">
+     If you believe you have identified a new security issue in QEMU, pl=
ease
+     follow the <a href=3D"https://wiki.qemu.org/SecurityProcess">securi=
ty process</a>
+     to report it in a non-public way. Do <strong>NOT</strong> use the b=
ug tracker,
+     mailing lists, or IRC to report non-public security issues.
+   </p><ul xmlns=3D"http://www.w3.org/1999/xhtml">
+  <li>
+    <a href=3D"2018/011">QSN-2018-011: CCID integer overflow reading dat=
a</a>
+  </li>
+  <li>
+    <a href=3D"2018/010">QSN-2018-010: Ignore network packet sizes large=
r than INT_MAX</a>
+  </li>
+  <li>
+    <a href=3D"2018/009">QSN-2018-009: pcnet integer overflow accessing =
buffer</a>
+  </li>
+  <li>
+    <a href=3D"2018/008">QSN-2018-008: rtl8139 integer overflow accessin=
g buffer</a>
+  </li>
+  <li>
+    <a href=3D"2018/007">QSN-2018-007: qemu-guest-agent integer overflow=
 reading guest file</a>
+  </li>
+  <li>
+    <a href=3D"2018/006">QSN-2018-006: slirp buffer overflow assembling =
fragmented datastream</a>
+  </li>
+  <li>
+    <a href=3D"2018/005">QSN-2018-005: ne2000 integer overflow in buffer=
 access</a>
+  </li>
+  <li>
+    <a href=3D"2018/004">QSN-2018-004: Cirrus out of bounds access updat=
ing VGA display</a>
+  </li>
+  <li>
+    <a href=3D"2018/003">QSN-2018-003: Multiboot out of bounds loading k=
ernel</a>
+  </li>
+  <li>
+    <a href=3D"2018/002">QSN-2018-002: VGA out of bounds in vga_draw_tex=
t</a>
+  </li>
+  <li>
+    <a href=3D"2018/001">QSN-2018-001: Speculative store bypass</a>
+  </li>
+</ul><p xmlns=3D"http://www.w3.org/1999/xhtml" class=3D"alt">
+      Alternative formats: <a href=3D"index.xml">[xml]</a></p>
diff --git a/secnotice/2018/index.xml b/secnotice/2018/index.xml
new file mode 100644
index 0000000..aa57594
--- /dev/null
+++ b/secnotice/2018/index.xml
@@ -0,0 +1,13 @@
+<security-notice-list xmlns=3D"http://qemu.org/xmlns/security-notice-lis=
t/1.0">
+  <security-notice name=3D'/secnotice/2018/001.xml'/>
+  <security-notice name=3D'/secnotice/2018/002.xml'/>
+  <security-notice name=3D'/secnotice/2018/003.xml'/>
+  <security-notice name=3D'/secnotice/2018/004.xml'/>
+  <security-notice name=3D'/secnotice/2018/005.xml'/>
+  <security-notice name=3D'/secnotice/2018/006.xml'/>
+  <security-notice name=3D'/secnotice/2018/007.xml'/>
+  <security-notice name=3D'/secnotice/2018/008.xml'/>
+  <security-notice name=3D'/secnotice/2018/009.xml'/>
+  <security-notice name=3D'/secnotice/2018/010.xml'/>
+  <security-notice name=3D'/secnotice/2018/011.xml'/>
+</security-notice-list>
diff --git a/secnotice/index.html b/secnotice/index.html
new file mode 100644
index 0000000..c2a87c6
--- /dev/null
+++ b/secnotice/index.html
@@ -0,0 +1,46 @@
+---
+title: QEMU Security Notices
+permalink: /secnotice/
+---
+
+   <p xmlns=3D"http://www.w3.org/1999/xhtml">
+     If you believe you have identified a new security issue in QEMU, pl=
ease
+     follow the <a href=3D"https://wiki.qemu.org/SecurityProcess">securi=
ty process</a>
+     to report it in a non-public way. Do <strong>NOT</strong> use the b=
ug tracker,
+     mailing lists, or IRC to report non-public security issues.
+   </p><ul xmlns=3D"http://www.w3.org/1999/xhtml">
+  <li>
+    <a href=3D"2018/011">QSN-2018-011: CCID integer overflow reading dat=
a</a>
+  </li>
+  <li>
+    <a href=3D"2018/010">QSN-2018-010: Ignore network packet sizes large=
r than INT_MAX</a>
+  </li>
+  <li>
+    <a href=3D"2018/009">QSN-2018-009: pcnet integer overflow accessing =
buffer</a>
+  </li>
+  <li>
+    <a href=3D"2018/008">QSN-2018-008: rtl8139 integer overflow accessin=
g buffer</a>
+  </li>
+  <li>
+    <a href=3D"2018/007">QSN-2018-007: qemu-guest-agent integer overflow=
 reading guest file</a>
+  </li>
+  <li>
+    <a href=3D"2018/006">QSN-2018-006: slirp buffer overflow assembling =
fragmented datastream</a>
+  </li>
+  <li>
+    <a href=3D"2018/005">QSN-2018-005: ne2000 integer overflow in buffer=
 access</a>
+  </li>
+  <li>
+    <a href=3D"2018/004">QSN-2018-004: Cirrus out of bounds access updat=
ing VGA display</a>
+  </li>
+  <li>
+    <a href=3D"2018/003">QSN-2018-003: Multiboot out of bounds loading k=
ernel</a>
+  </li>
+  <li>
+    <a href=3D"2018/002">QSN-2018-002: VGA out of bounds in vga_draw_tex=
t</a>
+  </li>
+  <li>
+    <a href=3D"2018/001">QSN-2018-001: Speculative store bypass</a>
+  </li>
+</ul><p xmlns=3D"http://www.w3.org/1999/xhtml" class=3D"alt">
+      Alternative formats: <a href=3D"index.xml">[xml]</a></p>
diff --git a/secnotice/index.xml b/secnotice/index.xml
new file mode 100644
index 0000000..aa57594
--- /dev/null
+++ b/secnotice/index.xml
@@ -0,0 +1,13 @@
+<security-notice-list xmlns=3D"http://qemu.org/xmlns/security-notice-lis=
t/1.0">
+  <security-notice name=3D'/secnotice/2018/001.xml'/>
+  <security-notice name=3D'/secnotice/2018/002.xml'/>
+  <security-notice name=3D'/secnotice/2018/003.xml'/>
+  <security-notice name=3D'/secnotice/2018/004.xml'/>
+  <security-notice name=3D'/secnotice/2018/005.xml'/>
+  <security-notice name=3D'/secnotice/2018/006.xml'/>
+  <security-notice name=3D'/secnotice/2018/007.xml'/>
+  <security-notice name=3D'/secnotice/2018/008.xml'/>
+  <security-notice name=3D'/secnotice/2018/009.xml'/>
+  <security-notice name=3D'/secnotice/2018/010.xml'/>
+  <security-notice name=3D'/secnotice/2018/011.xml'/>
+</security-notice-list>
--=20
2.17.2
