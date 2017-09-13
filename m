Received: from eggs.gnu.org ([2001:4830:134:3::10]:54583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsD1U-0005ZW-KL
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsD1T-0004lz-Np
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:08:32 -0400
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ab1516cb-9590-0833-b872-0e691e8ace49@redhat.com>
Date: Wed, 13 Sep 2017 15:08:22 -0400
MIME-Version: 1.0
In-Reply-To: <1505298088-10878-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Clean up some bad code
 in the vvfat driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 06:21 AM, Thomas Huth wrote:
> Remove the unnecessary home-grown redefinition of the assert() macro here,
> and remove the unusable debug code at the end of the checkpoint() function.
> The code there uses assert() with side-effects (assignment to the "mapping"
> variable), which should be avoided. Looking more closely, it seems as it is
> apparently also only usable for one certain directory layout (with a file
> named USB.H in it) and thus is of no use for the rest of the world.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Farewell, bitrot code.

Reviewed-by: John Snow <jsnow@redhat.com>

Out of curiosity, I wonder ...

jhuston@probe (foobar) ~/s/qemu> git grep '#if 0' | wc -l
320

oh no
