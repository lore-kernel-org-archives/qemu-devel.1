Received: from eggs.gnu.org ([2001:4830:134:3::10]:51315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj50l-0002U2-MB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj50k-0000X8-Vx
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:50:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj50k-0000Wb-93
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:50:34 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2756e739-ae8c-1e5f-aa0f-80f908422f4b@redhat.com>
Date: Fri, 27 Jul 2018 10:50:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/23] migration-test: Make
 wait_command() return the "return" member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> All callers of wait_command() are only interested in the success
> response's "return" member.  Lift its extraction into wait_command().
> 
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/migration-test.c | 38 +++++++++++++++-----------------------
>   1 file changed, 15 insertions(+), 23 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
