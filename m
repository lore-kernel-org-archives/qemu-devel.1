Received: from eggs.gnu.org ([209.51.188.92]:53703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK9mJ-0004Qx-1N
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 18:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hK9mH-0001DW-Vw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 18:57:10 -0400
References: <20190413152037.6817-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <61bbf7b7-2f4d-bc4d-f8f5-528e3ed2062c@redhat.com>
Date: Fri, 26 Apr 2019 18:57:03 -0400
MIME-Version: 1.0
In-Reply-To: <20190413152037.6817-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-next 0/2] qemu-img: Make
 create hint at protocol options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 4/13/19 11:20 AM, Max Reitz wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1698863 reports that while
> "qemu-img create -f raw" supports the "preallocation" option, it is not
> listed under "-o help".
> 
> It turns out it is, but only if you specify a target filename.  Users
> may not realize this, but a note should help.
> 
> 
> Max Reitz (2):
>   iotests: Perform the correct test in 082
>   qemu-img: Make create hint at protocol options
> 
>  qemu-img.c                 | 13 ++++++++++++-
>  tests/qemu-iotests/082     |  5 ++++-
>  tests/qemu-iotests/082.out | 25 ++++++++++++++++++-------
>  3 files changed, 34 insertions(+), 9 deletions(-)
> 

Seems like an improvement to me.

Reviewed-by: John Snow <jsnow@redhat.com>
