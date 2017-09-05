Received: from eggs.gnu.org ([2001:4830:134:3::10]:37152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpDOp-0006ZJ-7Z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpDOk-0003tA-Jn
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:56:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpDOk-0003sb-D5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:56:10 -0400
Date: Tue, 5 Sep 2017 14:55:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905145553.64def7f0.cohuck@redhat.com>
In-Reply-To: <e2629d22-960a-68af-0f53-68ee88cfede4@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-9-david@redhat.com>
	<20170905143801.1dc39cb1.cohuck@redhat.com>
	<e4ed534e-6eef-30ea-6359-0b535f483cc3@redhat.com>
	<a1db14fd-1bd6-e6b3-2af9-a33f2816e932@de.ibm.com>
	<e2629d22-960a-68af-0f53-68ee88cfede4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/19] s390x: move sclp_service_call()
 to interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>

On Tue, 5 Sep 2017 14:52:44 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05.09.2017 14:46, Christian Borntraeger wrote:
> > 
> > 
> > On 09/05/2017 02:42 PM, David Hildenbrand wrote:  
> >> On 05.09.2017 14:38, Cornelia Huck wrote:  
> >>> On Mon,  4 Sep 2017 17:43:05 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>  
> >>>> Fix up includes and rename it to s390x_*.  
> >>>
> >>> I'm not quite sure whether that is the right direction: servc is just an
> >>> instruction that does something and then happens to also generate an
> >>> interrupt on conclusion. I'll think a bit more about it.
> >>>  
> >>
> >> Having CPU related stuff in sclp looks also wrong. Feel free to skip
> >> this patch, should be unrelated to the following patches.  
> > 
> > I think having the sclp instruction handler in sclp (as today) is
> > the best compromise.  
> 
> +1
> 
> But maybe you could at least move the prototype to sclp.h instead?

That would be a good compromise.
