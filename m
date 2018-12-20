Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoQ3-0007Df-K9
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoQ2-0004W5-S0
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:50:39 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-9-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c52379d-68f0-34ef-c755-76592a90e828@redhat.com>
Date: Wed, 19 Dec 2018 20:50:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/11] iotests: remove default filters
 from qmp_log
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
> 
> To have qmp_log use log's serialization, qmp_log will need to
> accept only qmp filters, not text filters.
> 
> However, only a single caller of qmp_log actually requires any
> filters at all. I remove the default filter and add it explicitly
> to the caller in preparation for refactoring qmp_log to use rich
> filters instead.
> 
> test 206 is amended to name the filter explicitly and the default
> is removed.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/206        | 8 ++++++--
>   tests/qemu-iotests/iotests.py | 2 +-
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
