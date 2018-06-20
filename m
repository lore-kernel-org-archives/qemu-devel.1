Received: from eggs.gnu.org ([2001:4830:134:3::10]:39140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVlpe-0000MU-Je
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 18:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVlpb-0007to-GK
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 18:44:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fVlpb-0007sJ-AA
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 18:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85245307D859
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 22:44:01 +0000 (UTC)
Date: Wed, 20 Jun 2018 19:43:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180620224356.GT7451@localhost.localdomain>
References: <1528688464-17289-1-git-send-email-thuth@redhat.com>
	<20180611221859.GE7451@localhost.localdomain>
	<5231573e-f53d-dba2-e39c-5f3755505cca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5231573e-f53d-dba2-e39c-5f3755505cca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com

(CCing Markus and libvir-list)

On Wed, Jun 20, 2018 at 08:40:38PM +0200, Thomas Huth wrote:
> On 12.06.2018 00:18, Eduardo Habkost wrote:
> > On Mon, Jun 11, 2018 at 05:41:04AM +0200, Thomas Huth wrote:
> >> The oldest machine type which is still used in a maintained distribution
> >> is a pc-0.12 based machine type in RHEL6, so everything that is older
> >> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
> >> and pc-0.11 so that we can finally remove them in a future release.
> [...]
> >> @@ -3952,6 +3953,10 @@ int main(int argc, char **argv, char **envp)
> >>      }
> >>  
> >>      machine_class = select_machine();
> >> +    if (machine_class->deprecation_msg) {
> >> +        error_report("Machine type '%s' is deprecated: %s",
> >> +                     machine_class->name, machine_class->deprecation_msg);
> >> +    }
> > 
> > Do you plan to add this info to 'query-machines' QMP command?
> 
> No, I'm not planning to add this. We'd need a request from upper layers
> (i.e. libvirt) for this first, otherwise it's just a dead interface that
> nobody is using.

I believe that useful information being available only through
stderr is at least as bad as being available only through HMP.
Should we extend QMP more proactively in cases like this, too?

(In either case, I don't think this should block your series)

-- 
Eduardo
