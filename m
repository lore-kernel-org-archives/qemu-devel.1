Received: from eggs.gnu.org ([2001:4830:134:3::10]:57349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7nyR-0007Uf-21
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7nyQ-000612-3v
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:42:22 -0400
References: <20181003180426.602765-1-eblake@redhat.com>
	<a6439e4c-a5ac-ed0a-0d6f-2dac91c0f93f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58c7e658-a835-b31b-1445-346e2361edec@redhat.com>
Date: Wed, 3 Oct 2018 15:42:03 -0500
MIME-Version: 1.0
In-Reply-To: <a6439e4c-a5ac-ed0a-0d6f-2dac91c0f93f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-nbd: Document --tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, berrange@redhat.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 10/3/18 3:35 PM, John Snow wrote:
> 
> 
> On 10/03/2018 02:04 PM, Eric Blake wrote:
>> Commit 145614a1 introduced --tls-creds, but forgot to document
>> it in 'qemu-nbd --help'.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> Do we have a manpage/texi that needs to update, too?

No; commit 145614a1 already covered that in qemu-nbd.texi.  It's just 
the --help output that needs it. I can tweak the commit message to 
mention that, if it helps.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
