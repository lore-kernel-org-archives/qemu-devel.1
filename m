Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6zxF-0002Sh-To
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6zxF-0002EK-1Q
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:45:33 -0400
References: <20180328133845.20632-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6e396823-f99c-2917-ccc5-04dda4a48f39@redhat.com>
Date: Fri, 13 Apr 2018 16:45:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180328133845.20632-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/dump-qcow2.pl: Script to dump
 qcow2 metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On 2018-03-28 15:38, Alberto Garcia wrote:
> This script takes a qcow2 image and dumps its metadata: header,
> snapshot table and some extensions (although not all qcow2 features
> are supported yet).
> 
> It can also display a list of all host clusters and the guest -> host
> address mappings, so it's useful to debug allocations.
> 
> The image is assumed not to be corrupted, and this script does not do
> consistency checks (yet).
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  scripts/dump-qcow2.pl | 425 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 425 insertions(+)
>  create mode 100755 scripts/dump-qcow2.pl

First of all: The main reason I haven't reviewed this so far is because
I don't like Perl.

OK, now that that's out of the way...  I'm wondering why you want to add
this to the qemu tree?  If you'd written an iotest that would make use
of it, sure.  But if it's just for debugging, then I'd personally think
it would be better to just add it to a private repository.  That would
give you more freedom to extend it, too.

(I know John has an own script for debugging qcow2 images.)

Of course the nice thing about putting it into the qemu repository would
be that people would be able to find it.  But then again, we could
probably achieve the same with a Wiki page.

Max
