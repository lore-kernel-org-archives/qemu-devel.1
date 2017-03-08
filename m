Received: from eggs.gnu.org ([2001:4830:134:3::10]:50334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clYJU-00074l-Kq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clYJP-0003yK-VZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:55:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clYJP-0003y1-Pn
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:55:15 -0500
Date: Wed, 8 Mar 2017 09:55:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170308095508.GA10232@work-vm>
References: <20170307194617.GJ2869@work-vm>
	<CAFEAcA8KxG8OC3YzuYCHJyT_Ya6cnLFnZRWnm-k74uYQjh0eww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8KxG8OC3YzuYCHJyT_Ya6cnLFnZRWnm-k74uYQjh0eww@mail.gmail.com>
Subject: Re: [Qemu-devel] RAMBlock's named ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 7 March 2017 at 20:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > The real fun is that there doesn't seem to be anything that stops
> > two blocks having the same name!
> 
> The memory region API says that the name is for debugging only,
> so the problem is in code which relies on them being unique :-)

I'll fix that comment!
However, the problem here is slightly different; I think the Memory regions
do have names - the problem in this case is that the RAMBlock's aren't
attached to any memory regions.

Dave

> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
