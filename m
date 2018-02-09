Received: from eggs.gnu.org ([2001:4830:134:3::10]:40405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1ek2qU-00089t-QC
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1ek2qQ-0003j2-TK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:11:42 -0500
Received: from [45.249.212.32] (port=42500 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiangyiwen@huawei.com>)
	id 1ek2qQ-0003gu-H9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:11:38 -0500
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5A7D4976.6060407@huawei.com>
Date: Fri, 9 Feb 2018 15:10:46 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [V9fs-developer] [RFC] we should solve
 create-unlink-getattr idiom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Van Hensbergen <ericvh@gmail.com>, Greg Kurz <groug@kaod.org>, v9fs-developer@lists.sourceforge.net, qemu-devel@nongnu.org
Cc: aneesh.kumar@linux.vnet.ibm.com, Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Veaceslav Falico <veaceslav.falico@huawei.com>

Hi Eric and Greg,

I encountered the similar problem with create-unlink-getattr idiom.
I use the testcase that create-unlink-setattr idiom, and I see the
bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
Then I also see you already fix the issue and push the patch to upstream.
https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
http://patchwork.ozlabs.org/patch/626194/

Unfortunately, the two patches are not merged into master, I don't know
the reason, so I suggest if the patche can be merged into master, and
it will solve the create-unlink-getattr idiom.

Thanks,
Yiwen
