Received: from eggs.gnu.org ([2001:4830:134:3::10]:45627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5WKO-0008H8-GV
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5WKL-0004jW-EI
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5WKL-0004ir-7N
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:50:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170502061649.6668.93083.stgit@PASHA-ISP>
Date: Tue, 02 May 2017 13:50:42 +0200
In-Reply-To: <20170502061649.6668.93083.stgit@PASHA-ISP> (Pavel Dovgalyuk's
	message of "Tue, 02 May 2017 09:16:49 +0300")
Message-ID: <87vapjlbot.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] maintainers: add maintainer for replay*
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> writes:

> Updating MAINTAINERS to set Pavel Dovgalyuk as record/replay maintainer.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  MAINTAINERS |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1d2b3a4d3..8be1c74ac5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1546,6 +1546,15 @@ F: net/colo*
>  F: net/filter-rewriter.c
>  F: net/filter-mirror.c
>  
> +Record/replay
> +M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> +W: http://wiki.qemu.org/Features/record-replay
> +S: Supported
> +F: replay/*
> +F: block/blkreplay.c
> +F: net/filter-replay.c
> +F: include/sysemu/replay.h
> +
>  Usermode Emulation
>  ------------------
>  Overall

Reviewed-by: Markus Armbruster <armbru@redhat.com>
