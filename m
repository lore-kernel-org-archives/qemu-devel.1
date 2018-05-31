Received: from eggs.gnu.org ([2001:4830:134:3::10]:53741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOSem-000338-Vr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 14:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOSei-0008F0-3e
	for qemu-devel@nongnu.org; Thu, 31 May 2018 14:50:41 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOSeh-0008Dh-Tr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 14:50:36 -0400
Date: Thu, 31 May 2018 20:50:32 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180531185032.2rr6u4pfja2twew5@var.youpi.perso.aquilenet.fr>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-24-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-24-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/67] slirp: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org

Hello,

Michael S. Tsirkin, le jeu. 03 mai 2018 22:51:01 +0300, a ecrit:
> +#include_next "../slirp/ip6.h"

Mmm, this is the first time #include_next would be used in qemu, and I
don't think this is a standard thing...

Samuel
