Received: from eggs.gnu.org ([2001:4830:134:3::10]:37689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRjmV-0004C7-1A
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRjmR-0005n5-Mx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:11:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRjmR-0005mk-GN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:11:51 -0500
References: <20171220102304.8288-1-danielhb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ad71a2a-fc56-336d-9f04-6e14bd044c4d@redhat.com>
Date: Wed, 20 Dec 2017 13:11:49 -0600
MIME-Version: 1.0
In-Reply-To: <20171220102304.8288-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qmp: remove qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 12/20/2017 04:23 AM, Daniel Henrique Barboza wrote:
> 'qmp_cpu' was implemented in commit 755f196898 ("qapi: Convert the cpu
> command") as a functional no-op, a QMP call that does nothing and
> return success. The idea, apparently, was to provide a counterpart
> for the HMP 'hmp_cpu' command, introduced in the same commit.
> 
> After 6 years of its creation, qmp_cpu remains a functional no-op
> that does nothing, having no value for any caller/user. A proposal
> was sent to implement qmp_cpu like hmp_cpu works, but it was denied
> [1]. The reason is that QMP must be as stateless as possible and a
> function that changes its state (the current CPU monitor in the case
> of qmp_cpu) goes against it. Any QMP command that needs a specific
> monitor CPU setup must provide it in its arguments, instead of relying
> in the current QMP monitor state.

s/in/on/

> 
> After discussions that happened in [2] it was decided that a command
> that does nothing since its birth, no one uses for anything and will
> not be implemented, should be deprecated and erased. Given that we will
> *not* provide any replacement for qmp_cpu and we believe that there
> is no user relying on it, there is no point in adding a deprecation
> delay for it.
> 
> So, this patch nukes qmp_cpu from QEMU code, removing both its blank
> implementation in qmp.c and its doc in qapi-schema.json.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02283.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03696.html
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> ---
>   qapi-schema.json | 11 -----------
>   qmp.c            |  5 -----
>   2 files changed, 16 deletions(-)

Took a while to iterate to this solution, but I love the end result.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
