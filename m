Received: from eggs.gnu.org ([2001:4830:134:3::10]:55140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoUg-0000aL-4O
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoUf-0000hx-Bk
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:55:26 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-11-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f97e90a4-13c7-1efc-a1ca-6886ae05c72a@redhat.com>
Date: Wed, 19 Dec 2018 20:55:14 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-11-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/11] iotests: implement pretty-print
 for log and qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

On 12/19/18 8:29 PM, John Snow wrote:
> If iotests have lines exceeding >998 characters long, git doesn't
> want to send it plaintext to the list. We can solve this by allowing
> the iotests to use pretty printed QMP output that we can match against
> instead.
> 
> As a bonus, it's much nicer for human eyes too.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
