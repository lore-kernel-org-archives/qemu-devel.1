Received: from eggs.gnu.org ([2001:4830:134:3::10]:48732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIZC0-0007z8-OO
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIZBw-0006De-NL
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gIZBw-0006DI-HH
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:08:48 -0400
References: <20181102124220.26558-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4da1dd16-f076-111a-1217-f7258f3a564a@redhat.com>
Date: Fri, 2 Nov 2018 08:08:36 -0500
MIME-Version: 1.0
In-Reply-To: <20181102124220.26558-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Daniel Berrange <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 11/2/18 7:42 AM, Stefan Hajnoczi wrote:
> v2:
>   * Use HTTPS for repo.or.cz [Eric]
> 
> Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HTTPS is
> the preferred protocol because it adds some protection against
> man-in-the-middle when cloning a repo.
> 
> This patch series updates git:// URLs and changes them to https://.  The https:// URL format is:
> 
>    https://git.qemu.org/git/<project>.git
> 
> The old git:// URL format was:
> 
>    git://git.qemu.org/<project>.git
> 
> I have also updated git://github.com/ and repo.or.cz URLs because they offer HTTPS.
> 
> I have tested that submodules continue to work after the change to .gitmodules.
> 
> Stefan Hajnoczi (5):
>    README: use 'https://' instead of 'git://'
>    get_maintainer: use 'https://' instead of 'git://'
>    MAINTAINERS: use 'https://' instead of 'git://' for GitHub
>    gitmodules: use 'https://' instead of 'git://'
>    git: use HTTPS git URLs for repo.or.cz
> 
>   MAINTAINERS               | 88 +++++++++++++++++++--------------------
>   .gitmodules               | 34 +++++++--------
>   README                    |  4 +-
>   pc-bios/README            |  6 +--
>   scripts/get_maintainer.pl |  2 +-
>   5 files changed, 67 insertions(+), 67 deletions(-)

Other files still mentioning git://:

hw/misc/pc-testdev.c (git.kernel.org)
tests/docker/dockerfiles/debian-amd64.docker (anongit.freedesktop.org)

As I haven't regularly used either of those hosting sites, and was too 
lazy to check if I could clone with smart https:, I'll leave it to you 
to do a followup patch if we care.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
