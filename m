Received: from eggs.gnu.org ([2001:4830:134:3::10]:37774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOTgX-0005Nu-6i
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOTgT-0001kp-BG
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:56:33 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:46150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOTgT-0001k9-4C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:56:29 -0400
Received: from player774.ha.ovh.net (unknown [10.109.105.123])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 82E1B1BA4B5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 21:56:27 +0200 (CEST)
Date: Thu, 31 May 2018 21:56:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531215624.2c7b7083@bahia.lan>
In-Reply-To: <CABV8kRzAJxeEB4rb4R0o7Fx_uBqf82tDDWC_6o0Xht3-F63AOA@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<e47c58ca95c93503a9d85dc6d749acf9fe9c6e76.1527310210.git.keno@alumni.harvard.edu>
	<20180530142026.7c59d967@bahia.lan>
	<CABV8kRzAJxeEB4rb4R0o7Fx_uBqf82tDDWC_6o0Xht3-F63AOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/13] 9p: darwin: Mark mknod as unsupported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

On Thu, 31 May 2018 12:37:56 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> >> +#ifdef CONFIG_DARWIN
> >> +    /* Darwin doesn't have mknodat and it's unlikely to work anyway,  
> >
> > What's unlikely to work ?
> >  
> 
> My concern was that allowing this would cause unexpected
> behavior, since the device numbers will differ between OS X
> and Linux. Though maybe this isn't the place to worry about
> that.

The numbers may differ indeed but we don't really care since the
server never opens device files. This is just a directory entry.
