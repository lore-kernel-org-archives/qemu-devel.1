Received: from eggs.gnu.org ([2001:4830:134:3::10]:39788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfc-000563-GO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfY-00052j-EQ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:44 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:38648)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfW-0004mP-KB
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:40 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 24 Oct 2018 17:40:48 +0800
Message-Id: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Do some cleaning work in qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

POSIX requires $PWD to be reliable, and we expect all
shells used by qemu scripts to be relatively close to
POSIX.  Thus, it is smarter to avoid forking the pwd
executable for something that is already available in
the environment.
 
In addtion, clean up unused variable here and use $()
to instead of obsolete `` in some script files.
 
v2:
-add patch2
-split the patch1 of v1 into patch1 and patch3
                                                 [ Eric Blake ]
 
Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: eblake@redhat.com

Mao Zhongyi (3):
  qemu-iotests: convert `pwd` and $(pwd) to $PWD
  qemu-iotests: remove unused variable here
  qemu-iotests: Modern shell scripting (use $() instead of ``)

 configure                        |  2 +-
 tests/check-block.sh             |  6 ++--
 tests/qemu-iotests/001           |  1 -
 tests/qemu-iotests/002           |  1 -
 tests/qemu-iotests/003           |  1 -
 tests/qemu-iotests/004           |  1 -
 tests/qemu-iotests/005           |  1 -
 tests/qemu-iotests/007           |  1 -
 tests/qemu-iotests/008           |  1 -
 tests/qemu-iotests/009           |  1 -
 tests/qemu-iotests/010           |  1 -
 tests/qemu-iotests/011           |  1 -
 tests/qemu-iotests/012           |  1 -
 tests/qemu-iotests/013           |  1 -
 tests/qemu-iotests/014           |  1 -
 tests/qemu-iotests/015           |  1 -
 tests/qemu-iotests/017           |  1 -
 tests/qemu-iotests/018           |  1 -
 tests/qemu-iotests/019           |  1 -
 tests/qemu-iotests/020           |  1 -
 tests/qemu-iotests/021           |  1 -
 tests/qemu-iotests/022           |  1 -
 tests/qemu-iotests/023           |  1 -
 tests/qemu-iotests/024           |  1 -
 tests/qemu-iotests/025           |  1 -
 tests/qemu-iotests/026           |  1 -
 tests/qemu-iotests/027           |  1 -
 tests/qemu-iotests/028           |  1 -
 tests/qemu-iotests/029           |  1 -
 tests/qemu-iotests/031           |  1 -
 tests/qemu-iotests/032           |  1 -
 tests/qemu-iotests/033           |  1 -
 tests/qemu-iotests/034           |  1 -
 tests/qemu-iotests/035           |  1 -
 tests/qemu-iotests/036           |  1 -
 tests/qemu-iotests/037           |  1 -
 tests/qemu-iotests/038           |  1 -
 tests/qemu-iotests/039           |  1 -
 tests/qemu-iotests/042           |  1 -
 tests/qemu-iotests/043           |  1 -
 tests/qemu-iotests/046           |  1 -
 tests/qemu-iotests/047           |  1 -
 tests/qemu-iotests/049           |  1 -
 tests/qemu-iotests/050           |  1 -
 tests/qemu-iotests/051           |  1 -
 tests/qemu-iotests/052           |  1 -
 tests/qemu-iotests/053           |  1 -
 tests/qemu-iotests/054           |  1 -
 tests/qemu-iotests/058           |  1 -
 tests/qemu-iotests/059           |  1 -
 tests/qemu-iotests/060           |  1 -
 tests/qemu-iotests/061           |  1 -
 tests/qemu-iotests/062           |  1 -
 tests/qemu-iotests/063           |  1 -
 tests/qemu-iotests/064           |  1 -
 tests/qemu-iotests/066           |  1 -
 tests/qemu-iotests/067           |  1 -
 tests/qemu-iotests/068           |  1 -
 tests/qemu-iotests/069           |  1 -
 tests/qemu-iotests/070           |  1 -
 tests/qemu-iotests/071           |  1 -
 tests/qemu-iotests/072           |  1 -
 tests/qemu-iotests/073           |  1 -
 tests/qemu-iotests/075           |  1 -
 tests/qemu-iotests/076           |  1 -
 tests/qemu-iotests/077           |  1 -
 tests/qemu-iotests/078           |  1 -
 tests/qemu-iotests/079           |  1 -
 tests/qemu-iotests/080           |  1 -
 tests/qemu-iotests/081           |  1 -
 tests/qemu-iotests/082           |  1 -
 tests/qemu-iotests/083           |  1 -
 tests/qemu-iotests/084           |  1 -
 tests/qemu-iotests/085           |  1 -
 tests/qemu-iotests/086           |  1 -
 tests/qemu-iotests/087           |  1 -
 tests/qemu-iotests/088           |  1 -
 tests/qemu-iotests/089           |  1 -
 tests/qemu-iotests/090           |  1 -
 tests/qemu-iotests/091           |  1 -
 tests/qemu-iotests/092           |  1 -
 tests/qemu-iotests/094           |  1 -
 tests/qemu-iotests/095           |  1 -
 tests/qemu-iotests/097           |  1 -
 tests/qemu-iotests/098           |  1 -
 tests/qemu-iotests/099           |  1 -
 tests/qemu-iotests/101           |  1 -
 tests/qemu-iotests/102           |  1 -
 tests/qemu-iotests/103           |  1 -
 tests/qemu-iotests/104           |  1 -
 tests/qemu-iotests/105           |  1 -
 tests/qemu-iotests/106           |  1 -
 tests/qemu-iotests/107           |  1 -
 tests/qemu-iotests/108           |  1 -
 tests/qemu-iotests/109           |  1 -
 tests/qemu-iotests/110           |  1 -
 tests/qemu-iotests/111           |  1 -
 tests/qemu-iotests/112           |  1 -
 tests/qemu-iotests/113           |  1 -
 tests/qemu-iotests/114           |  1 -
 tests/qemu-iotests/115           |  1 -
 tests/qemu-iotests/116           |  1 -
 tests/qemu-iotests/117           |  1 -
 tests/qemu-iotests/119           |  1 -
 tests/qemu-iotests/120           |  1 -
 tests/qemu-iotests/121           |  1 -
 tests/qemu-iotests/122           |  1 -
 tests/qemu-iotests/123           |  1 -
 tests/qemu-iotests/125           |  1 -
 tests/qemu-iotests/126           |  1 -
 tests/qemu-iotests/127           |  1 -
 tests/qemu-iotests/128           |  1 -
 tests/qemu-iotests/130           |  1 -
 tests/qemu-iotests/131           |  1 -
 tests/qemu-iotests/133           |  1 -
 tests/qemu-iotests/134           |  1 -
 tests/qemu-iotests/135           |  1 -
 tests/qemu-iotests/137           |  1 -
 tests/qemu-iotests/138           |  1 -
 tests/qemu-iotests/140           |  1 -
 tests/qemu-iotests/141           |  1 -
 tests/qemu-iotests/142           |  1 -
 tests/qemu-iotests/143           |  1 -
 tests/qemu-iotests/144           |  1 -
 tests/qemu-iotests/145           |  1 -
 tests/qemu-iotests/146           |  1 -
 tests/qemu-iotests/150           |  1 -
 tests/qemu-iotests/153           |  1 -
 tests/qemu-iotests/154           |  1 -
 tests/qemu-iotests/156           |  1 -
 tests/qemu-iotests/157           |  1 -
 tests/qemu-iotests/158           |  1 -
 tests/qemu-iotests/159           |  1 -
 tests/qemu-iotests/160           |  1 -
 tests/qemu-iotests/162           |  1 -
 tests/qemu-iotests/170           |  1 -
 tests/qemu-iotests/171           |  1 -
 tests/qemu-iotests/172           |  1 -
 tests/qemu-iotests/173           |  1 -
 tests/qemu-iotests/174           |  1 -
 tests/qemu-iotests/175           |  1 -
 tests/qemu-iotests/176           |  1 -
 tests/qemu-iotests/177           |  1 -
 tests/qemu-iotests/178           |  1 -
 tests/qemu-iotests/179           |  1 -
 tests/qemu-iotests/181           |  1 -
 tests/qemu-iotests/182           |  1 -
 tests/qemu-iotests/183           |  1 -
 tests/qemu-iotests/184           |  1 -
 tests/qemu-iotests/185           |  1 -
 tests/qemu-iotests/186           |  1 -
 tests/qemu-iotests/187           |  1 -
 tests/qemu-iotests/188           |  1 -
 tests/qemu-iotests/189           |  1 -
 tests/qemu-iotests/190           |  1 -
 tests/qemu-iotests/191           |  1 -
 tests/qemu-iotests/192           |  1 -
 tests/qemu-iotests/195           |  1 -
 tests/qemu-iotests/197           |  1 -
 tests/qemu-iotests/198           |  1 -
 tests/qemu-iotests/200           |  1 -
 tests/qemu-iotests/204           |  1 -
 tests/qemu-iotests/214           |  1 -
 tests/qemu-iotests/215           |  1 -
 tests/qemu-iotests/221           |  1 -
 tests/qemu-iotests/223           |  1 -
 tests/qemu-iotests/225           |  1 -
 tests/qemu-iotests/226           |  1 -
 tests/qemu-iotests/227           |  1 -
 tests/qemu-iotests/229           |  1 -
 tests/qemu-iotests/231           |  1 -
 tests/qemu-iotests/check         | 62 ++++++++++++++++----------------
 tests/qemu-iotests/common.config |  6 ++--
 tests/qemu-iotests/common.rc     |  2 +-
 174 files changed, 39 insertions(+), 208 deletions(-)

-- 
2.17.1
