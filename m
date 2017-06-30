Received: from eggs.gnu.org ([2001:4830:134:3::10]:59391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dQrfZ-0004wM-Gh
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dQrfW-0007jw-G3
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:52:53 -0400
References: <a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
	<20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
	<78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
	<20170628184137.699a4f9f@bahia.lab.toulouse-stg.fr.ibm.com>
	<1498714660.30519.1.camel@gmail.com>
	<1498714923.30519.3.camel@gmail.com>
	<20170630071218.GE13989@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c783b94e-e656-da3d-3372-5350cf80915e@redhat.com>
Date: Fri, 30 Jun 2017 10:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170630071218.GE13989@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, sbobroff@redhat.com

On 30/06/2017 09:12, David Gibson wrote:
> On Thu, Jun 29, 2017 at 03:42:03PM +1000, Suraj Jitindar Singh wrote:
>> On Thu, 2017-06-29 at 15:37 +1000, Suraj Jitindar Singh wrote:
>>> On Wed, 2017-06-28 at 18:41 +0200, Greg Kurz wrote:
...
>>> That makes the assumption that DD2 doesn't require any work arounds
>>> which TCG can't handle.
>>
>> Actually TCG is really a non-issue since we'll just go into the POWER9
>> architected mode.
>>
>> Can't we just have -cpu POWER9 alias to DD1 for now and add DD2 when we
>> know the pvr?
> 
> No, because calling what qemu does DD1 is simply not accurate, in
> important and guest-visible ways.
> 
> What we should do is add in DD2.0 - we know the PVR, even if the
> chip's not out yet.  Then alias POWER9 to that.
> 

OK, I have patch that define v1.0 to DD1, v2 to DD2, and set the POWER9
alias to v2, but:
- on a DD1 host and KVM HV, "-cpu host" works well and "cpu POWER9"
(that select then the v1.0) boots the kernel and hangs at early boot of
the kernel (first display)
- in TCG mode, boot by default with v2, but some services does not start
correctly, and I have never the console login (perhaps because of some
time out: I test TCG on the POWER9 host, I should test on a x86 one).

I'm trying for the moment to understand why "-cpu POWER9" hangs while
"-cpu host" works.

Thanks,
Laurent
