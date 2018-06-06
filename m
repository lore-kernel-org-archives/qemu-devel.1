Received: from eggs.gnu.org ([2001:4830:134:3::10]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQWl6-00060U-Aa
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQWl3-0004zD-6l
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQWl3-0004yp-2d
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11D0840BC05B
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 11:37:40 +0000 (UTC)
Date: Wed, 6 Jun 2018 13:37:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180606113739.betayc2s6czm5267@sirius.home.kraxel.org>
References: <20180606104357.GB3205@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606104357.GB3205@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] 100% host cpu with gtk3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jun 06, 2018 at 06:43:57PM +0800, Fam Zheng wrote:
> Hi Gerd,
> 
> When using the gtk frontend, it seems there is a busy loop in libgtk repeatedly
> calling recvmsg, causing 100% cpu on the main thread. This started to appear
> after I upgraded to Fedora 28. Is this a known problem?

No, didn't saw this (but running rhel-7 on my workstation).

> Any hints on how to track it down?

perf top, maybe with with call graphs would be the first thing I
would try ...

cheers,
  Gerd
