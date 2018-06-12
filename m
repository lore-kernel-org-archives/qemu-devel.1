Received: from eggs.gnu.org ([2001:4830:134:3::10]:48358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSinH-0004PB-8r
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSinD-0008I0-B5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:53:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSinD-0008HH-6d
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:52:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1865D401EF30
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:52:58 +0000 (UTC)
Date: Tue, 12 Jun 2018 13:52:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180612125254.GB2512@work-vm>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<20180612053720.pp2xvb7r34o6ort7@sirius.home.kraxel.org>
	<87k1r4use2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1r4use2.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, imammedo@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> >   Hi,
> >
> >> > Now let's review the three commands:
> >> > 
> >> > * Gerd, why does "info usbhost" have no QMP equivalent?
> >
> > Works only when running qemu directly, in the libvirt sandbox qemu
> > hasn't the permissions needed to scan the host usb bus so that would be
> > rather pointless ...
> 
> I don't think this meets either of the two criteria:
> 
> * I meets "makes no sense in QMP" only if QMP implies "can't scan host
>   USB bus".  Libvirt implies it, but QMP doesn't imply libvirt; it's its
>   most important, not its sole user.
> 
> * It meets "of use only for human users" only if we're convinced it's of
>   no use to programs.
> 
>   To avoid speculation and endless arguments about what could or could
>   not be of use, we've always stuck to "when in doubt, assume it could
>   be of use".
> 
>   "Libvirt can't use it" falls short.
> 
>   "Any management application worth anything would deny QEMU the
>   capability to scan the USB host bus, and thus wouldn't be able to use
>   it" is exactly the argument we intended to avoid.
> 
> QMP falling short of completeness in relatively unimportant ways like
> this one isn't exactly terrible.  The most serious effect is probably
> serving as a bad example that leads to further arguments like this one.
> These are well worth avoiding, though.

Markus:
  a) This is a separate discussion; info usbhost has been there for many
years;  this patch set doesn't change that.
  b) From HMP, if someone wants to add a command like 'info usbhost' to
make their debugging of USB easy, then HMP is all for that and there's
no way I'm going to require QMP implementations for a debug command.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
