Received: from eggs.gnu.org ([2001:4830:134:3::10]:46682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRKo-0000uU-HD
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRKl-0007iB-9R
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCRKk-0007P1-2o
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:32:35 -0400
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17897835-a1b1-12bd-a0ef-f39d900b59ce@redhat.com>
Date: Mon, 15 Oct 2018 10:44:50 -0500
MIME-Version: 1.0
In-Reply-To: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] archive-source.sh: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 10/15/18 1:51 AM, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete `` and
> modern $(); use of `` is only required when using /bin/sh
> on Solaris. It would be nice to convert to using $()
> everywhere, or at least in all bash scripts, as well as in
> all scripts that are known to not be run on Solaris.

Did you have a particular program you used to find these, or just grep?

Also, when sending a series, don't forget a 0/3 cover letter.

> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>   scripts/archive-source.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
