Received: from eggs.gnu.org ([2001:4830:134:3::10]:40841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHqb0-0007iU-Ew
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHqat-0000Tb-OU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gHqar-0000Go-Pd
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:31:34 -0400
References: <20181031084309.9227-1-stefanha@redhat.com>
	<20181031084309.9227-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6142c381-af70-e0d6-88e6-a2f82943e4ea@redhat.com>
Date: Wed, 31 Oct 2018 08:31:09 -0500
MIME-Version: 1.0
In-Reply-To: <20181031084309.9227-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: use 'https://' instead of
 'git://' for GitHub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 10/31/18 3:43 AM, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 37 insertions(+), 37 deletions(-)

We should also do the same for maintainers using git://repo.or.cz:

$ wget -S 
'https://repo.or.cz/qemu/ericb.git/info/refs?service=git-upload-pack' 
2>&1 | grep Content-Type
   Content-Type: application/x-git-upload-pack-advertisement

For example, my entry would benefit from:

diff --git i/MAINTAINERS w/MAINTAINERS
index 3275cc6bbed..b4b6a5b5df1 100644
--- i/MAINTAINERS
+++ w/MAINTAINERS
@@ -2049,7 +2049,7 @@ F: include/block/nbd*
  F: qemu-nbd.*
  F: blockdev-nbd.c
  F: docs/interop/nbd.txt
-T: git git://repo.or.cz/qemu/ericb.git nbd
+T: git https://repo.or.cz/qemu/ericb.git nbd

  NFS
  M: Jeff Cody <jcody@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
