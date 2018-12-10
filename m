Received: from eggs.gnu.org ([2001:4830:134:3::10]:55846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cristian.ancuta@intel.com>) id 1gWMhI-00085a-4T
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cristian.ancuta@intel.com>) id 1gWMhB-0008IJ-9u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:38:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:17038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cristian.ancuta@intel.com>)
	id 1gWMhA-0007qu-W6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:38:05 -0500
From: "Ancuta, Cristian" <cristian.ancuta@intel.com>
Date: Mon, 10 Dec 2018 14:37:55 +0000
Message-ID: <54990469B118604BB659B7D5A1E9A4623E80C70E@HASMSX111.ger.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [TCG SIMD] 128 bit SIMD support in the TCG backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

Hope this is the right place for this question.

I was wondering whether the TCG i386 backend is currently able to generate =
SIMD code ( vector loads/store, moves, vector arithmetic, etc ).

Looking around on patchwork I found these patches:

https://patchwork.kernel.org/project/qemu-devel/list/?submitter=3D172151

They seem to implement the vector support that I'd be interested in (includ=
ing support for tcg_gen_qemu_<ld/st>_v128 ) but I guess the patches didn't =
make it into any stable version?

Any info would be appreciated.

Thanks.
