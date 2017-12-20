Received: from eggs.gnu.org ([2001:4830:134:3::10]:51969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjWP-00074a-Dq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjWH-0002zM-Pl
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:55:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjWH-0002xf-Hy
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:55:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171220102304.8288-1-danielhb@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 19:55:06 +0100
In-Reply-To: <20171220102304.8288-1-danielhb@linux.vnet.ibm.com> (Daniel
	Henrique Barboza's message of "Wed, 20 Dec 2017 08:23:04 -0200")
Message-ID: <87bmit6xh1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qmp: remove qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:

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

Lovely commit message.

I'll take this through my tree.  Thanks!
