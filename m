Received: from eggs.gnu.org ([2001:4830:134:3::10]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1crPHr-0006f9-PC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1crPHr-0007jf-1s
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:29:51 -0400
Date: Fri, 24 Mar 2017 14:29:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170324142939.407b93fe@nial.brq.redhat.com>
In-Reply-To: <c22d6e03-e63c-6a90-e9f3-419255c2c4d2@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-23-git-send-email-imammedo@redhat.com>
	<c22d6e03-e63c-6a90-e9f3-419255c2c4d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 22/23] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 23 Mar 2017 08:23:32 -0500
Eric Blake <eblake@redhat.com> wrote:

...
> >  
> > +@samp{cpu} option is new alternative to @samp{cpus} option  
> 
> s/is/is a/
> 
> > +uses @samp{socket-id|core-id|thread-id} properties to assign  
> 
> s/uses/which uses/
> 
> > +CPU objects to a @var{node} using topology layout properties of CPU.
> > +Set of properties is machine specific, and depends on used machine  
> 
> s/Set/The set/
> 
Fixed in v2 branch
