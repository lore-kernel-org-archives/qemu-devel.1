Received: from eggs.gnu.org ([2001:4830:134:3::10]:36405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrP-00081o-0R
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrO-0002JP-0p
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:51 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrN-0002J5-QB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:49 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so4057608wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:49 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	s26sm8814533wra.66.2017.02.24.09.40.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 09:40:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:27 +0100
Message-Id: <1487958030-51417-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/17] vmxcap: port to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 2220255..af8de15 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -27,9 +27,9 @@ MSR_IA32_VMX_VMFUNC = 0x491
 class msr(object):
     def __init__(self):
         try:
-            self.f = open('/dev/cpu/0/msr', 'r', 0)
+            self.f = open('/dev/cpu/0/msr', 'rb', 0)
         except:
-            self.f = open('/dev/msr0', 'r', 0)
+            self.f = open('/dev/msr0', 'rb', 0)
     def read(self, index, default = None):
         import struct
         self.f.seek(index)
@@ -49,7 +49,7 @@ class Control(object):
         val = m.read(nr, 0)
         return (val & 0xffffffff, val >> 32)
     def show(self):
-        print self.name
+        print(self.name)
         mbz, mb1 = self.read2(self.cap_msr)
         tmbz, tmb1 = 0, 0
         if self.true_cap_msr:
@@ -69,7 +69,7 @@ class Control(object):
                 s = 'forced'
             elif one and zero:
                 s = 'yes'
-            print '  %-40s %s' % (self.bits[bit], s)
+            print('  %-40s %s' % (self.bits[bit], s))
 
 class Misc(object):
     def __init__(self, name, bits, msr):
@@ -77,9 +77,9 @@ class Misc(object):
         self.bits = bits
         self.msr = msr
     def show(self):
-        print self.name
+        print(self.name)
         value = msr().read(self.msr, 0)
-        print '  Hex: 0x%x' % (value)
+        print('  Hex: 0x%x' % (value))
         def first_bit(key):
             if type(key) is tuple:
                 return key[0]
@@ -94,7 +94,7 @@ class Misc(object):
                 def fmt(x):
                     return { True: 'yes', False: 'no' }[x]
             v = (value >> lo) & ((1 << (hi - lo + 1)) - 1)
-            print '  %-40s %s' % (self.bits[bits], fmt(v))
+            print('  %-40s %s' % (self.bits[bits], fmt(v)))
 
 controls = [
     Misc(
-- 
1.8.3.1
