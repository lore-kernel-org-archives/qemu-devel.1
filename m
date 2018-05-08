Received: from eggs.gnu.org ([2001:4830:134:3::10]:51964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG2Px-0001na-N8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG2Pt-00010Q-QQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:12:33 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-17-git-send-email-mst@redhat.com>
	<87wowe8hiw.fsf@secure.laptop>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66f76f0b-6153-711e-6ebd-cacaeb0032fc@redhat.com>
Date: Tue, 8 May 2018 08:12:14 -0500
MIME-Version: 1.0
In-Reply-To: <87wowe8hiw.fsf@secure.laptop>
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
To: quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On 05/08/2018 07:21 AM, Juan Quintela wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> When pulling in headers that are in the same directory as C file (as
>> opposed to one in include/), we should use its relative path, without a
>> directory. Directory based path works more or less by accident.
> 
> No, it is not by accident.
> qemu-version.h and config-host.h are on the root directory.  I could
> agree with moving them.
> 

>> -#include "migration/qemu-file.h"
>> +#include "qemu-file.h"
> 
> Substitite for "./qemu-file.h"?
> 
> My wonder here is what happens if we end with a file with the same name in
> two places.

We already have at least:

include/qapi/qmp/qjson.h
migration/qjson.h

so it's not necessarily a theoretical question (things work now, but 
renaming one or the other header may be in order as part of 
consolidating everything into the /include hierarchy)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
