Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZobU-0002Hr-7U
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZobT-0005Bk-9k
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:02:28 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-12-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca1a1d6f-495a-ebc6-353e-77769a52fe29@redhat.com>
Date: Wed, 19 Dec 2018 21:02:14 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-12-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/11] iotests: add iotest 236 for
 testing bitmap merge
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
> New interface, new smoke test.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/236     | 161 +++++++++++++++++
>   tests/qemu-iotests/236.out | 351 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 513 insertions(+)
>   create mode 100755 tests/qemu-iotests/236
>   create mode 100644 tests/qemu-iotests/236.out
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

(and glad that my insistence on beefing up the test has caught bugs)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
