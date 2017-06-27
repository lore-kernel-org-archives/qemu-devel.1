Received: from eggs.gnu.org ([2001:4830:134:3::10]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPgB9-0002P7-W7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPgB6-0006Dj-0I
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:24:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPgB5-0006DO-Pr
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:24:31 -0400
Date: Mon, 26 Jun 2017 23:24:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627022421.GT12152@localhost.localdomain>
References: <20170615141715.17708-1-sferdjao@redhat.com>
	<20170615141715.17708-2-sferdjao@redhat.com>
	<2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
	<20170618031516.GN22043@thinpad.lan.raisama.net>
	<8965c06b-0859-0819-1fc4-d09dd287fec8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8965c06b-0859-0819-1fc4-d09dd287fec8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu: add capability for vhost-net
 busy polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laine Stump <laine@redhat.com>, libvir-list@redhat.com, sferdjao@redhat.com, berrange@redhat.com, Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, Jun 26, 2017 at 07:23:50AM -0600, Eric Blake wrote:
> On 06/17/2017 09:15 PM, Eduardo Habkost wrote:
> > (CCing qemu-devel and the QAPI maintainers.  I have a question
> > about introspection below.)
> > 
> 
> > 
> > Fortunately, netdev options are modelled in the QAPI schema as
> > union Netdev.  However, 'query-qmp-schema' doesn't seem to
> > include union Netdev because it is not referenced by any QMP
> > command or event.
> 
> I've posted patches in the past (qemu 2.6 timeframe, if I recall) that
> changed netdev_add into a fully-advertised interface, but we didn't take
> it then because we weren't sure how to handle the fact that netdev_add
> can currently accept both an integer (1) and a string ("1") as
> identical, and we didn't want to risk breaking clients that passed a
> string when the promoted command would only accept integers.  I guess we
> should revive that.
> 
> > 
> > Markus, Eric, Michael: is there any way libvirt can query the
> > definition of union Netdev from the schema with current QEMU?
> 
> Really, we need to promote netdev_add to a full-fledged QMP command.

This may be enough for -netdev, but do we want to make command-line
option introspection always depend on having the same struct being used
in a QMP command to work?  What if the arguments for the command-line
option don't match precisely the input of a QMP command?

-- 
Eduardo
