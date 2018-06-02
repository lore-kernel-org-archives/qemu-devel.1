Received: from eggs.gnu.org ([2001:4830:134:3::10]:33685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPCjV-00047y-JL
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 16:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPCjU-0005Id-U5
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 16:02:37 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:44782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fPCjU-0005IR-LN
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 16:02:36 -0400
Received: by mail-pf0-x230.google.com with SMTP id h12-v6so4105908pfk.11
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 13:02:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601131352.6ab033aa@bahia.lan>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<5d222847166f7f3f2b05e7e8a0a0ab3d7520b49d.1527814874.git.keno@juliacomputing.com>
	<20180601131352.6ab033aa@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 2 Jun 2018 16:01:54 -0400
Message-ID: <CABV8kRyNgQMKdRnKVnJ9anCi0pR59qAXN_P_UP9aAqGRZErHCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 15/20] 9p: darwin: *xattr_nofollow
 implementations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> I guess this calls for some defines in 9p.h:
>
> /* 9p2000.L says that the 'flags' argument of operation 'xattrcreate'
>  * are derived from Linux setxattr.
>  */
> #define P9_XATTR_CREATE  1
> #define P9_XATTR_REPLACE 2
>
> Please do that in a preparatory patch.
>
> I would also appreciate you look at other 9P operations and
> check if we have other places where we need to translate
> some flags.

I will include this additional patch in the next respin of the series.
I took a look at the remaining protocol messages and it looks
like with the exception of this and unlinkat (the other patch in the
series), flags/open modes are translated properly.
