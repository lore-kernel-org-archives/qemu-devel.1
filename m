Received: from eggs.gnu.org ([209.51.188.92]:40538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggv1W-0000Ej-8X
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggv1U-0004E4-5B
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:18:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1537848362.git.jcody@redhat.com>
	<cover.1537848362.git.jcody@redhat.com>
	<0e8a512d4c95094dc12f92390200c8e753c38248.1537848362.git.jcody@redhat.com>
	<87efdiyxv9.fsf@dusky.pond.sub.org>
	<20180925053204.GB4558@lemon.usersys.redhat.com>
	<87va6uvxhv.fsf@dusky.pond.sub.org>
Date: Tue, 08 Jan 2019 18:18:18 +0100
In-Reply-To: <87va6uvxhv.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 25 Sep 2018 09:37:16 +0200")
Message-ID: <87h8ejcbl1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] MAINTAINERS: Remove myself as block
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, kwolf@redhat.com, Jeff Cody <jeff@codyprime.org>, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

This patch series got stuck.

Markus Armbruster <armbru@redhat.com> writes:

> Fam Zheng <famz@redhat.com> writes:
>
>> On Tue, 09/25 07:00, Markus Armbruster wrote:
>>> Jeff Cody <jcody@redhat.com> writes:
>>> 
>>> > I'll not be involved in day-to-day qemu development.  Remove
>>> > myself as maintainer from the remainder of the network block drivers
>>> > (and vhdx), and revert them to the general block layer maintainership.
>>> >
>>> > Signed-off-by: Jeff Cody <jcody@redhat.com>
>>> > ---
>>> >  MAINTAINERS | 14 --------------
>>> >  1 file changed, 14 deletions(-)
>>> >
>>> > diff --git a/MAINTAINERS b/MAINTAINERS
>>> > index e93f79672f..6ef6932628 100644
>>> > --- a/MAINTAINERS
>>> > +++ b/MAINTAINERS
>>> > @@ -1982,28 +1982,22 @@ F: block/vmdk.c
>>> >  
>>> >  RBD
>>> >  M: Josh Durgin <jdurgin@redhat.com>
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  L: qemu-block@nongnu.org
>>> >  S: Supported
>>> >  F: block/rbd.c
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> >  
>>> >  Sheepdog
>>> >  M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
>>> >  M: Liu Yuan <namei.unix@gmail.com>
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  L: qemu-block@nongnu.org
>>> >  L: sheepdog@lists.wpkg.org
>>> >  S: Supported
>>> >  F: block/sheepdog.c
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> >  
>>> >  VHDX
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  L: qemu-block@nongnu.org
>>> >  S: Supported
>>> >  F: block/vhdx*
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> 
>>> Does "S: Supported" make sense without an M:?
>>> 
>>> >  
>>> >  VDI
>>> >  M: Stefan Weil <sw@weilnetz.de>
>>> > @@ -2034,34 +2028,26 @@ F: docs/interop/nbd.txt
>>> >  T: git git://repo.or.cz/qemu/ericb.git nbd
>>> >  
>>> >  NFS
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  M: Peter Lieven <pl@kamp.de>
>>> >  L: qemu-block@nongnu.org
>>> >  S: Maintained
>>> >  F: block/nfs.c
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> >  
>>> >  SSH
>>> >  M: Richard W.M. Jones <rjones@redhat.com>
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  L: qemu-block@nongnu.org
>>> >  S: Supported
>>> >  F: block/ssh.c
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> >  
>>> >  CURL
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  L: qemu-block@nongnu.org
>>> >  S: Supported
>>> >  F: block/curl.c
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> 
>>> Likewise.
>>> 
>>> >  GLUSTER
>>> > -M: Jeff Cody <jcody@redhat.com>
>>> >  L: qemu-block@nongnu.org
>>> >  S: Supported
>>> >  F: block/gluster.c
>>> > -T: git git://github.com/codyprime/qemu-kvm-jtc.git block
>>> 
>>> Likewise.
>>> 
>>> >  Null Block Driver
>>> >  M: Fam Zheng <famz@redhat.com>
>>> 
>>
>> Block drivers without an M: naturally fall under the overall maintainership of
>> block layer (Kevin&Max), so IMO keeping the statuses is fine. Maybe CURL can be
>> degraded to Maintained, though.
>
> Yes, get_maintainer.pl combines all applicable sections.  Human readers
> are left to wonder, unless they know to look for other matches.
>
> Do we want to have a dedicated network block driver submaintainer again,
> if we can find one?
>
> Do we want to have a dedicated VHDX driver submaintainer again?  Fam,
> you're maintaining VMDK, could you cover VHDX as well?

Fam can't.

I can see two sane options for the three sections that lose their sole
maintainer (VHDX, CURL, GLUSTER):

* Downgrade to S: Orphan

  This reflects the fact that we'd like to have dedicated maintainers
  for them.  It camouflages the fact that the "Block layer core"
  maintainers pick up the slack.

* Delete

  The opposite.

Kevin, Max, please pick your poison, or suggest one you find tastier.
