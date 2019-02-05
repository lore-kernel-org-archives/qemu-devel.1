Received: from eggs.gnu.org ([209.51.188.92]:47556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0bq-0007pM-5J
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0bp-0002df-7H
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:17:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr0bo-0002cd-UW
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:17:53 -0500
Received: by mail-ot1-x342.google.com with SMTP id g16so5502655otg.11
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-2-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 13:17:35 +0000
Message-ID: <CAFEAcA9fzLNP1ic1oK6wS4v=_7rKa2Y0cKjH=Fc_-6MOowSuvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/18] tests/vm: Be verbose while
 extracting compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 29 Jan 2019 at 17:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Depending of the host hardware, copying and extracting VM images can
> take up to few minutes. Add verbosity to avoid the user to worry about
> VMs hanging.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/vm/centos  | 3 ++-
>  tests/vm/freebsd | 3 ++-
>  tests/vm/netbsd  | 3 ++-
>  tests/vm/openbsd | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
