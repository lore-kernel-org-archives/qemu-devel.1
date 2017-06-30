Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dQyEn-0007wT-Jz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dQyEm-0004GS-Ip
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:53:41 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:42849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dQyEm-0004Ex-CG
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 11:53:40 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Fri, 30 Jun 2017 17:53:32 +0200
Message-ID: <2070055.lQvcDpnNFn@k>
In-Reply-To: <20170629150054.GB22733@work-vm>
References: <20170611074817.13621-1-sf@sfritsch.de>
	<d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
	<20170629150054.GB22733@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thursday, 29 June 2017 16:00:54 CEST Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
> > On 06/11/2017 02:48 AM, Stefan Fritsch wrote:
> > > Sending a break on a serial console can be useful for debugging the
> > > guest. But not all chardev backends support sending breaks (only telnet
> > > and mux do). The chardev-send-break command allows to send a break even
> > > if using other backends.
> > > 
> > > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > > v2: added tests and Acked-by line
> > > 
> > > 
> > > +++ b/hmp-commands.hx
> > > @@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
> > > 
> > >  ETEXI
> > >  
> > >      {
> > > 
> > > +        .name       = "chardev-send-break",
> > > +        .args_type  = "id:s",
> > > +        .params     = "id",
> > > +        .help       = "send break on chardev",
> > 
> > Compare this wording,...
> > 
> > > +STEXI
> > > +@item chardev-send-break id
> > > +@findex chardev-send-break
> > > +Sends break on the chardev @var{id}.
> > 
> > repeated here,
> > 
> > > +++ b/qapi-schema.json
> > > @@ -5114,6 +5114,26 @@
> > > 
> > >  { 'command': 'chardev-remove', 'data': {'id': 'str'} }
> > >  
> > >  ##
> > > 
> > > +# @chardev-send-break:
> > > +#
> > > +# Send a break to a character device
> > 
> > ...with this wording.  I like 'send a break' better than 'send break',
> > but even better might be 'send a break sequence' or even 'emulate a
> > break sequence' (by definition, a break is NOT a character, but on bare
> > metal character devices it IS a defined electrical sequence distinct
> > from characters to make the recipient aware that the sender is trying to
> > get attention).
> > 
> > Otherwise, the patch looks fine to me.  If all that changes is some
> > word-smithing (and the maintainer may be willing to do that), you can add:
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> I'll go with the 'send a break' - the official terminology seems to
> be a 'break condition', but I've never heard anyone say that,
> it's always been 'send a break'.

I also think that "send a break" is best for people who google for it.

Thanks.

Cheers,
Stefan
