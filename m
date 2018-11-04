Received: from eggs.gnu.org ([2001:4830:134:3::10]:37748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQoD-0003n2-R2
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQoD-0003JB-2F
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJQoC-0003HS-ND
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:23:52 -0500
References: <20181104112424.18663-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a68e6cad-ef57-a704-7574-b99e3f46482b@redhat.com>
Date: Sun, 4 Nov 2018 23:23:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, cohuck@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/11/2018 12:24, Stefan Hajnoczi wrote:
> v3:
>  * Fix broken openhackware URL [Eric]
>  * Convert a few remaining URLs [Eric]
> v2:
>  * Use HTTPS for repo.or.cz [Eric]
> 
> Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HTTPS is
> the preferred protocol because it adds some protection against
> man-in-the-middle when cloning a repo.
> 
> This patch series updates git:// URLs and changes them to https://.  The https:// URL format is:
> 
>   https://git.qemu.org/git/<project>.git
> 
> The old git:// URL format was:
> 
>   git://git.qemu.org/<project>.git
> 
> I have also updated git://github.com/ and repo.or.cz URLs because they offer HTTPS.
> 
> I have tested that submodules continue to work after the change to .gitmodules.

Thanks!  I've send a similar patch for qemu-web.git.

Paolo

> 
> Stefan Hajnoczi (8):
>   README: use 'https://' instead of 'git://'
>   get_maintainer: use 'https://' instead of 'git://'
>   MAINTAINERS: use 'https://' instead of 'git://' for GitHub
>   gitmodules: use 'https://' instead of 'git://'
>   git: use HTTPS git URLs for repo.or.cz
>   pc-testdev: use HTTPS git URL
>   target-alpha: use HTTPS git URL for palcode
>   docker: use HTTPS git URL for virglrenderer
> 
>  MAINTAINERS                                  | 88 ++++++++++----------
>  hw/misc/pc-testdev.c                         |  2 +-
>  .gitmodules                                  | 34 ++++----
>  README                                       |  4 +-
>  pc-bios/README                               |  8 +-
>  scripts/get_maintainer.pl                    |  2 +-
>  tests/docker/dockerfiles/debian-amd64.docker |  2 +-
>  7 files changed, 70 insertions(+), 70 deletions(-)
> 
