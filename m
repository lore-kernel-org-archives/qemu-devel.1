Received: from eggs.gnu.org ([2001:4830:134:3::10]:40047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUTP2-0004Tk-2D
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUTOy-0003V6-58
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUTOx-0003Us-UZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:46:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86EC1267C9
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:46:38 +0000 (UTC)
Date: Mon, 10 Jul 2017 15:46:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170710074633.GA8951@lemon.lan>
References: <20170710072027.7948-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 07/10 15:20, Fam Zheng wrote:
> Last time we've looked at "-object iothread,spawns=N" but it was a bit abusive.
> A dedicated "iothread-group" class is cleaner from the interface point of view.
> This series does that.
> 
> It has the same set of poll parameters as the existing "iothread" object, plus
> a "size" option to specify how many threads to start. Using iothread-group
> doesn't require the user to explicitly create the contained IOThreads. The
> IOThreads are created by the group object.
> 
> Internally, IOThreads share one AioContext.  This is to make it easier to adapt
> this to the current data plane code (see the last patch). But it is an
> implementation detail, and will change depending on the block layer multiqueue
> needs.

I forgot to mention that the last patch depends on

    [PATCH v3 00/20] qdev: Introduce DEFINE_PROP_LINK

Fam
