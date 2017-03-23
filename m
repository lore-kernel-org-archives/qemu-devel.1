Received: from eggs.gnu.org ([2001:4830:134:3::10]:47994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cr7xm-0000fv-4U
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cr7xj-0007vd-9L
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:59:58 -0400
Received: from mail-sn1nam01on0052.outbound.protection.outlook.com
	([104.47.32.52]:33408
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1cr7xi-0007vI-To
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:59:55 -0400
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
	<20170323113517.GC12560@stefanha-x1.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <6ed30368-1433-cf00-ee2e-611faf2a98e3@amd.com>
Date: Thu, 23 Mar 2017 13:59:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170323113517.GC12560@stefanha-x1.localdomain>
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

Hi Stefan,


On 03/23/2017 06:35 AM, Stefan Hajnoczi wrote:
> On Wed, Mar 08, 2017 at 03:52:09PM -0500, Brijesh Singh wrote:
>> The object can be used to define global security policy for the guest.
>
> "security-policy" is very vague.  Lots of parts of QEMU have security
> related options (e.g. VNC display, networking, etc).
>
> I'd prefer a
> -machine memory-encryption=on|off,memory-encryption-debug=on|off
> or -m encryption=on|off,encryption-debug=on|off switch instead of a new
> security policy object with questionable scope.
>

In v1 [1], I had something similar but not exactly the same. I had a new command
line switch but the overall feedback was to consider creating new security object
which can be used to define a machine security policy.

[1] http://marc.info/?t=147378617700002&r=1&w=2

some more discussion here [2]

[2] http://marc.info/?t=147378241700011&r=1&w=2

IMHO, a new object is helpful because it provide options to launch a guest without
memory encryption support but still can take a advantage of disabling the debug
feature. e.g on non SEV platform we can launch guest with "-object security-policy,id=secure0,debug=off'
which will reject the guest memory accesses via gdbstub or qemu monitor command line interface.

-Brijesh
