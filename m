Received: from eggs.gnu.org ([2001:4830:134:3::10]:45861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgt3s-0002FD-Nm
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgt3p-0007yF-KK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:03:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgt3p-0007y6-CO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:03:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1ND1MUc057199
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:03:51 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sku93p65-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:03:50 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 23 Feb 2017 13:03:47 -0000
Date: Thu, 23 Feb 2017 14:03:42 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <5a3c1652-f5eb-85a5-44f4-35c7c12d3f4b@redhat.com>
References: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
	<20170222121527.7009-2-cornelia.huck@de.ibm.com>
	<5a3c1652-f5eb-85a5-44f4-35c7c12d3f4b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170223140342.57c291e4.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] chardev: Basic support for TN3270
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>

On Wed, 22 Feb 2017 09:40:23 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/22/2017 06:15 AM, Cornelia Huck wrote:
> > From: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > 
> > This introduces basic support for TN3270, which needs to negotiate
> > three Telnet options during handshake:
> >   - End of Record
> >   - Binary Transmission
> >   - Terminal-Type
> > 
> > As a basic implementation, this simply ignores NOP and Interrupt
> > Process(IP) commands. More work should be done for them later.
> > 
> > For more details, please refer to RFC 854 and 1576.
> > 
> > Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
> > Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> 
> > +++ b/qapi-schema.json
> > @@ -4774,6 +4774,8 @@
> >  # @nodelay: #optional set TCP_NODELAY socket option (default: false)
> >  # @telnet: #optional enable telnet protocol on server
> >  #          sockets (default: false)
> > +# @tn3270: #optional enable tn3270 protocol on server
> > +#          sockets (default: false)
> 
> Missing a '(since 2.9)' designation

Thanks, added.

> 
> >  # @reconnect: #optional For a client socket, if a socket is disconnected,
> >  #          then attempt a reconnect after the given number of seconds.
> >  #          Setting this to zero disables this function. (default: 0)
> > @@ -4787,6 +4789,7 @@
> >                                       '*wait'      : 'bool',
> >                                       '*nodelay'   : 'bool',
> >                                       '*telnet'    : 'bool',
> > +                                     '*tn3270'    : 'bool',
> >                                       '*reconnect' : 'int' },
> >    'base': 'ChardevCommon' }
> >  
> > 
> 
