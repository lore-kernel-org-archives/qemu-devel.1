Received: from eggs.gnu.org ([2001:4830:134:3::10]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1crV6x-0002dW-Cx
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1crV6s-0001tC-Cy
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:42:59 -0400
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com
	([104.47.41.88]:20544
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1crV6s-0001su-0w
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:42:54 -0400
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
	<20170323113517.GC12560@stefanha-x1.localdomain>
	<6ed30368-1433-cf00-ee2e-611faf2a98e3@amd.com>
	<20170324154007.GB5849@stefanha-x1.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3b210d06-b6f9-af04-ff68-e7cee1c8033f@amd.com>
Date: Fri, 24 Mar 2017 14:42:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170324154007.GB5849@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 06/20] core: add new security-policy
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: brijesh.singh@amd.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com


On 03/24/2017 10:40 AM, Stefan Hajnoczi wrote:

>
> Having one security policy doesn't make sense to me.  As mentioned,
> there are many different areas of QEMU that have security relevant
> configuration.  They are all unrelated so combining them into one object
> with vague parameter names like "debug" makes for a confusing
> command-line interface.
>
> If the object is called sev-security-policy then I'm happy.
>

Works for with me but one of the feedback was to use security-policy [1].
IIRC, the main reason for using 'security-policy' instead of 'sev-security-policy'
was to add a layer of abstraction so that in future if other platforms supports
memory encryption in slightly different way then all we need to do is to create
new object without needing to add a new parameter in -machine.

[1] http://marc.info/?l=qemu-devel&m=147388592213137&w=2

How about using 'memory-encryption-id' instead of security-policy ? If user wants
to launch SEV guest then memory-encryption-id should be set SEV specific object.
Something like this:

-machine ..,memory-encryption-id=sev0 \
-object sev-guest,id=sev,debug=off,launch=launch0 \
-object sev-launch-info,id=launch0 \


Thanks
Brijesh
