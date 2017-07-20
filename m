Received: from eggs.gnu.org ([2001:4830:134:3::10]:49165)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYELb-0007cP-D4
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYELS-0006q0-VF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:30:38 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:52680 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYELS-0006pP-MA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:30:34 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-10-git-send-email-pl@kamp.de>
	<00d382b3-2dfa-b213-37c9-957a89c6c9dd@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <3afbbbec-a2dc-ce52-4cc6-aa84749a2e59@kamp.de>
Date: Thu, 20 Jul 2017 18:30:31 +0200
MIME-Version: 1.0
In-Reply-To: <00d382b3-2dfa-b213-37c9-957a89c6c9dd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 09/10] block/qcow2: add lzo compress
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

Am 20.07.2017 um 18:03 schrieb Eric Blake:
> On 07/20/2017 09:20 AM, Peter Lieven wrote:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/qcow2-cluster.c | 15 +++++++++++++++
>>  block/qcow2.c         | 42 +++++++++++++++++++++++++++++++++++-------
>>  configure             |  2 +-
>>  qapi/block-core.json  | 14 ++++++++++++--
>>  qemu-img.texi         |  1 +
>>  5 files changed, 64 insertions(+), 10 deletions(-)
> Where is the change to docs/ for updating the qcow2 spec to document the
> new format?
>

was lost during rebase. Will fix this.
