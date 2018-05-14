Received: from eggs.gnu.org ([2001:4830:134:3::10]:35190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAXw-00062s-LH
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIAXv-0003yd-NU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:17:36 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:45695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIAXv-0003yP-Hr
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:17:35 -0400
Received: by mail-oi0-x230.google.com with SMTP id b130-v6so10139692oif.12
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:17:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526074301-211877-1-git-send-email-mst@redhat.com>
References: <1526074301-211877-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 11:17:14 +0100
Message-ID: <CAFEAcA-WWAy_0Ovc34fpnx=yTXk-ieDqoP4JikeeZfRBxRX3bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/3] linux-headers: arch fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, James Hogan <jhogan@kernel.org>

On 11 May 2018 at 22:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> It turns out that we have unistd.h and kvm headers for some
> architectures but not others.  We are thus unable to use e.g. usefaultfd
> on these systems unless system headers have been updated.
>
> Fix up update-linux-headers.sh to make sure we auto-updates
> all architectures which have linux-headers/
> (unfortunately this still does not mean "all linux systems").
>
> Tested on x86 only.
>
> Pls consider merging this through the ARM tree.
>
> changes from v4:
>     dropped s390 chunks - already upstream
>
> Michael S. Tsirkin (3):
>   update-linux-headers.sh: unistd.h, kvm consistency
>   linux-headers: add unistd.h on all arches
>   linux-headers: add kvm header for mips

Hi. Patch 1 doesn't seem to apply to current master -- could you
rebase and resend, please?

thanks
-- PMM
