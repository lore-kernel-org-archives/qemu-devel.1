Received: from eggs.gnu.org ([2001:4830:134:3::10]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYSSu-0003Bx-35
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYSSq-0004HN-UQ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:07:28 -0500
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:40052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYSSq-00048Y-NL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:07:24 -0500
Received: from player786.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7443A1641D1
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 09:07:14 +0100 (CET)
Date: Mon, 8 Jan 2018 09:07:11 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180108090711.43251799@bahia.lan>
In-Reply-To: <151520175026.318.5700592450040554843@5adcb62bf0d6>
References: <20180106010739.18201-1-groug@kaod.org>
	<151520175026.318.5700592450040554843@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] 9p patches for 2.12 20170106
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On Fri, 5 Jan 2018 17:22:31 -0800 (PST)
no-reply@patchew.org wrote:

>   CC      hw/acpi/bios-linker-loader.o
> In file included from /tmp/qemu-test/src/fsdev/qemu-fsdev.h:17,
>                  from /tmp/qemu-test/src/fsdev/qemu-fsdev-dummy.c:15:
> /tmp/qemu-test/src/fsdev/file-op-9p.h:98: error: redefinition of typedef 'V9fsPath'
> /tmp/qemu-test/src/fsdev/file-op-9p.h:33: note: previous declaration of 'V9fsPath' was here
> make: *** [fsdev/qemu-fsdev-dummy.o] Error 1

This is caused by patch 3. I'll fix it up in my tree and send another
pull request.
