Received: from eggs.gnu.org ([2001:4830:134:3::10]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejhHb-0000bV-5Q
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 03:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejhHW-0003gD-5r
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 03:10:15 -0500
Date: Thu, 8 Feb 2018 09:09:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180208090956.63db5456.cohuck@redhat.com>
In-Reply-To: <238dde55-387e-7f99-b557-67759d182ce3@de.ibm.com>
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
	<20180207175810.6db572e7.cohuck@redhat.com>
	<238dde55-387e-7f99-b557-67759d182ce3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On Wed, 7 Feb 2018 19:15:22 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/07/2018 05:58 PM, Cornelia Huck wrote:
> 
> >   
> >> +##
> >> +# @S390CrashReason:
> >> +#
> >> +# Reason why the CPU is in a crashed state.
> >> +#
> >> +# @unknown: no crash reason was set
> >> +#
> >> +# @disabledwait: the CPU has entered a disabled wait state
> >> +#
> >> +# @extintloop: timer interrupt with new PSW enabled for timer
> >> +#
> >> +# @pgmintloop: program interrupt with BAD new PSW
> >> +#
> >> +# @opintloop: operation exception interrupt with invalid code at the program
> >> +#             interrupt new PSW
> >> +#
> >> +# Since: 2.12
> >> +##
> >> +{ 'enum': 'S390CrashReason',
> >> +  'data': [ 'unknown',
> >> +            'disabledwait',
> >> +            'extintloop',
> >> +            'pgmintloop',
> >> +            'opintloop' ] }  
> > 
> > Would some hyphens or underscores make this a bit more readable? FWICS,
> > QAPI would create something like S390_CRASH_REASON_DISABLED_WAIT for
> > 'disabled-wait', which looks reasonable to me.  
> 
> 
> disabled-wait
> extint-loop
> pgmint-loop
> opint-loop 
> 
> ?

Looks good to me.
