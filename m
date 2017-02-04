Received: from eggs.gnu.org ([2001:4830:134:3::10]:34066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ca901-0006Ej-JZ
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 17:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ca8zy-0004s0-FZ
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 17:40:05 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:53568)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ca8zy-0004oB-3X
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 17:40:02 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170204143245.15974-1-famz@redhat.com>
Date: Sun, 05 Feb 2017 00:39:45 +0200
In-Reply-To: <20170204143245.15974-1-famz@redhat.com> (Fam Zheng's message of
	"Sat, 4 Feb 2017 22:32:45 +0800")
Message-ID: <87inop8tse.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

Fam Zheng writes:

> We install this file to data dir but since 0ab8ed18 it's no longer
> required by any objects during "make". List it explicitly as a depended
> target of install and fix the broken "make install" command.

I'm probably wrong, but I remember someone worked on making traces
self-descriptive, so that simpletrace would no longer need access to the
generated trace-events-all file.

If the file is really never used, then all stray rules to generate it should be
removed, as well as its installation.

Cheers,
  Lluis
