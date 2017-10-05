Received: from eggs.gnu.org ([2001:4830:134:3::10]:38944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e08ep-0003f8-Rs
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e08ep-0002Tv-2g
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:05:55 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:48714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e08eo-0002Sh-PA
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:05:55 -0400
Received: by mail-wm0-x230.google.com with SMTP id i124so3030135wmf.3
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:05:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005155504.GK12106@redhat.com>
References: <20171005100106.30118-1-kraxel@redhat.com>
	<CAFEAcA-9F++KngXrHGE=t7qZhdU2gCGKKSwHXYdLR6EhEfO4Qg@mail.gmail.com>
	<20171005155504.GK12106@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 17:05:32 +0100
Message-ID: <CAFEAcA-ogPm4YeL+eYtAhM=d0NhqcD0PMXyON+P3hAdeL6hiOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Ui 20171005 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2017 at 16:55, Daniel P. Berrange <berrange@redhat.com> wrote:
> Am I right in thinking from this snippet, that you applied the patch
> series to an existing checkout with built files and then just did a
> 'make', as opposed todoing a git clean + configure + make sequence.

I did what I usually do: I did a git merge of the pull request
and applied my usual set of build tests, some of which do a 'make clean'
and some of which do incremental make (and none of which do a git
clean). This needs to work because incremental build is a very common
workflow...

thanks
-- PMM
