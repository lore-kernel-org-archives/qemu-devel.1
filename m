Received: from eggs.gnu.org ([2001:4830:134:3::10]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1fqYV9-0005dW-0G
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1fqYV4-0007Rx-Ud
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:44:50 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:64776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1fqYV3-0007K1-2X
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:44:46 -0400
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <56f721bc-6e1d-05de-2f6b-c410f4dee711@profihost.ag>
Date: Fri, 17 Aug 2018 08:44:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Qemu and Spectre_V4 + l1tf + IBRS_FW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

i haven't found anything on the web regarding qemu and mentioned variants.

While my host says:
l1tf:Mitigation: PTE Inversion; VMX: SMT vulnerable, L1D conditional
cache flushes
meltdown:Mitigation: PTI
spec_store_bypass:Mitigation: Speculative Store Bypass disabled via
prctl and seccomp
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Mitigation: Full generic retpoline, IBPB, IBRS_FW

My guests bootet with pcid and spec-ctrl only say:
l1tf:Mitigation: PTE Inversion
meltdown:Mitigation: PTI
spec_store_bypass:Vulnerable
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Mitigation: Full generic retpoline, IBPB

* What is about spec_store_bypass in Qemu?
* What is about IBRS_FW feature?
* What is about L1TF?

Or are those just irrelevant to Qemu guests? Would be great to have some
informations.

Thanks a lot!

Greets,
Stefan
