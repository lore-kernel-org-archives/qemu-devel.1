Received: from eggs.gnu.org ([2001:4830:134:3::10]:50987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eR8QO-0001BN-3N
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eR8QK-0007hu-0f
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eR8QJ-0007g5-O8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:18:31 -0500
Date: Tue, 19 Dec 2017 11:18:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171219031817.GX22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-25-peterx@redhat.com>
	<20171214143019.GM14433@stefanha-x1.localdomain>
	<20171218094419.GQ22308@xz-mi>
	<20171218140936.GH16653@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171218140936.GH16653@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 24/26] docs: update QMP documents for OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Dec 18, 2017 at 02:09:36PM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 18, 2017 at 05:44:19PM +0800, Peter Xu wrote:
> > On Thu, Dec 14, 2017 at 02:30:19PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 01:51:58PM +0800, Peter Xu wrote:
> > > > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > > > index f04c63fe82..8597fdb087 100644
> > > > --- a/docs/devel/qapi-code-gen.txt
> > > > +++ b/docs/devel/qapi-code-gen.txt
> > > > @@ -556,7 +556,8 @@ following example objects:
> > > >  
> > > >  Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
> > > >           '*returns': TYPE-NAME, '*boxed': true,
> > > > -         '*gen': false, '*success-response': false }
> > > > +         '*gen': false, '*success-response': false,
> > > > +         '*allow-oob': false }
> > > >  
> > > >  Commands are defined by using a dictionary containing several members,
> > > >  where three members are most common.  The 'command' member is a
> > > > @@ -636,6 +637,44 @@ possible, the command expression should include the optional key
> > > >  'success-response' with boolean value false.  So far, only QGA makes
> > > >  use of this member.
> > > >  
> > > > +Most of the QMP commands are handled sequentially in such a order:
> > > > +Firstly, the JSON Parser parses the command request into some internal
> > > > +message, delivers the message to QMP dispatchers. Secondly, the QMP
> > > > +dispatchers will handle the commands one by one in time order, respond
> > > > +when necessary.
> > > 
> > > The important points to cover about normal commands:
> > > 1. They execute in order
> > > 2. They run the main loop
> > > 3. They run under the BQL
> > > 
> > > The other stuff about parsing requests into internal messages,
> > > dispatchers, etc is not relevant.  It's better not to include it in
> > > documentation because it can change and could also confuse readers
> > > (since they don't need this info).
> > 
> > Ah yes.  I'm thinking whether I should just remove most of the changes
> > to this file (qapi-code-gen.txt) since most of them are really not
> > related to code gen at all...  Maybe somewhere in qmp-spec.txt as
> > well?
> 
> qmp-spec.txt is the wire protocol that QMP clients and servers follow.
> QEMU details like the BQL do not belong in qmp-spec.txt.
> 
> qapi-code-gen.txt is not a bad place to document the QEMU details that
> are relevant to people writing QMP commands with allow-oob: true.  What
> I was getting at is that this document should focus on things that QMP
> command authors need to know, not on monitor implementation details.

Fair enough.  I'll try to avoid talking about QMP internals in either
of the documents.

Let me cook a better one.  Thanks,

-- 
Peter Xu
