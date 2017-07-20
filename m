Received: from eggs.gnu.org ([2001:4830:134:3::10]:40670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dYAYk-0002PN-PW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dYAYj-00077A-Rv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:28:02 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:37178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dYAYj-00076b-LF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:28:01 -0400
Date: Thu, 20 Jul 2017 14:27:59 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
In-Reply-To: <c98eec07-b269-ddb3-6e53-88ad4e34dbc5@redhat.com>
Message-ID: <alpine.DEB.2.11.1707201425590.21661@manul.sfritsch.de>
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
	<c98eec07-b269-ddb3-6e53-88ad4e34dbc5@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] acpi: Add emulated sleep button
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, 20 Jul 2017, Eric Blake wrote:

> On 07/20/2017 04:31 AM, Stefan Fritsch wrote:
> > From: Stefan Fritsch <stefan_fritsch@genua.de>
> > 
> > Add an ACPI sleep button and QMP/HMP commands to trigger it.  A sleep
> > button is a so called "fixed hardware feature", which makes it more
> > suitable for putting the system to sleep than a laptop lid, for example.
> > 
> > The sleep button is disabled by default (Bit 5 in the FACP flags
> > register set and no button "device" present in SSDT/DSDT). Clearing said
> > bit enables it as a fixed feature device.
> > 
> > Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> > ---
> 
> Just an interface review:
> 
> > +++ b/qapi-schema.json
> > @@ -2314,6 +2314,18 @@
> >  { 'command': 'system_reset' }
> >  
> >  ##
> > +# @system_sleep:
> > +#
> > +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
> 
> s/a /an /
> 
> > +# sleep button.
> > +#
> > +# Notes: A guest may or may not respond to this command.  This command
> > +#        returning does not indicate that a guest has accepted the request or
> > +#        that it has gone to sleep.
> 
> Missing a 'Since: 2.11' line.
> 
> > +##
> > +{ 'command': 'system_sleep' }
> 
> Please name this 'system-sleep' (new QMP commands should favor '-' over
> '_').  Or at least document in the commit message that you are
> intentionally trying to match spelling of older existing system_*
> commands.  I wonder if it might be better to have a single system-acpi
> command that takes an enum of which action (sleep, powerdown, ...) to
> attempt, rather than a proliferation of commands per action..

I would prefer to match the spelling of older existing system_* commands 
and will put that in the commit message. But weould be fine with the other 
solutions, too.
