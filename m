Received: from eggs.gnu.org ([2001:4830:134:3::10]:46589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOjJx-0000c9-3c
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOjJr-00026O-CQ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:10:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gOjJr-00024H-7A
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2324D3DE06
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 13:10:26 +0000 (UTC)
References: <20181116132931.8737-1-kraxel@redhat.com>
	<20181116132931.8737-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18814747-c3b1-75c9-f04a-fed50f81b987@redhat.com>
Date: Mon, 19 Nov 2018 07:10:21 -0600
MIME-Version: 1.0
In-Reply-To: <20181116132931.8737-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Erik Skultety <eskultet@redhat.com>

On 11/16/18 7:29 AM, Gerd Hoffmann wrote:
> From: Erik Skultety <eskultet@redhat.com>
> 
> Unlike SPICE, egl-headless doesn't offer a way of specifying the DRM
> node used for OpenGL, hence QEMU always selecting the first one that is
> available. Thus, add the 'rendernode' option for egl-headless to QAPI.
> 
> Signed-off-by: Erik Skultety <eskultet@redhat.com>
> Message-id: 7658e15eca72d520e7a5fb1c2e724702d83d4f7f.1542362949.git.eskultet@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   qapi/ui.json | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

This has already landed, but I noticed via an off-list discussion that 
it is not introspectible through query-qmp-schema, because 
DisplayOptions is currently used only for command line handling. I don't 
know off-hand whether query-command-line-options even exposes the 
existence of DisplayOptions (not all of our command line options can be 
queried), but even if it does, I also know that our current command line 
queries are not detailed enough to readily expose the addition of a new 
optional member.  I think it would be appropriate for the 3.1 timeframe 
to add a new QMP command that exposes the display configuration set up 
at runtime, if only so that the DisplayOptions becomes visible through 
query-qmp-commands as a bug fix for making this change easier to use.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
