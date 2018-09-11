Received: from eggs.gnu.org ([2001:4830:134:3::10]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzdyQ-0000uo-Li
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzdyN-0008Cj-HZ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:24:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4c74aa1e-8a92-2359-4893-eec8681a6790@redhat.com>
References: <20180809134413.30823-1-berto@igalia.com>
	<4c74aa1e-8a92-2359-4893-eec8681a6790@redhat.com>
Date: Tue, 11 Sep 2018 10:24:31 +0200
Message-ID: <w518t48phkw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qcow2: Release dirty
 entries with cache-clean-interval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 10 Sep 2018 09:22:01 PM CEST, John Snow wrote:
> On 08/09/2018 09:44 AM, Alberto Garcia wrote:
>> The cache-clean-interval option is used to periodically release unused
>> entries from the L2 and refcount caches. Dirty cache entries are left
>> untouched, even if they are otherwise valid candidates for removal.
>> 
>> This patch allows releasing those entries by flushing them to disk
>> first. This is a blocking operation, so we need to do it in coroutine
>> context.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> This hit over a month old today, do we still want this for 3.1?

Well, it needs to be reviewed first :)

Berto
