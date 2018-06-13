Received: from eggs.gnu.org ([2001:4830:134:3::10]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT0Qp-0003ZT-LR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT0Qm-0002sR-HF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:43:03 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:48425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT0Qm-0002rg-9O
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:43:00 -0400
Received: from player158.ha.ovh.net (unknown [10.109.108.51])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 773A71AF1E
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:42:58 +0200 (CEST)
Date: Wed, 13 Jun 2018 09:42:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613094250.56ad943b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <87y3fjkzry.fsf@dusky.pond.sub.org>
References: <1528861711-23200-1-git-send-email-keno@juliacomputing.com>
	<87y3fjkzry.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Keno Fischer <keno@juliacomputing.com>, qemu-devel@nongnu.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 13 Jun 2018 07:42:57 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Keno Fischer <keno@juliacomputing.com> writes:
> 
> > strchrnul is a GNU extension and thus unavailable on a number of targets.
> > In the review for a commit removing strchrnul from 9p, I was asked to
> > create a qemu_strchrnul helper to factor out this functionality.
> > Do so, and use it in a number of other places in the code base that inlined
> > the replacement pattern in a place where strchrnul could be used.
> >
> > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > Acked-by: Greg Kurz <groug@kaod.org>  
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Maybe I can take this through my 9p-next tree since it is a pre-requisite
for the Darwin support series ?

Keno,

BTW, if you want Darwin support to go in the next QEMU release, please
pay attention that I have to send a pull req for it before 2018-07-03.

https://wiki.qemu.org/Planning/3.0

Cheers,

--
Greg
