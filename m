Received: from eggs.gnu.org ([2001:4830:134:3::10]:46575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG40W-0007JI-G8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG40V-0006bh-OS
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:54:24 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-17-git-send-email-mst@redhat.com>
	<87wowe8hiw.fsf@secure.laptop>
	<66f76f0b-6153-711e-6ebd-cacaeb0032fc@redhat.com>
	<8736z28bn1.fsf@secure.laptop>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6aa9c9d-54f6-4c17-de0f-c43f5afc4f8b@redhat.com>
Date: Tue, 8 May 2018 09:54:06 -0500
MIME-Version: 1.0
In-Reply-To: <8736z28bn1.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/67] migration: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On 05/08/2018 09:28 AM, Juan Quintela wrote:

>>> My wonder here is what happens if we end with a file with the same name in
>>> two places.
>>
>> We already have at least:
>>
>> include/qapi/qmp/qjson.h
>> migration/qjson.h
>>
>> so it's not necessarily a theoretical question (things work now, but
>> renaming one or the other header may be in order as part of
>> consolidating everything into the /include hierarchy)
> 
> Internal ones also?  The whole reason why I moved them to migration/* in
> the first place was to be sure that they are internal, and that nobody
> else uses them.
> 
> Later, Juan.
> 
> PD.  And yes, I realize that we include $(ROOT) in the include path, and
> then
> 
> #include "migration/migration.h" still works from any place.

I think the goal of this series was to remove $(ROOT) from the include 
path, so that all headers are either internal or obviously shared (and 
one of the review comments mentioned that all of the earlier commits in 
the series should directly mention this goal as part of the commit 
message, rather than claiming just "works more or less by accident"). 
It's been a good RFC for getting feedback, and some of the patches are 
worth applying even if others get reworked, but there are definitely 
some questions to be resolved before v2 of the series.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
