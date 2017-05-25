Received: from eggs.gnu.org ([2001:4830:134:3::10]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDmlB-0001OE-M7
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDml5-0007Mo-Ul
	for qemu-devel@nongnu.org; Thu, 25 May 2017 03:00:37 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170524121048.10067-1-lvivier@redhat.com> (Laurent Vivier's
	message of "Wed, 24 May 2017 14:10:48 +0200")
References: <20170524121048.10067-1-lvivier@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 25 May 2017 09:00:25 +0200
Message-ID: <87k2555sl2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Dmitry Fleytman <dmitry@daynix.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-ppc@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, sam.bobroff@au1.ibm.com, Peter Xu <peterx@redhat.com>

Laurent Vivier <lvivier@redhat.com> wrote:
D> We can replace the four remaining calls of register_savevm() by
> calls to register_savevm_live(). So we can remove the function and
> as we don't allocate anymore the ops pointer with g_new0()
> we don't have to free it then.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As this is needed for Power, letting them go through their tree.

Later, Juan.
