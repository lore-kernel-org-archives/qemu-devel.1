Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1deqUS-0000HG-Mb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1deqUN-00030M-MD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1deqUN-0002z9-GR
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3194C8123A
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 22:20:34 +0000 (UTC)
References: <20170804213625.3756-1-ehabkost@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a1163b4b-69b3-076c-b12c-4ff5a5356c0e@redhat.com>
Date: Mon, 7 Aug 2017 18:20:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170804213625.3756-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/5] qmp-shell non-interactive
 mode, delete scripts/qmp/qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com



On 08/04/2017 05:36 PM, Eduardo Habkost wrote:
> This series adds the ability to run QMP commands
> non-interactively to qmp-shell, and deletes scripts/qmp/qmp.
> 
> Eduardo Habkost (5):
>   qmp-shell: Use argparse module
>   qmp-shell: Pass split cmdargs to __build_cmd()
>   qmp-shell: execute_cmdargs() method
>   qmp-shell: Accept QMP command as argument
>   Remove scripts/qmp/qmp
> 
>  scripts/qmp/qmp       | 126 --------------------------------------------------
>  scripts/qmp/qmp-shell |  90 ++++++++++++++++--------------------
>  2 files changed, 40 insertions(+), 176 deletions(-)
>  delete mode 100755 scripts/qmp/qmp
> 

Assuming there are no reasons to keep the old script around (I certainly
never used it) this appears to be fine. May as well fortify one really
good QMP tool instead of a dozen little half baked ones.

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
