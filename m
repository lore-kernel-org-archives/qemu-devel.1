Received: from eggs.gnu.org ([2001:4830:134:3::10]:55987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUdLE-0001CK-Ky
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUdLB-000104-EY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:23:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dUdLB-0000zT-8P
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:23:25 -0400
Date: Mon, 10 Jul 2017 15:23:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170710182322.GE5167@localhost.localdomain>
References: <20170707213052.13087-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707213052.13087-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] qom: Fix ambiguous path detection when
 ambiguous=NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>

On Fri, Jul 07, 2017 at 06:30:50PM -0300, Eduardo Habkost wrote:
> object_resolve_path*() ambiguous path detection breaks when
> ambiguous==NULL and the object tree have 3 objects of the same type and
> only 2 of them are under the same parent.  e.g.:
> 
>  /container/obj1 (TYPE_FOO)
>  /container/obj2 (TYPE_FOO)
>  /obj2 (TYPE_FOO)
> 
> With the above tree, object_resolve_path_type("", TYPE_FOO, NULL) will
> incorrectly return /obj2, because the search inside "/container" will
> return NULL, and the match at "/obj2" won't be detected as ambiguous.
> 
> Fix that by always calling object_resolve_partial_path() with a non-NULL
> ambiguous parameter.
> 
> Test case included.
> 
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Eduardo Habkost (2):
>   tests: Test case for object_resolve_path*()

I'm queueing patch 1/2 on my machine-next tree.  I will wait a
little longer for additional feedback on patch 2/2 before merging
it.

>   qom: Fix ambiguous path detection when ambiguous=NULL
> 
>  qom/object.c               | 17 ++++++++---------
>  tests/check-qom-proplist.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 9 deletions(-)
> 
> -- 
> 2.9.4
> 
> 

-- 
Eduardo
