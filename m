Received: from eggs.gnu.org ([2001:4830:134:3::10]:50153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJ0o-0003yo-Fh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJ0n-0006Is-NB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:19:58 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-4-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7d8d6005-8cdb-6f5d-68a8-763a5e4623cb@redhat.com>
Date: Mon, 14 May 2018 15:19:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/42] blockjob: Move RateLimit to BlockJob
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:25 PM, Kevin Wolf wrote:
> Every block job has a RateLimit, and they all do the exact same thing
> with it, so it should be common infrastructure. Move the struct field
> for a start.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
