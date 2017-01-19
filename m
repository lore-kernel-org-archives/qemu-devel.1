Received: from eggs.gnu.org ([2001:4830:134:3::10]:32956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUEL3-0000lp-OW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUEL0-0002xR-Ij
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:09:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUEL0-0002x3-CS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:09:18 -0500
Date: Thu, 19 Jan 2017 16:09:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170119160914.60f461eb@nial.brq.redhat.com>
In-Reply-To: <7fc85b46-880d-04f1-1410-3131f55c596e@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-10-git-send-email-imammedo@redhat.com>
	<7fc85b46-880d-04f1-1410-3131f55c596e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 09/13] numa: introduce '-numa cpu' cpu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, Thomas Huth <thuth@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, Andrew Jones <drjones@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>

On Wed, 18 Jan 2017 12:22:01 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 01/18/2017 11:13 AM, Igor Mammedov wrote:
> > It allows to specify mapping of a CPU to NUMA node on CLI.
> > Option should be repeated for each present/possible CPU.
> > Example for PC machine:
> >   -numa node,nodeid=0 -numa node,nodeid=1 \
> >   -numa cpu,socket-id=0,core-id=0,thread-id=0,node-id=0 \
> >   -numa cpu,socket-id=1,core-id=0,thread-id=0,node-id=1
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---  
> 
> > +++ b/qapi-schema.json
> > @@ -5543,7 +5543,8 @@
> >  ##
> >  { 'union': 'NumaOptions',
> >    'data': {
> > -    'node': 'NumaNodeOptions' }}
> > +    'node': 'NumaNodeOptions',
> > +    'cpu': 'CpuInstanceProperties' }}  
> 
> Missing a documentation blurb that includes a '(since 2.9)' tag.
> 
I'll fix it in the next version
