Received: from eggs.gnu.org ([2001:4830:134:3::10]:35312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceNoB-0006ka-D2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceNo8-0001sA-9e
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:17:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceNo8-0001rc-3w
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:17:20 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 508FF8553C
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 15:17:20 +0000 (UTC)
Message-ID: <1487258237.32455.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 16:17:17 +0100
In-Reply-To: <20170120211107.GD21555@thinpad.lan.raisama.net>
References: <20170117184638.25809-1-ehabkost@redhat.com>
	<20170120211107.GD21555@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/3] arch_init: Move soundhw code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On Fr, 2017-01-20 at 19:11 -0200, Eduardo Habkost wrote:
> Ping? Any feedback?
>=20
> On Tue, Jan 17, 2017 at 04:46:35PM -0200, Eduardo Habkost wrote:
> > This moves the arch_init.c soundhw code to its own file, renames
> > audio_init() to soundhw_init(), and renames hw/audio/audio.h to
> > hw/audio/soundhw.h.

Looks good to me.  Seems to need a rebase though, tried to add to the
audio queue but it doesn't apply.  Can you send a rebase?

thanks,
  Gerd
