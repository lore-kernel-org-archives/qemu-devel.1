Received: from eggs.gnu.org ([2001:4830:134:3::10]:36060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felix.janda@posteo.de>) id 1ceVvK-0005j9-JL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felix.janda@posteo.de>) id 1ceVvH-0003HP-Fh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:57:18 -0500
Received: from mout02.posteo.de ([185.67.36.66]:55970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felix.janda@posteo.de>)
	id 1ceVvH-0003FP-Ah
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:57:15 -0500
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 26E1C20CAF
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 00:57:10 +0100 (CET)
Date: Thu, 16 Feb 2017 18:54:03 -0500
From: Felix Janda <felix.janda@posteo.de>
Message-ID: <20170216235338.GA487@nyan>
Reply-To: CAFEAcA9Em0dC7Bj73q+EQS0=nAZWGLGGoRjrT0nZq51XgEG-5w@mail.gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Chad Joan <chadjoan@gmail.com>

Defining _GNU_SOURCE causes musl to define everything including
everything protected by _XOPEN_SOURCE. However it does not cause
musl to define _XOPEN_SOURCE.

On the other hand, the ncurses header specifically checks for
_XOPEN_SOURCE or _XOPEN_SOURCE_EXTENDED.

So it is not completely clear where this should be fixed.

-- Felix
