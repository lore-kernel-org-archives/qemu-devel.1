Received: from eggs.gnu.org ([2001:4830:134:3::10]:35975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT67s-0006zh-68
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT67o-0007Zv-3h
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:47:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fT67n-0007YE-VG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2958B3082A43
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 13:47:47 +0000 (UTC)
Date: Wed, 13 Jun 2018 10:47:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613134745.GQ7451@localhost.localdomain>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<877en4y07a.fsf@dusky.pond.sub.org> <20180612084914.GA2512@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612084914.GA2512@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Jun 12, 2018 at 09:49:14AM +0100, Dr. David Alan Gilbert wrote:
[...]
> > > People have been trying to add qom-get etc for quite a while (I tried a
> > > couple of years ago); it gets stuck in type display issues.  I've not
> > > directly seen a need for those other variants, but qom-get is something
> > > I'd love to have, still that's a job for another patch.
> > 
> > Yes.
> > 
> > > 'info qom-tree' is very very useful when debugging qemu to see what the
> > > basic state we're building is; it's primarily for debugging.
> > 
> > I'm not at all opposed to enabling qom-tree, but I want its QMP building
> > blocks enabled as well then.  I think enabling their HMP buddies as well
> > would only make sense.
> 
> Hmm; OK, enabling qom-list, qom-get, qom-set, qom-list-types,
> qom-list-properties for qmp.
> qom-list and qom-set enabled in HMP.

I would prefer to avoid enabling qom-set in preconfig mode unless
we have a good reason for that.  I don't trust all existing
property setters to not crash or break if the machine is not
initialized yet.

-- 
Eduardo
