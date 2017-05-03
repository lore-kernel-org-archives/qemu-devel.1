Received: from eggs.gnu.org ([2001:4830:134:3::10]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5tQC-0004eI-LK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5tQ6-0002Rq-Qx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:30:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5tQ6-0002Qg-KO
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:30:14 -0400
References: <20170503094351.5040-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8261e472-c74a-7820-6c3d-56339c9745bb@redhat.com>
Date: Wed, 3 May 2017 14:29:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170503094351.5040-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] MAINTAINERS/get_maintainers: add
 support for reviewers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pavel.dovgaluk@ispras.ru

On 03.05.2017 11:43, Paolo Bonzini wrote:
> I would like to use "R" so that people can delegate maintenance of some
> code while keeping some degree of oversight.  In my case, this can be
> appropriate for record/replay and cpus.c.
> 
> Other people are free to use "R" as in Linux, where it is used to
> designate non-maintainers for reviewing patches in a given area.
> 
> Paolo
> 
> Brian Norris (2):
>   get_maintainer: it's '--pattern-depth', not '-pattern-depth'
>   get_maintainer: --r (list reviewer) is on by default
> 
> Joe Perches (2):
>   get_maintainer: Teach get_maintainer.pl about the new "R:" tag
>   get_maintainer: add subsystem to reviewer output
> 
> Paul E. McKenney (1):
>   MAINTAINERS: Add "R:" tag for self-appointed reviewers
> 
>  MAINTAINERS               |  2 ++
>  scripts/get_maintainer.pl | 53 +++++++++++++++++++++++++++++++++--------------
>  2 files changed, 39 insertions(+), 16 deletions(-)

Patches look fine to me, and I think this is a good idea, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
