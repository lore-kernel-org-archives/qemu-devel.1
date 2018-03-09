Received: from eggs.gnu.org ([2001:4830:134:3::10]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euN9q-0002d7-2V
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euN9p-0006mj-8g
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:54:22 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-8-git-send-email-vsementsov@virtuozzo.com>
	<29155e4e-9a6f-78e5-27ae-4eaef68c5d9c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <15affea5-9808-bd0e-9c80-5b79842f47be@virtuozzo.com>
Date: Fri, 9 Mar 2018 21:54:08 +0300
MIME-Version: 1.0
In-Reply-To: <29155e4e-9a6f-78e5-27ae-4eaef68c5d9c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests.py: tiny refactor: move system
 imports up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 23:44, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/iotests.py | 5 +++--
>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>
> What breaks if they aren't moved?=C2=A0 But stylistically, this looks=20
> reasonable; and can be merged independently of NBD stuff if someone=20
> else wants.

This movement also make it a bit nearer to PEP8, as it dislike "E402=20
module level import not at top of file", because of "sys.path.append"=20
before imports.. So, I'd just saved as many imports as I could)

>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>


--=20
Best regards,
Vladimir
