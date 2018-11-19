Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gOjeZ-0000On-4Q
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gOjeT-0004Uc-Jr
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:31:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gOjeT-0004Ts-E2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:31:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F8AE88308
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 13:31:44 +0000 (UTC)
Date: Mon, 19 Nov 2018 14:31:40 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20181119133140.GB24590@beluga.usersys.redhat.com>
References: <20181116132931.8737-1-kraxel@redhat.com>
	<20181116132931.8737-2-kraxel@redhat.com>
	<18814747-c3b1-75c9-f04a-fed50f81b987@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18814747-c3b1-75c9-f04a-fed50f81b987@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/3] qapi: Add "rendernode" display option
 for egl-headless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Mon, Nov 19, 2018 at 07:10:21AM -0600, Eric Blake wrote:
> On 11/16/18 7:29 AM, Gerd Hoffmann wrote:
> > From: Erik Skultety <eskultet@redhat.com>
> >
> > Unlike SPICE, egl-headless doesn't offer a way of specifying the DRM
> > node used for OpenGL, hence QEMU always selecting the first one that is
> > available. Thus, add the 'rendernode' option for egl-headless to QAPI.
> >
> > Signed-off-by: Erik Skultety <eskultet@redhat.com>
> > Message-id: 7658e15eca72d520e7a5fb1c2e724702d83d4f7f.1542362949.git.eskultet@redhat.com
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   qapi/ui.json | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
>
> This has already landed, but I noticed via an off-list discussion that it is
> not introspectible through query-qmp-schema, because DisplayOptions is
> currently used only for command line handling. I don't know off-hand whether
> query-command-line-options even exposes the existence of DisplayOptions (not

It does not...

> all of our command line options can be queried), but even if it does, I also
> know that our current command line queries are not detailed enough to
> readily expose the addition of a new optional member.  I think it would be
> appropriate for the 3.1 timeframe to add a new QMP command that exposes the
> display configuration set up at runtime, if only so that the DisplayOptions
> becomes visible through query-qmp-commands as a bug fix for making this
> change easier to use.

That would be awesome

Erik
