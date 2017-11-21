Received: from eggs.gnu.org ([2001:4830:134:3::10]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHA66-0005fi-71
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHA60-00029s-LP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:04:26 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHA60-00029T-GP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:04:20 -0500
Received: by mail-oi0-x244.google.com with SMTP id e142so8722008oih.2
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 07:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171121120435.28728-1-stefanha@redhat.com>
References: <20171121120435.28728-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 15:03:58 +0000
Message-ID: <CAFEAcA94yZip99VfKhB07WNe3B5xCKQgMthAiJwp1y1S2sTdXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 0/2] Update qemu.org domains
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 21 November 2017 at 12:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> v2:
>  * Do not change SeaBIOS extraversion string [Eduardo]
>  * Do not change git submodules [Peter]
>
> The first patch replaces qemu-project.org with qemu.org.
>
> The second uses HTTPS URLs instead of HTTP.
>
> I have left out the .gitmodules and SeaBIOS extraversion changes.  They will be
> sent separately.
>
> Stefan Hajnoczi (2):
>   Use qemu.org domain name
>   Use HTTPS for qemu.org and other domains
>
>  MAINTAINERS                |  4 ++--
>  docs/interop/qmp-intro.txt |  4 ++--
>  docs/pcie.txt              |  4 ++--
>  docs/rdma.txt              |  2 +-
>  include/qemu-common.h      |  4 ++--
>  Changelog                  |  2 +-
>  README                     | 18 +++++++++---------
>  pc-bios/README             |  4 ++--
>  qemu-doc.texi              | 18 +++++++++---------
>  qemu.nsi                   |  2 +-
>  scripts/get_maintainer.pl  |  2 +-
>  scripts/qmp/qemu-ga-client |  2 +-
>  version.rc                 |  2 +-
>  13 files changed, 34 insertions(+), 34 deletions(-)

Thanks; applied to master for rc2

-- PMM
