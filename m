Received: from eggs.gnu.org ([2001:4830:134:3::10]:52025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoHU-00046B-O8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoHN-0002Oe-3G
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:41:43 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a42ba6d6-352e-8128-c02b-2f383ccdc5f4@redhat.com>
Date: Wed, 19 Dec 2018 20:41:34 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/11] block/dirty-bitmap: remove
 assertion from restore
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
> When making a backup of a dirty bitmap (for transactions), we want to
> restore that backup whether or not the bitmap is enabled or not.

drop one of the two 'or not'

> 
> It is perfectly valid to write into bitmaps that are disabled. It is
> only illegitimate for the guest to have done so.
> 
> Remove this assertion.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/dirty-bitmap.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
