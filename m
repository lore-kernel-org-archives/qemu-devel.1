Received: from eggs.gnu.org ([2001:4830:134:3::10]:43089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9f8-0006a8-5F
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gD9eq-0000NI-Ga
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gD9ep-0000MG-Ov
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:52:16 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 18 Oct 2018 15:52:02 +0100
Message-Id: <20181018145203.11336-4-berrange@redhat.com>
In-Reply-To: <20181018145203.11336-1-berrange@redhat.com>
References: <20181018145203.11336-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [web PATCH 3/4] Add vulnerability reports for 2018
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
 secnotice/2018/001.xml | 248 +++++++++++++++++++++++++++++++++++++++++
 secnotice/2018/002.xml | 242 ++++++++++++++++++++++++++++++++++++++++
 secnotice/2018/003.xml | 191 +++++++++++++++++++++++++++++++
 secnotice/2018/004.xml | 243 ++++++++++++++++++++++++++++++++++++++++
 secnotice/2018/005.xml | 225 +++++++++++++++++++++++++++++++++++++
 secnotice/2018/006.xml | 247 ++++++++++++++++++++++++++++++++++++++++
 secnotice/2018/007.xml | 201 +++++++++++++++++++++++++++++++++
 secnotice/2018/008.xml | 225 +++++++++++++++++++++++++++++++++++++
 secnotice/2018/009.xml | 225 +++++++++++++++++++++++++++++++++++++
 secnotice/2018/010.xml | 223 ++++++++++++++++++++++++++++++++++++
 secnotice/2018/011.xml | 199 +++++++++++++++++++++++++++++++++
 11 files changed, 2469 insertions(+)
 create mode 100644 secnotice/2018/001.xml
 create mode 100644 secnotice/2018/002.xml
 create mode 100644 secnotice/2018/003.xml
 create mode 100644 secnotice/2018/004.xml
 create mode 100644 secnotice/2018/005.xml
 create mode 100644 secnotice/2018/006.xml
 create mode 100644 secnotice/2018/007.xml
 create mode 100644 secnotice/2018/008.xml
 create mode 100644 secnotice/2018/009.xml
 create mode 100644 secnotice/2018/010.xml
 create mode 100644 secnotice/2018/011.xml

diff --git a/secnotice/2018/001.xml b/secnotice/2018/001.xml
new file mode 100644
index 0000000..3636545
--- /dev/null
+++ b/secnotice/2018/001.xml
@@ -0,0 +1,248 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-001</id>
+
+  <summary>Speculative store bypass</summary>
+
+  <description>
+<![CDATA[An industry-wide issue was found in the way many modern micropr=
ocessor designs have implemented speculative execution of Load & Store in=
structions (a commonly used performance optimization).
+
+It relies on the presence of a precisely-defined instruction sequence in=
 the privileged code as well as the fact that memory read from address to=
 which a recent memory write has occurred may see an older value and subs=
equently cause an update into the microprocessor's data cache even for sp=
eculatively executed instructions that never actually commit (retire).
+]]>
+  </description>
+
+  <impact>
+<![CDATA[As a result, an unprivileged attacker could use this flaw to re=
ad privileged memory by conducting targeted cache side-channel attacks.]]=
>
+  </impact>
+
+  <mitigation>
+<![CDATA[None]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Ken Johnson (Microsoft Security Response Center)</name>
+    </reporter>
+    <reporter>
+      <name>Jann Horn (Google Project Zero)</name>
+    </reporter>
+    <patcher>
+      <name>Daniel P. Berrang=C3=A9</name>
+      <email>berrange@redhat.com</email>
+    </patcher>
+    <patcher>
+      <name>Konrad Rzeszutek Wilk</name>
+      <email>konrad.wilk@oracle.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180312</reported>
+    <published>20180521</published>
+    <fixed>20180626</fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-3639"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <change state=3D"fixed">d19d1f965904a533998739698020ff4ee8a103da</=
change>
+      <change state=3D"fixed">403503b162ffc33fb64cfefdf7b880acf41772cd</=
change>
+      <change state=3D"merged">4f50c1673a89b07f376ce5c42d22d79a79cd466d<=
/change>
+      <change state=3D"fixed">a764f3f7197f4d7ad8fe8424269933de912224cb</=
change>
+      <change state=3D"merged">e409d9a158c77c650651e8118f6c86c8dc76eba6<=
/change>
+      <tag state=3D"fixed"></tag>
+      <tag state=3D"vulnerable">v0.10.1</tag>
+      <tag state=3D"vulnerable">v0.10.2</tag>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <tag state=3D"vulnerable">v3.0.0</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-0.10</name>
+      <tag state=3D"vulnerable">v0.10.0</tag>
+      <tag state=3D"vulnerable">v0.10.3</tag>
+      <tag state=3D"vulnerable">v0.10.4</tag>
+      <tag state=3D"vulnerable">v0.10.5</tag>
+      <tag state=3D"vulnerable">v0.10.6</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">7ba1e61953f4592606e60b2e7507ff6a6faf8=
61a</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/002.xml b/secnotice/2018/002.xml
new file mode 100644
index 0000000..6422715
--- /dev/null
+++ b/secnotice/2018/002.xml
@@ -0,0 +1,242 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-002</id>
+
+  <summary>VGA out of bounds in vga_draw_text</summary>
+
+  <description>
+<![CDATA[Quick Emulator(QEMU) built with the VGA emulator support is vul=
nerable to an out-of-bounds access issue in vga_draw_text. It could occur=
 while updating vga display area.]]>
+  </description>
+
+  <impact>
+<![CDATA[A privileged user inside guest could use this flaw to crash the=
 Qemu process
+resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Disable graphics adapters if the virtual machines can be operat=
ed
+via the serial console]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Jiang Xin</name>
+      <email>jiangxin1@huawei.com</email>
+    </reporter>
+    <patcher>
+      <name>Lin ZheCheng</name>
+      <email>linzhecheng@huawei.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20171228</reported>
+    <published>20171225</published>
+    <fixed>20180125</fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-5683"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed">v2.12.0</tag>
+      <change state=3D"fixed">191f59dc17396bb5a8da50f8c59b6e0a430711a4</=
change>
+      <change state=3D"merged">b3bbe959b5dc3bf07041946455cc8e8d562bfd1f<=
/change>
+      <tag state=3D"vulnerable">v0.4.4</tag>
+      <tag state=3D"vulnerable">v0.5.0</tag>
+      <tag state=3D"vulnerable">v0.5.1</tag>
+      <tag state=3D"vulnerable">v0.6.0</tag>
+      <tag state=3D"vulnerable">v0.6.1</tag>
+      <tag state=3D"vulnerable">v0.7.0</tag>
+      <tag state=3D"vulnerable">v0.7.1</tag>
+      <tag state=3D"vulnerable">v0.8.1</tag>
+      <tag state=3D"vulnerable">v0.8.2</tag>
+      <tag state=3D"vulnerable">v0.9.0</tag>
+      <tag state=3D"vulnerable">v0.9.1</tag>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.10</name>
+      <tag state=3D"vulnerable">v0.10.0</tag>
+      <tag state=3D"vulnerable">v0.10.1</tag>
+      <tag state=3D"vulnerable">v0.10.2</tag>
+      <tag state=3D"vulnerable">v0.10.3</tag>
+      <tag state=3D"vulnerable">v0.10.4</tag>
+      <tag state=3D"vulnerable">v0.10.5</tag>
+      <tag state=3D"vulnerable">v0.10.6</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/003.xml b/secnotice/2018/003.xml
new file mode 100644
index 0000000..9691805
--- /dev/null
+++ b/secnotice/2018/003.xml
@@ -0,0 +1,191 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-003</id>
+
+  <summary>Multiboot out of bounds loading kernel</summary>
+
+  <description>
+<![CDATA[Quick Emulator(QEMU) built with the PC System Emulator with mul=
tiboot feature
+support is vulnerable to an OOB memory access issue. It could occur whil=
e
+loading a kernel image during a guest boot if multiboot head addresses
+mh_load_end_addr was greater than mh_bss_end_addr.]]>
+  </description>
+
+  <impact>
+<![CDATA[A user/process could use this flaw to potentially achieve arbit=
rary code
+execution on a host.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Do not use the -kernel argument to QEMU for providing the boot =
kernel.
+Allow the guest firmware and bootloader (eg grub) to load the boot kerne=
l from
+inside the confined guest execution environment]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name></name>
+      <email></email>
+    </reporter>
+    <patcher>
+      <name></name>
+      <email></email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180221</reported>
+    <published>20180227</published>
+    <fixed>20180328</fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-7550"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed">v2.12.0</tag>
+      <change state=3D"fixed">2a8fcd119eb7c6bb3837fc3669eb1b2dfb31daf8</=
change>
+      <change state=3D"merged">854a4436dd313eaeb51c275d00526d60437915d2<=
/change>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">6b8273a1b97876950d91c228a420a851e10e1=
2bb</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/004.xml b/secnotice/2018/004.xml
new file mode 100644
index 0000000..83a43dc
--- /dev/null
+++ b/secnotice/2018/004.xml
@@ -0,0 +1,243 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-004</id>
+
+  <summary>Cirrus out of bounds access updating VGA display</summary>
+
+  <description>
+<![CDATA[Quick emulator(QEMU) built with the Cirrus CLGD 54xx VGA Emulat=
or support is
+vulnerable to an out-of-bounds access issue. It could occur while updati=
ng
+VGA display, after guest has adjusted the display dimensions.]]>
+  </description>
+
+  <impact>
+<![CDATA[A privileged user inside guest could use this flaw to crash the=
 Qemu process
+resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Replace use of the cirrus video adapter with an alternative mod=
el]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Ross Lagerwall</name>
+      <email>ross.lagerwall@citrix.com</email>
+    </reporter>
+    <patcher>
+      <name>Gerd Hoffmann</name>
+      <email>kraxel@redhat.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180228</reported>
+    <published>20180308</published>
+    <fixed>20180312</fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-7858"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed">v2.12.0</tag>
+      <change state=3D"fixed">7cdc61becd095b64a786b2625f321624e7111f3d</=
change>
+      <change state=3D"merged">fb5fff15881ba7a002924b967eb211c002897983<=
/change>
+      <tag state=3D"vulnerable">v0.4.4</tag>
+      <tag state=3D"vulnerable">v0.5.0</tag>
+      <tag state=3D"vulnerable">v0.5.1</tag>
+      <tag state=3D"vulnerable">v0.6.0</tag>
+      <tag state=3D"vulnerable">v0.6.1</tag>
+      <tag state=3D"vulnerable">v0.7.0</tag>
+      <tag state=3D"vulnerable">v0.7.1</tag>
+      <tag state=3D"vulnerable">v0.8.1</tag>
+      <tag state=3D"vulnerable">v0.8.2</tag>
+      <tag state=3D"vulnerable">v0.9.0</tag>
+      <tag state=3D"vulnerable">v0.9.1</tag>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.10</name>
+      <tag state=3D"vulnerable">v0.10.0</tag>
+      <tag state=3D"vulnerable">v0.10.1</tag>
+      <tag state=3D"vulnerable">v0.10.2</tag>
+      <tag state=3D"vulnerable">v0.10.3</tag>
+      <tag state=3D"vulnerable">v0.10.4</tag>
+      <tag state=3D"vulnerable">v0.10.5</tag>
+      <tag state=3D"vulnerable">v0.10.6</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">e89f66eca974d2a9d5d89271c6041daefdab2=
105</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/005.xml b/secnotice/2018/005.xml
new file mode 100644
index 0000000..55a2374
--- /dev/null
+++ b/secnotice/2018/005.xml
@@ -0,0 +1,225 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-005</id>
+
+  <summary>ne2000 integer overflow in buffer access</summary>
+
+  <description>
+<![CDATA[Qemu emulator built with the NE2000 NIC emulation support is vu=
lnerable to an integer overflow, which could lead to buffer overflow issu=
e. It could occur when receiving packets over the network.]]>
+  </description>
+
+  <impact>
+<![CDATA[A user inside guest could use this flaw to crash the Qemu proce=
ss resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Replace use of the NE2000 network adapter with an alternative m=
odel]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Daniel Shapira</name>
+      <email>daniel@twistlock.com</email>
+    </reporter>
+    <patcher>
+      <name>Jason Wang</name>
+      <email>jasonwang@redhat.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180522</reported>
+    <published>20180926</published>
+    <fixed></fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-10839"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed"></tag>
+      <change state=3D"fixed">0caf499e2f26ae305a16ae2c4e7a2f295ddf64d1</=
change>
+      <change state=3D"merged"></change>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <tag state=3D"vulnerable">v3.0.0</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/006.xml b/secnotice/2018/006.xml
new file mode 100644
index 0000000..7a7908c
--- /dev/null
+++ b/secnotice/2018/006.xml
@@ -0,0 +1,247 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-006</id>
+
+  <summary>slirp buffer overflow assembling fragmented datastream</summa=
ry>
+
+  <description>
+<![CDATA[A heap buffer overflow issue was found in the way Slirp network=
ing back-end
+in QEMU processes fragmented packets. It could occur while reassembling =
the
+fragmented datagrams of an incoming packet.]]>
+  </description>
+
+  <impact>
+<![CDATA[A privileged user/process inside guest could use this flaw to c=
rash the QEMU
+process resulting in DoS OR potentially leverage it to execute arbitrary=
 code
+on the host with privileges of the QEMU process.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Replace use of the "user" network backend with an alternative c=
hoice]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>ZDI Disclosures</name>
+      <email>zdi-disclosures@trendmicro.com</email>
+    </reporter>
+    <patcher>
+      <name>Prasad J Pandit</name>
+      <email>pjp@fedoraproject.org</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180427</reported>
+    <published>20180605</published>
+    <fixed>20180608</fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-11806"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed">v3.0.0</tag>
+      <change state=3D"fixed">864036e251f54c99d31df124aad7f34f01f5344c</=
change>
+      <change state=3D"merged">bac5ba3dc5da706f52c149fa6c0bd1dc96899bec<=
/change>
+      <tag state=3D"vulnerable">v0.6.0</tag>
+      <tag state=3D"vulnerable">v0.6.1</tag>
+      <tag state=3D"vulnerable">v0.7.0</tag>
+      <tag state=3D"vulnerable">v0.7.1</tag>
+      <tag state=3D"vulnerable">v0.8.1</tag>
+      <tag state=3D"vulnerable">v0.8.2</tag>
+      <tag state=3D"vulnerable">v0.9.0</tag>
+      <tag state=3D"vulnerable">v0.9.1</tag>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-0.10</name>
+      <tag state=3D"vulnerable">v0.10.0</tag>
+      <tag state=3D"vulnerable">v0.10.1</tag>
+      <tag state=3D"vulnerable">v0.10.2</tag>
+      <tag state=3D"vulnerable">v0.10.3</tag>
+      <tag state=3D"vulnerable">v0.10.4</tag>
+      <tag state=3D"vulnerable">v0.10.5</tag>
+      <tag state=3D"vulnerable">v0.10.6</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">f0cbd3ec9f4a3de1a9ef94deda09704543889=
f44</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/007.xml b/secnotice/2018/007.xml
new file mode 100644
index 0000000..4de353b
--- /dev/null
+++ b/secnotice/2018/007.xml
@@ -0,0 +1,201 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-007</id>
+
+  <summary>qemu-guest-agent integer overflow reading guest file</summary=
>
+
+  <description>
+<![CDATA[The QEMU Guest Agent in QEMU is vulnerable to an integer overfl=
ow in the=20
+qmp_guest_file_read(). An attacker could exploit this by sending a craft=
ed QMP=20
+command (including guest-file-read with a large count value) to the agen=
t via=20
+the listening socket to trigger a g_malloc() call with a large memory ch=
unk=20
+resulting in a segmentation fault.]]>
+  </description>
+
+  <impact>
+<![CDATA[A user could use this flaw to crash the QEMU guest agent proces=
s resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Disable the QEMU guest agent or blacklist the guest-file-read c=
ommand]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Fakhri Zulkifli</name>
+      <email>mohdfakhrizulkifli@gmail.com</email>
+    </reporter>
+    <patcher>
+      <name>Prasad J Pandit</name>
+      <email>pjp@fedoraproject.org</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180622</reported>
+    <published>20180622</published>
+    <fixed>20180705</fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-12617"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed">v3.0.0</tag>
+      <change state=3D"fixed">141b197408ab398c4f474ac1a728ab316e921f2b</=
change>
+      <change state=3D"merged">8beb8cc64da2868acec270e4becb9fea8f9093dc<=
/change>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">e3d4d25206a13ca48936e4357a53591997ce6=
d57</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/008.xml b/secnotice/2018/008.xml
new file mode 100644
index 0000000..5cf8d5a
--- /dev/null
+++ b/secnotice/2018/008.xml
@@ -0,0 +1,225 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-008</id>
+
+  <summary>rtl8139 integer overflow accessing buffer</summary>
+
+  <description>
+<![CDATA[Qemu emulator built with the RTL8139 NIC emulation support is v=
ulnerable to an integer overflow, which could lead to buffer overflow iss=
ue. It could occur when receiving packets over the network.]]>
+  </description>
+
+  <impact>
+<![CDATA[A user inside guest could use this flaw to crash the Qemu proce=
ss resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Replace use of the RTL8139 network adapter with an alternative =
model]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Daniel Shapira</name>
+      <email>daniel@twistlock.com</email>
+    </reporter>
+    <patcher>
+      <name>Jason Wang</name>
+      <email>jasonwang@redhat.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180521</reported>
+    <published>20180926</published>
+    <fixed></fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-17958"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed"></tag>
+      <change state=3D"fixed">784b912f722bc86126b290c00de72c1bc8d34950</=
change>
+      <change state=3D"merged"></change>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <tag state=3D"vulnerable">v3.0.0</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/009.xml b/secnotice/2018/009.xml
new file mode 100644
index 0000000..6ad782f
--- /dev/null
+++ b/secnotice/2018/009.xml
@@ -0,0 +1,225 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-009</id>
+
+  <summary>pcnet integer overflow accessing buffer</summary>
+
+  <description>
+<![CDATA[Qemu emulator built with the AMD PC-Net II (Am79C970A) emulatio=
n support is vulnerable to an integer overflow, which could lead to buffe=
r overflow issue. It could occur when receiving packets over the network.=
]]>
+  </description>
+
+  <impact>
+<![CDATA[A user inside guest could use this flaw to crash the Qemu proce=
ss resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Replace use of the AMD PC-Net II network adapter with an altern=
ative model]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Daniel Shapira</name>
+      <email>daniel@twistlock.com</email>
+    </reporter>
+    <patcher>
+      <name>Jason Wang</name>
+      <email>jasonwang@redhat.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180521</reported>
+    <published>20180926</published>
+    <fixed></fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-17962"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed"></tag>
+      <change state=3D"fixed">2fc84f6b39577ccd6fd57bdd270902f5098c3a88</=
change>
+      <change state=3D"merged"></change>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <tag state=3D"vulnerable">v3.0.0</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.11</name>
+      <tag state=3D"vulnerable">v0.11.0</tag>
+      <tag state=3D"vulnerable">v0.11.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">4f1c942b7fb29864ad86cb3af9076da38f38f=
74e</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/010.xml b/secnotice/2018/010.xml
new file mode 100644
index 0000000..23719d4
--- /dev/null
+++ b/secnotice/2018/010.xml
@@ -0,0 +1,223 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-010</id>
+
+  <summary>Ignore network packet sizes larger than INT_MAX</summary>
+
+  <description>
+<![CDATA[A potential integer overflow issue was found in the QEMU emulat=
or. It could occur when a packet with large packet size is accepted and p=
rocessed.]]>
+  </description>
+
+  <impact>
+<![CDATA[A user inside guest could use this flaw to crash the Qemu proce=
ss resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[None]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Daniel Shapira</name>
+      <email>daniel@twistlock.com</email>
+    </reporter>
+    <patcher>
+      <name>Jason Wang</name>
+      <email>jasonwang@redhat.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180521</reported>
+    <published>20180926</published>
+    <fixed></fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-17963"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>master</name>
+      <tag state=3D"fixed"></tag>
+      <change state=3D"fixed">36772a6341af7c0f100b8e55a1e779db5fe818da</=
change>
+      <change state=3D"merged"></change>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <tag state=3D"vulnerable">v3.0.0</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-0.12</name>
+      <tag state=3D"vulnerable">v0.12.0</tag>
+      <tag state=3D"vulnerable">v0.12.1</tag>
+      <tag state=3D"vulnerable">v0.12.2</tag>
+      <tag state=3D"vulnerable">v0.12.3</tag>
+      <tag state=3D"vulnerable">v0.12.4</tag>
+      <tag state=3D"vulnerable">v0.12.5</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-0.13</name>
+      <tag state=3D"vulnerable">v0.13.0</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-0.14</name>
+      <tag state=3D"vulnerable">v0.14.0</tag>
+      <tag state=3D"vulnerable">v0.14.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">9a6ecb308b1c668fff84d56a356dbd595c51d=
556</change>
+    </branch>
+  </repository>
+
+</security-notice>
diff --git a/secnotice/2018/011.xml b/secnotice/2018/011.xml
new file mode 100644
index 0000000..811df0d
--- /dev/null
+++ b/secnotice/2018/011.xml
@@ -0,0 +1,199 @@
+<security-notice xmlns=3D"http://qemu.org/xmlns/security-notice/1.0">
+  <id>2018-011</id>
+
+  <summary>CCID integer overflow reading data</summary>
+
+  <description>
+<![CDATA[An integer overflow issue was found in the CCID Passthru card d=
evice emulation, while reading card data in ccid_card_vscard_read() funct=
ion. The ccid_card_vscard_read() function accepts a signed integer 'size'=
 argument, which is subsequently used as unsigned size_t value in memcpy(=
), copying large amounts of memory.
+]]>
+  </description>
+
+  <impact>
+<![CDATA[A user inside guest could use this flaw to crash the Qemu proce=
ss resulting in DoS.]]>
+  </impact>
+
+  <mitigation>
+<![CDATA[Remove the CCID device emulation from virtual machines]]>
+  </mitigation>
+
+  <credits>
+    <reporter>
+      <name>Arash Tohidi</name>
+      <email>tohidi.arash@gmail.com</email>
+    </reporter>
+    <patcher>
+      <name>Philippe Mathieu-Daud=C3=A9</name>
+      <email>philmd@redhat.com</email>
+    </patcher>
+  </credits>
+
+  <lifecycle>
+    <reported>20180726</reported>
+    <published>20181011</published>
+    <fixed></fixed>
+  </lifecycle>
+
+  <reference>
+    <advisory type=3D"CVE" id=3D"2018-18438"/>
+  </reference>
+
+  <repository>
+    <branch>
+      <name>master</name>
+      <change state=3D"fixed"></change>
+      <change state=3D"merged"></change>
+      <tag state=3D"fixed"></tag>
+      <tag state=3D"vulnerable">v1.0</tag>
+      <tag state=3D"vulnerable">v1.1.0</tag>
+      <tag state=3D"vulnerable">v1.2.0</tag>
+      <tag state=3D"vulnerable">v1.3.0</tag>
+      <tag state=3D"vulnerable">v1.4.0</tag>
+      <tag state=3D"vulnerable">v1.5.0</tag>
+      <tag state=3D"vulnerable">v1.6.0</tag>
+      <tag state=3D"vulnerable">v1.7.0</tag>
+      <tag state=3D"vulnerable">v2.0.0</tag>
+      <tag state=3D"vulnerable">v2.1.0</tag>
+      <tag state=3D"vulnerable">v2.2.0</tag>
+      <tag state=3D"vulnerable">v2.3.0</tag>
+      <tag state=3D"vulnerable">v2.4.0</tag>
+      <tag state=3D"vulnerable">v2.5.0</tag>
+      <tag state=3D"vulnerable">v2.6.0</tag>
+      <tag state=3D"vulnerable">v2.7.0</tag>
+      <tag state=3D"vulnerable">v2.8.0</tag>
+      <tag state=3D"vulnerable">v2.9.0</tag>
+      <tag state=3D"vulnerable">v2.10.0</tag>
+      <tag state=3D"vulnerable">v2.11.0</tag>
+      <tag state=3D"vulnerable">v2.12.0</tag>
+      <tag state=3D"vulnerable">v3.0.0</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-0.15</name>
+      <tag state=3D"vulnerable">v0.15.0</tag>
+      <tag state=3D"vulnerable">v0.15.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.0</name>
+      <tag state=3D"vulnerable">v1.0.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.1</name>
+      <tag state=3D"vulnerable">v1.1.1</tag>
+      <tag state=3D"vulnerable">v1.1.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.2</name>
+      <tag state=3D"vulnerable">v1.2.1</tag>
+      <tag state=3D"vulnerable">v1.2.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.3</name>
+      <tag state=3D"vulnerable">v1.3.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.4</name>
+      <tag state=3D"vulnerable">v1.4.1</tag>
+      <tag state=3D"vulnerable">v1.4.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.5</name>
+      <tag state=3D"vulnerable">v1.5.1</tag>
+      <tag state=3D"vulnerable">v1.5.2</tag>
+      <tag state=3D"vulnerable">v1.5.3</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.6</name>
+      <tag state=3D"vulnerable">v1.6.1</tag>
+      <tag state=3D"vulnerable">v1.6.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-1.7</name>
+      <tag state=3D"vulnerable">v1.7.1</tag>
+      <tag state=3D"vulnerable">v1.7.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.0</name>
+      <tag state=3D"vulnerable">v2.0.1</tag>
+      <tag state=3D"vulnerable">v2.0.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.1</name>
+      <tag state=3D"vulnerable">v2.1.1</tag>
+      <tag state=3D"vulnerable">v2.1.2</tag>
+      <tag state=3D"vulnerable">v2.1.3</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.2</name>
+      <tag state=3D"vulnerable">v2.2.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.3</name>
+      <tag state=3D"vulnerable">v2.3.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.4</name>
+      <tag state=3D"vulnerable">v2.4.0.1</tag>
+      <tag state=3D"vulnerable">v2.4.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.5</name>
+      <tag state=3D"vulnerable">v2.5.1</tag>
+      <tag state=3D"vulnerable">v2.5.1.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.6</name>
+      <tag state=3D"vulnerable">v2.6.1</tag>
+      <tag state=3D"vulnerable">v2.6.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.7</name>
+      <tag state=3D"vulnerable">v2.7.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.8</name>
+      <tag state=3D"vulnerable">v2.8.1</tag>
+      <tag state=3D"vulnerable">v2.8.1.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.9</name>
+      <tag state=3D"vulnerable">v2.9.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.10</name>
+      <tag state=3D"vulnerable">v2.10.1</tag>
+      <tag state=3D"vulnerable">v2.10.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.11</name>
+      <tag state=3D"vulnerable">v2.11.1</tag>
+      <tag state=3D"vulnerable">v2.11.2</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+    <branch>
+      <name>stable-2.12</name>
+      <tag state=3D"vulnerable">v2.12.1</tag>
+      <change state=3D"vulnerable">edbb21363fbfe40e050f583df921484cbc31c=
79d</change>
+    </branch>
+  </repository>
+
+</security-notice>
--=20
2.17.2
