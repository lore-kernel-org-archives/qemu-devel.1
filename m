Received: from eggs.gnu.org ([2001:4830:134:3::10]:41302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vmb-00064x-G5
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vma-0007Bz-Ie
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:17:37 -0400
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c5478282-8502-602b-b746-475cc5a9555d@virtuozzo.com>
Date: Fri, 30 Mar 2018 18:17:25 +0300
MIME-Version: 1.0
In-Reply-To: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for 2.12 0/3] iotests: blacklist bochs and
 cloop for 205 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, den@openvz.org

for 2.12

30.03.2018 18:16, Vladimir Sementsov-Ogievskiy wrote:
> Blacklist these formats, as they don't support image creation, as they
> say:
>      > ./qemu-img create -f bochs x 1m
>      qemu-img: x: Format driver 'bochs' does not support image creation
>
>      > ./qemu-img create -f cloop x 1m
>      qemu-img: x: Format driver 'cloop' does not support image creation
>
> Vladimir Sementsov-Ogievskiy (3):
>    iotests.py: improve verify_image_format helper
>    iotests.py: support unsupported_fmts in main()
>    iotests: blacklist bochs and cloop for 205 and 208
>
>   tests/qemu-iotests/205        |  2 +-
>   tests/qemu-iotests/208        |  2 ++
>   tests/qemu-iotests/iotests.py | 11 ++++++-----
>   3 files changed, 9 insertions(+), 6 deletions(-)
>


-- 
Best regards,
Vladimir
