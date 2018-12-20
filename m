Received: from eggs.gnu.org ([2001:4830:134:3::10]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoTE-00087T-Mg
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoTC-0007jb-Mu
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:53:56 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-10-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <577432c1-bfeb-5b56-fea3-24bd50e23825@redhat.com>
Date: Wed, 19 Dec 2018 20:53:35 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/11] iotests: change qmp_log filters
 to expect QMP objects only
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
> As laid out in the previous commit's message:
> 
> ```
> Several places in iotests deal with serializing objects into JSON
> strings, but to add pretty-printing it seems desireable to localize

s/desireable/desirable/

> all of those cases.
> 
> log() seems like a good candidate for that centralized behavior.
> log() can already serialize json objects, but when it does so,
> it assumes filters=[] operates on QMP objects, not strings.
> 
> qmp_log currently operates by dumping outgoing and incoming QMP
> objects into strings and filtering them assuming that filters=[]
> are string filters.
> ```
> 
> Therefore:
> 
> Change qmp_log to treat filters as if they're always qmp object filters,
> then change the logging call to rely on log()'s ability to serialize QMP
> objects, so we're not duplicating that effort.
> 
> Add a qmp version of filter_testfiles and adjust the only caller using
> it for qmp_log to use the qmp version.
> 
> Signed-off-by: John Snow  <jsnow@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Odd double S-o-B differing only by space.

> ---
>   tests/qemu-iotests/206        |  4 ++--
>   tests/qemu-iotests/iotests.py | 24 +++++++++++++++++++++---
>   2 files changed, 23 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
