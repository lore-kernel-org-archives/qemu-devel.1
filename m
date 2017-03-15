Received: from eggs.gnu.org ([2001:4830:134:3::10]:35628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co9mK-0005OO-D3
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co9mJ-0007h9-98
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:19:52 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1co9mJ-0007gy-2v
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:19:51 -0400
Received: by mail-wm0-x234.google.com with SMTP id u132so12024518wmg.0
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:19:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314200641.2958-1-ehabkost@redhat.com>
References: <20170314200641.2958-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 14:19:29 +0000
Message-ID: <CAFEAcA9TQuP0xV0NM6gZF5ZX1adQ-iX5cpHEkkAqBKZarht3JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] Fix global property and -cpu handling
 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Bandan Das <bsd@redhat.com>

On 14 March 2017 at 20:06, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:
>
>   Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-pull-request
>
> for you to fetch changes up to 0bcba41fe379e4c6834adcf1456d9099db31a5b2:
>
>   machine: Convert abstract typename on compat_props to subclass names (2017-03-14 16:53:44 -0300)
>
> ----------------------------------------------------------------
> Fix global property and -cpu handling bug
>
> This bug fix was supposed to be applied just after 2.8.0 was
> released, but it slipped through the cracks. Sending it now for
> the next -rc.
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (1):
>   machine: Convert abstract typename on compat_props to subclass names
>
>  hw/core/machine.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
