Received: from eggs.gnu.org ([2001:4830:134:3::10]:47157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZpjK-00073I-Sw
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZpjJ-0000L8-Rd
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:10:06 -0500
Date: Fri, 12 Jan 2018 11:09:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180112030954.GC29151@lemon.usersys.redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
	<20180110183304.GE24212@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110183304.GE24212@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, 01/10 18:33, Stefan Hajnoczi wrote:
> > +    ret = event_notifier_init(&s->irq_notifier, 0);
> > +    if (ret) {
> > +        error_setg(errp, "Failed to init event notifier");
> > +        return ret;
> 
> dma_map_lock should be destroyed.

CoMutexes are initialized by memset so I don't think destroying is necessary:

    void qemu_co_mutex_init(CoMutex *mutex)
    {
        memset(mutex, 0, sizeof(*mutex));
    }

(I agree to and will fix other issues you pointed out. Thanks for the quick
review!)

Fam
