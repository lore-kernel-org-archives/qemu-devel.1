Received: from eggs.gnu.org ([2001:4830:134:3::10]:40353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikia-00032q-Bg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikiX-0001tP-6c
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dikiX-0001t5-0m
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C60634A6EB
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 17:05:51 +0000 (UTC)
Date: Fri, 18 Aug 2017 14:05:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818170545.GC3108@localhost.localdomain>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-5-ehabkost@redhat.com>
	<87fuctp2pi.fsf@dusky.pond.sub.org>
	<20170815203909.GY3108@localhost.localdomain>
	<87378sf2qi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87378sf2qi.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 4/5] qmp-shell: Accept QMP
 command as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Aug 16, 2017 at 08:25:41AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Tue, Aug 15, 2017 at 12:03:53PM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> Suggest to insert here:
> >> 
> >>   If additional arguments QMP-COMMAND ARG=VAL... are given, run just
> >>   that QMP command instead of the REPL.
> >> 
> >> Question: is this limited to simple arguments?  If no, how would I write
> >> an object argument?  For instance, how would I do
> >> 
> >>     { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "nbd", "server": { "type": "inet", "host": "localhost", "port": "12345" } } }
> >> 
> >> ?
> >
> > Exactly the same way you would write it when running qmp-shell in
> > interactive mode.  e.g.:
> >
> >   $ ./scripts/qmp/qmp-shell /tmp/qmp blockdev-add driver=qcow2 node-name=node-E 'file={"driver":"file","filename":"/path/to/file.qcow2"}'
> 
> I see.
> 
> The QEMU command line uses dotted key syntax instead.

You mean -blockdev, or is there another way to send QMP commands
to QEMU that I'm not aware of?

> 
> To be honest, the less qmp-shell is used, the happier I am.

What people would use instead of it?

>                                                              Would you
> like to serve as its sub-maintainer?

I'd be glad to.

-- 
Eduardo
