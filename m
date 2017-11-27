Received: from eggs.gnu.org ([2001:4830:134:3::10]:48354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eJ9fb-0005GC-6Y
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 22:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eJ9fW-0002p7-CW
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 22:01:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eJ9fW-0002np-68
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 22:01:14 -0500
Date: Mon, 27 Nov 2017 11:00:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171127030052.GA5153@xz-mi>
References: <20171116130610.23582-1-peterx@redhat.com>
	<20171116130610.23582-24-peterx@redhat.com>
	<20171124110149.GC2302@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171124110149.GC2302@work-vm>
Subject: Re: [Qemu-devel] [RFC v4 23/27] monitor: enable IO thread for (qmp
 & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

On Fri, Nov 24, 2017 at 11:01:49AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Start to use dedicate IO thread for QMP monitors that are not using
> > MUXed chardev.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

> 
> I guess another way to do this would be to have a property on the
> Chardev something like 'can use iothread' and clear that for Mux.

Yeh we can.  Though I would still prefer to put that in Monitor struct
since current IOThread is really tailored only for monitors.  IOW not
all Chardevs can be run in the IOThread (or say, the thread currently
named as "mon_iothread") safely.  Thanks,

-- 
Peter Xu
