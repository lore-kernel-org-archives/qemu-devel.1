Received: from eggs.gnu.org ([2001:4830:134:3::10]:45633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwhSg-0005lJ-MF
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwhSd-0004hd-Ir
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwhSd-0004hI-C8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:27:07 -0400
References: <1504729728-23279-1-git-send-email-cota@braap.org>
	<1504729728-23279-3-git-send-email-cota@braap.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56622fe7-22cf-4a41-01e0-8e64cbef412f@redhat.com>
Date: Tue, 26 Sep 2017 06:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <1504729728-23279-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/6] plugin: add initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On 06.09.2017 22:28, Emilio G. Cota wrote:
[...]
> diff --git a/plugin.c b/plugin.c
> new file mode 100644
> index 0000000..3cd19df
> --- /dev/null
> +++ b/plugin.c
> @@ -0,0 +1,519 @@
> +/* plugin.c - QEMU Plugin interface
> + *
> + * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */

If you introduce new .c files, please add some sentences with a proper
description in the header with some very high level description about
what the code in the file is supposed to be doing. Just reading "plugin
interface" is not really very helpful when trying to understand new code.

 Thanks,
  Thomas
