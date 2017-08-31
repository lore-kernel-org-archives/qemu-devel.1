Received: from eggs.gnu.org ([2001:4830:134:3::10]:52222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQn9-0001hC-WF
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQn6-00014V-Uj
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnQn6-000148-NY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:49:56 -0400
Date: Thu, 31 Aug 2017 16:49:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831164938.04410ca7.cohuck@redhat.com>
In-Reply-To: <0cada76f-2e43-01db-7c69-ba67e1539aa3@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-7-david@redhat.com>
	<20170831163513.17c0a963.cohuck@redhat.com>
	<0cada76f-2e43-01db-7c69-ba67e1539aa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/11] target/s390x: cleanup cpu
 number/address handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On Thu, 31 Aug 2017 16:41:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 31.08.2017 16:35, Cornelia Huck wrote:
> > On Wed, 30 Aug 2017 19:05:56 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Some time ago we discussed that using "id" as property name is not the
> >> right thing to do, as it is a reserved property for other devices.
> >>
> >> Switch to the term "addr" instead, which matches the definition in the
> >> PoP called "CPU address". There is no such thing as cpu number, so
> >> rename env.cpu_num to env.cpu_addr.
> >>
> >> We can get rid of cpu->id now. Keep cpu->index and env->cpu_addr in sync.
> >> cpu->index was already implicitly used by e.g. cpu_exists(), so keeping
> >> both in sync seems to be the right thing to do.
> >>
> >> cpu->index will now no longer automatically get set via
> >> cpu_exec_realizefn(). For now, we were lucky that both implicitly stayed
> >> in sync.
> >>
> >> Our new cpu property "addr" can be a static property. Range checks can
> >> be avoided by using the correct type and the "setting after realized"
> >> check is done implicitly.
> >>
> >> AFAIK, s390x only supports cpu_add and not device_add for cpus. So we
> >> should be able to safely rename that property (no the "id" property
> >> could properly be used for device_add, which needs an artificial id for
> >> identification purposes).  
> > 
> > I cannot parse the sentence in the brackets...  
> 
> Me too :)
> 
> ...So we should be able to safely rename that property. device_add will
> later need the reserved "id" property. Hotplugging a CPU would then look
> like this: "device_add host-s390-cpu id=cpu2 addr=2".

Yup, that's understandable :)
