Received: from eggs.gnu.org ([2001:4830:134:3::10]:53525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNIIu-00070W-Gn
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNIIq-0005KR-8x
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:07:32 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:48671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNIIo-0005H6-Nl
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:07:26 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 15:07:11 +0100
Message-Id: <cover.1542290622.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 0/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Hello,

This time as a new thread to help patchew. The only change is to use the
correct next version.

Regards
Simon Ruderich

Simon Ruderich (7):
  cpus: correct coding style in qmp_memsave/qmp_pmemsave
  cpus: convert qmp_memsave/qmp_pmemsave to use qemu_open
  cpus: use size_t in qmp_memsave/qmp_pmemsave
  hmp: use l for size argument in memsave/pmemsave
  hmp: use F for filename arguments in memsave/pmemsave
  qmp: add pmemload command
  hmp: add pmemload command

 cpus.c          | 85 +++++++++++++++++++++++++++++++++++++++++--------
 hmp-commands.hx | 18 +++++++++--
 hmp.c           | 16 ++++++++--
 hmp.h           |  1 +
 qapi/misc.json  | 20 ++++++++++++
 5 files changed, 122 insertions(+), 18 deletions(-)

Diff between v7 and v8:

    diff --git a/qapi/misc.json b/qapi/misc.json
    index 39f5e7dd38..e4f39e31e5 100644
    --- a/qapi/misc.json
    +++ b/qapi/misc.json
    @@ -1201,7 +1201,7 @@
    #
    # Returns: Nothing on success
    #
    -# Since: 3.2
    +# Since: 4.0
    ##
    { 'command': 'pmemload',
    'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }

-- 
2.19.1
