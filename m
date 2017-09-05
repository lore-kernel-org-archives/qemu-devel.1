Received: from eggs.gnu.org ([2001:4830:134:3::10]:33140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1dp5xK-0004Ne-FB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 00:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1dp5xF-0005zD-C4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 00:59:22 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:51077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1dp5xF-0005x7-3B
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 00:59:17 -0400
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <c749629a-3352-e2fc-812a-0a2489593c25@oracle.com>
Date: Mon, 4 Sep 2017 21:59:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] query-block io-status display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lcapitulino@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org

Hi Luiz, Markus and everyone.

I am working on a qemu enhancement to display io-status in each 
query-block command, not just those for devices which have werror and/or 
rerror set to stop on error.

I'd like to verify the reasons behind the query-block command not 
reporting io-status if errors were reported to the guest or ignored.  A 
clue may come from the original code review email[1] for when this code 
was implemented:

   "In case of multiple errors being triggered in sequence only the first
    one is stored. The I/O status is always reset to BDRV_IOS_OK when the
    'cont' command is issued."

 From this I infer:
- io-status is shown when qemu is stopped onerror so errors can be seen 
in cases where a guest does not handle them.
- io-status is not shown when errors are already being handled by a guest
- io-status is not shown when errors are ignored

Is this correct?  Are there other subtleties/reasons as well?

     Thanks,
     Jack

[1] http://lists.nongnu.org/archive/html/qemu-devel/2011-09/msg02940.html
