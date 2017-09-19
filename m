Received: from eggs.gnu.org ([2001:4830:134:3::10]:34795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duQBn-000534-NC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1duQBj-0003kA-PW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1duQBj-0003jh-Jl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:36:15 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Sep 2017 17:36:09 -0400
Message-Id: <20170919213611.8988-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] ppc: remove dead definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, thuth@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, John Snow <jsnow@redhat.com>

Following conversation from:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05362.html

Split into two patches:
(1) Definitions that match Igor's cleanup precisely
(2) Everything else I brazenly took a chainsaw to with little precision

(Only lightly tested.)

John Snow (2):
  ppc: remove unused CPU definitions
  ppc: remove all unused CPU definitions

 target/ppc/cpu-models.h | 255 ------------------------------------------------
 1 file changed, 255 deletions(-)

-- 
2.9.5
