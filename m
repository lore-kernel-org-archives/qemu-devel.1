Received: from eggs.gnu.org ([2001:4830:134:3::10]:45489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBMGF-0000ht-IE
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBMGA-0003L8-N8
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:50:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBMGA-0003KW-He
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:50:50 -0500
Date: Sun, 5 Nov 2017 09:50:48 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <933836135.17566227.1509893448345.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] broken --enable-crypto-afalg?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org

Seen on both RHEL7 and Ubuntu:

$ gtester -k --verbose -m=quick tests/test-crypto-hash
TEST: tests/test-crypto-hash... (pid=96313)
  /crypto/hash/iov:                                                    FAIL
GTester: last random seed: R02S1fb9dd7b21cb29ff371b0d53bccdf6e4
(pid=96315)
  /crypto/hash/alloc:                                                  FAIL
GTester: last random seed: R02S7d4a497cd03a646b3fcef4a56de90b00
(pid=96316)
  /crypto/hash/prealloc:                                               FAIL
GTester: last random seed: R02S72a273f4764f8b080364ddeb83b7f889
(pid=96317)
  /crypto/hash/digest:                                                 FAIL
GTester: last random seed: R02S6ae0ac44ab193219f9934878cccc7dae
(pid=96318)
  /crypto/hash/base64:                                                 FAIL
GTester: last random seed: R02S425dc43b4dd05127b42896bb02fce05b
(pid=96319)
FAIL: tests/test-crypto-hash
make: *** [check-tests/test-crypto-hash] Error 1

Paolo
