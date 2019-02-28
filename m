Received: from eggs.gnu.org ([209.51.188.92]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danmei.wei@intel.com>) id 1gzBwZ-0006JN-3I
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danmei.wei@intel.com>) id 1gzBwT-0002vk-Ka
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:01:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:60866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danmei.wei@intel.com>)
	id 1gzBwL-0001s7-3Y
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:00:57 -0500
From: "Wei, Danmei" <danmei.wei@intel.com>
Date: Thu, 28 Feb 2019 03:00:29 +0000
Message-ID: <38A2C2D0FB356A4785EEFA56D99BFB2B0B718883@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Qemu build failure with uninitialized variables when
 "-Wmaybe-uninitialized" is open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Hao, Xudong" <xudong.hao@intel.com>

Hi,

When we build qemu with "-Wmaybe-uninitialized" on, and got the following e=
rror information.
  CC      qobject/json-streamer.o
  CC      qobject/json-parser.o
  CC      qobject/block-qdict.o
qobject/block-qdict.c: In function 'qdict_array_split':
qobject/block-qdict.c:259:25: error: 'subqdict' may be used uninitialized i=
n this function [-Werror=3Dmaybe-uninitialized]
         qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
                         ^
cc1: all warnings being treated as errors
make: *** [qobject/block-qdict.o] Error 1

It is because of the uninitialized variable subqdict function qdict_array_s=
plit.
Thanks to confirm it.

Below is the ENV Setting:
OS: RHEL OS 7.6
Qemu Version: commit c102d9471f8f02d9fbea72ec4505d7089173f470
CFLAGS Setting in env: export CFLAGS=3D"-g -O3 -Wmaybe-uninitialized"

Thanks,
               Danmei
