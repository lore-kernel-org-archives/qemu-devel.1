Received: from eggs.gnu.org ([2001:4830:134:3::10]:45440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cristian.ancuta@intel.com>) id 1ebcJk-0004Ik-3m
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cristian.ancuta@intel.com>) id 1ebcJg-0004Tc-TI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:15:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:43027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cristian.ancuta@intel.com>)
	id 1ebcJg-0004RG-Kl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:15:00 -0500
From: "Ancuta, Cristian" <cristian.ancuta@intel.com>
Date: Wed, 17 Jan 2018 01:14:51 +0000
Message-ID: <54990469B118604BB659B7D5A1E9A462323C2A6E@HASMSX111.ger.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Qemu c++ build question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I'm not sure this is the right way to ask this question - and I appollogize=
 if it isn't - but here goes:

I'm currently working on implementing an emulation target in QEMU and the i=
mplementation is in C++.

I have the file qemu/target/mytarget/translate.cpp from which I #include <q=
emu/osdep.h> and osdep.h includes  "config-host.h".
When I run make it complains that config-host.h cannot be found.
This doesn't happen if I change the translate file from .cpp to .c

I only have a vague feeling that it has something to do with the C++ compil=
er and I've added the path where the header is located to the -extra-cxxfla=
gs when running the ./configure script, but it doesn't seem to pick it up.

Any help would be appreciated.

Thanks.
