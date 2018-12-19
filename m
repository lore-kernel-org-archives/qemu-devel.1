Received: from eggs.gnu.org ([2001:4830:134:3::10]:50496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZYMu-00036f-58
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZYMq-0003nZ-Ur
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:42:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZYMq-0003mo-Nu
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:42:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F13C89ACC
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 09:42:15 +0000 (UTC)
Date: Wed, 19 Dec 2018 10:42:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219094213.lqh244w35unsbejc@sirius.home.kraxel.org>
References: <20180222070513.8740-1-kraxel@redhat.com>
	<20180222070513.8740-6-kraxel@redhat.com>
	<20181218184532.GA18660@redhat.com>
	<20181219075510.ci3yypwj3f2plcnv@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219075510.ci3yypwj3f2plcnv@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] keymap: consider modifier state
 when picking a mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Adam Williamson <awilliam@redhat.com>

  Hi,
 
> > This is quite horrible though. I'm more inclined
> > to revert this patch and find another way to fix the original problem
> > which won't require the UI frontends to track modifier state.
> 
> The UIs track modifier state anyway.
> 
> I fact I have some WIP patches to add a generic keyboard state tracker,
> so the UIs can use common code instead of having their own state
> tracking code each.  Also to make UI hotkeys configurable, consistent
> across all UIs we have.  Guess I should undust them, at least the state
> tracking part of it.
> 
> With that in place we can easily pass the full keyboard state to the
> keymap code.

Tried that:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/kbd-state

Not polished yet.

cheers,
  Gerd
