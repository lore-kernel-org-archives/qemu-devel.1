Received: from eggs.gnu.org ([2001:4830:134:3::10]:56250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Ei-0001CL-4D
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Eg-0004tw-Jw
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:04 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 12:52:42 -0400
Message-Id: <cover.1504111803.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] qemu-iotests: place output in unique dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Differences v2 -> v3:

git-backport-diff -r qemu/master..devel-iotests -u github/devel-next
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [--] 'qemu-iotests: set TEST_DIR to a unique dir for each test'
      ^^^^^^
      No patch diff, but fixed typo in commit message. [Thanks Eric]


002/5:[0006] [FC] 'qemu-iotests: remove file cleanup from bash tests'
      ^^^^^^
      Picked up test 192 in the patch.

003/5:[down] 'qemu-iotests: add 'blind_remove' for python tests'
004/5:[down] 'qemu-iotests: make python tests attempt to leave intermediate files'
      ^^^^^^
      Two new tests, to help address python intermediate files.


005/5:[0005] [FC] 'qemu-iotests: add option to save temp files on error'
      ^^^^^^
      Added TODO regarding python tests. [Thanks Markus]
      Dropped Eric's r-b, in case he is not OK with the TODO wording


Rebased to v2.10.0.


This series does 2 things:

1.) Sets TEST_DIR to a unique subdirectory for each test
2.) Has './check' be responsible for removing temporary files
3.) Add option to './check' to retain temporary files in case of error


Jeff Cody (5):
  qemu-iotests: set TEST_DIR to a unique dir for each test
  qemu-iotests: remove file cleanup from bash tests
  qemu-iotests: add 'blind_remove' for python tests
  qemu-iotests: make python tests attempt to leave intermediate files
  qemu-iotests: add option to save temp files on error

 tests/qemu-iotests/001        |  6 ----
 tests/qemu-iotests/002        |  6 ----
 tests/qemu-iotests/003        |  6 ----
 tests/qemu-iotests/004        |  6 ----
 tests/qemu-iotests/005        |  6 ----
 tests/qemu-iotests/007        |  7 -----
 tests/qemu-iotests/008        |  6 ----
 tests/qemu-iotests/009        |  6 ----
 tests/qemu-iotests/010        |  6 ----
 tests/qemu-iotests/011        |  6 ----
 tests/qemu-iotests/012        |  6 ----
 tests/qemu-iotests/013        |  6 ----
 tests/qemu-iotests/014        |  6 ----
 tests/qemu-iotests/015        |  7 -----
 tests/qemu-iotests/017        |  6 ----
 tests/qemu-iotests/018        |  6 ----
 tests/qemu-iotests/019        |  8 -----
 tests/qemu-iotests/020        |  8 -----
 tests/qemu-iotests/021        |  6 ----
 tests/qemu-iotests/022        |  6 ----
 tests/qemu-iotests/023        |  6 ----
 tests/qemu-iotests/024        |  8 -----
 tests/qemu-iotests/025        |  6 ----
 tests/qemu-iotests/026        |  7 -----
 tests/qemu-iotests/027        |  6 ----
 tests/qemu-iotests/028        |  8 -----
 tests/qemu-iotests/029        |  7 -----
 tests/qemu-iotests/030        |  8 ++---
 tests/qemu-iotests/031        |  6 ----
 tests/qemu-iotests/032        |  6 ----
 tests/qemu-iotests/033        |  6 ----
 tests/qemu-iotests/034        |  6 ----
 tests/qemu-iotests/035        |  6 ----
 tests/qemu-iotests/036        |  6 ----
 tests/qemu-iotests/037        |  6 ----
 tests/qemu-iotests/038        |  6 ----
 tests/qemu-iotests/039        |  6 ----
 tests/qemu-iotests/040        | 35 +++++++++-------------
 tests/qemu-iotests/041        | 70 ++++++++++++++++++-------------------------
 tests/qemu-iotests/042        |  6 ----
 tests/qemu-iotests/043        |  7 -----
 tests/qemu-iotests/044        |  8 ++---
 tests/qemu-iotests/045        | 14 ++++-----
 tests/qemu-iotests/046        |  6 ----
 tests/qemu-iotests/047        |  6 ----
 tests/qemu-iotests/048        |  8 -----
 tests/qemu-iotests/048.out    |  1 -
 tests/qemu-iotests/049        |  6 ----
 tests/qemu-iotests/050        |  8 -----
 tests/qemu-iotests/051        |  6 ----
 tests/qemu-iotests/052        |  6 ----
 tests/qemu-iotests/053        |  7 -----
 tests/qemu-iotests/054        |  6 ----
 tests/qemu-iotests/055        | 36 ++++++++--------------
 tests/qemu-iotests/056        | 13 ++++----
 tests/qemu-iotests/057        |  6 ++--
 tests/qemu-iotests/058        |  8 +----
 tests/qemu-iotests/059        |  7 -----
 tests/qemu-iotests/060        |  6 ----
 tests/qemu-iotests/061        |  6 ----
 tests/qemu-iotests/062        |  6 ----
 tests/qemu-iotests/063        |  7 -----
 tests/qemu-iotests/064        |  6 ----
 tests/qemu-iotests/065        |  6 ++--
 tests/qemu-iotests/066        |  6 ----
 tests/qemu-iotests/068        |  6 ----
 tests/qemu-iotests/069        |  6 ----
 tests/qemu-iotests/070        |  6 ----
 tests/qemu-iotests/071        |  6 ----
 tests/qemu-iotests/072        |  6 ----
 tests/qemu-iotests/073        |  6 ----
 tests/qemu-iotests/074        |  9 ------
 tests/qemu-iotests/074.out    |  1 -
 tests/qemu-iotests/075        |  6 ----
 tests/qemu-iotests/076        |  6 ----
 tests/qemu-iotests/077        |  6 ----
 tests/qemu-iotests/078        |  6 ----
 tests/qemu-iotests/079        |  6 ----
 tests/qemu-iotests/080        |  7 -----
 tests/qemu-iotests/081        |  8 -----
 tests/qemu-iotests/082        |  6 ----
 tests/qemu-iotests/084        |  6 ----
 tests/qemu-iotests/085        | 13 +-------
 tests/qemu-iotests/086        |  6 ----
 tests/qemu-iotests/088        |  7 -----
 tests/qemu-iotests/089        |  6 ----
 tests/qemu-iotests/090        |  6 ----
 tests/qemu-iotests/091        |  8 +----
 tests/qemu-iotests/092        |  7 -----
 tests/qemu-iotests/094        |  9 +-----
 tests/qemu-iotests/095        |  8 +----
 tests/qemu-iotests/096        |  5 ++--
 tests/qemu-iotests/097        |  7 -----
 tests/qemu-iotests/098        |  7 -----
 tests/qemu-iotests/099        |  6 ----
 tests/qemu-iotests/101        |  6 ----
 tests/qemu-iotests/102        |  7 +----
 tests/qemu-iotests/103        |  6 ----
 tests/qemu-iotests/104        |  2 --
 tests/qemu-iotests/105        |  6 ----
 tests/qemu-iotests/106        |  6 ----
 tests/qemu-iotests/107        |  6 ----
 tests/qemu-iotests/108        |  6 ----
 tests/qemu-iotests/109        |  8 +----
 tests/qemu-iotests/110        |  6 ----
 tests/qemu-iotests/111        |  6 ----
 tests/qemu-iotests/112        |  6 ----
 tests/qemu-iotests/113        |  6 ----
 tests/qemu-iotests/114        |  6 ----
 tests/qemu-iotests/115        |  6 ----
 tests/qemu-iotests/116        |  6 ----
 tests/qemu-iotests/117        |  7 +----
 tests/qemu-iotests/118        | 31 +++++++++----------
 tests/qemu-iotests/119        |  6 ----
 tests/qemu-iotests/120        |  6 ----
 tests/qemu-iotests/121        |  6 ----
 tests/qemu-iotests/122        |  7 -----
 tests/qemu-iotests/123        |  7 -----
 tests/qemu-iotests/124        | 21 +++++--------
 tests/qemu-iotests/125        |  6 ----
 tests/qemu-iotests/130        |  7 +----
 tests/qemu-iotests/131        |  6 ----
 tests/qemu-iotests/132        |  9 ++----
 tests/qemu-iotests/133        |  6 ----
 tests/qemu-iotests/134        |  6 ----
 tests/qemu-iotests/135        |  6 ----
 tests/qemu-iotests/136        |  3 +-
 tests/qemu-iotests/137        |  6 ----
 tests/qemu-iotests/138        |  6 ----
 tests/qemu-iotests/139        |  6 ++--
 tests/qemu-iotests/140        |  8 +----
 tests/qemu-iotests/141        |  8 +----
 tests/qemu-iotests/142        |  7 -----
 tests/qemu-iotests/143        |  7 +----
 tests/qemu-iotests/144        |  8 +----
 tests/qemu-iotests/145        |  7 -----
 tests/qemu-iotests/146        |  7 +----
 tests/qemu-iotests/147        | 16 ++++------
 tests/qemu-iotests/148        |  7 +++--
 tests/qemu-iotests/150        |  6 ----
 tests/qemu-iotests/152        |  9 ++----
 tests/qemu-iotests/153        | 12 --------
 tests/qemu-iotests/154        |  6 ----
 tests/qemu-iotests/155        | 15 ++++------
 tests/qemu-iotests/156        |  7 +----
 tests/qemu-iotests/157        |  6 ----
 tests/qemu-iotests/158        |  6 ----
 tests/qemu-iotests/159        |  7 -----
 tests/qemu-iotests/160        |  7 -----
 tests/qemu-iotests/162        |  7 -----
 tests/qemu-iotests/165        |  6 ++--
 tests/qemu-iotests/170        |  7 -----
 tests/qemu-iotests/171        |  6 ----
 tests/qemu-iotests/172        |  8 -----
 tests/qemu-iotests/173        |  8 +----
 tests/qemu-iotests/174        |  6 ----
 tests/qemu-iotests/175        |  6 ----
 tests/qemu-iotests/176        |  7 -----
 tests/qemu-iotests/177        |  6 ----
 tests/qemu-iotests/178        |  7 -----
 tests/qemu-iotests/179        |  7 -----
 tests/qemu-iotests/181        |  8 +----
 tests/qemu-iotests/182        |  6 ----
 tests/qemu-iotests/183        |  9 +-----
 tests/qemu-iotests/185        |  9 +-----
 tests/qemu-iotests/186        |  6 ----
 tests/qemu-iotests/187        |  8 -----
 tests/qemu-iotests/188        |  6 ----
 tests/qemu-iotests/189        |  6 ----
 tests/qemu-iotests/190        |  7 -----
 tests/qemu-iotests/192        |  6 ----
 tests/qemu-iotests/check      | 29 +++++++++++++++---
 tests/qemu-iotests/common     |  6 ++++
 tests/qemu-iotests/iotests.py |  7 +++++
 174 files changed, 187 insertions(+), 1163 deletions(-)

-- 
2.9.5
