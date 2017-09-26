Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwvLb-0005uH-Nm
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwvLa-0006qZ-UE
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:16:47 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-7-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e0e735e7-bb46-70c4-67ac-e84c943bf65c@redhat.com>
Date: Tue, 26 Sep 2017 15:16:37 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/23] qemu-img: Switch
 get_block_status() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting
> an internal function (no semantic change), and simplifying its
> caller accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
