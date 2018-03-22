Received: from eggs.gnu.org ([2001:4830:134:3::10]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez3zF-0000tu-SS
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez3zF-0003WP-2O
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:26:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8iVaYmnCgQ9-2D=3w_sf6Zs_oAvXBDPL3KVBpomA3PxQ@mail.gmail.com>
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-5-lvivier@redhat.com>
	<CAMo8BfKkwM0wzX1yCBvwJ-Av4SZbgSrxmOGzD+Z_+bY0DTcgYg@mail.gmail.com>
	<6fd26097-aa7e-38cf-0d9e-09d0d36bd88b@redhat.com>
	<CAMo8Bf+K_XCsZ2tLVT15v5v0ssEbGSmYj+HuT-x5UMYZTKBZ4Q@mail.gmail.com>
	<CAFEAcA8iVaYmnCgQ9-2D=3w_sf6Zs_oAvXBDPL3KVBpomA3PxQ@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 10:26:47 -0700
Message-ID: <CAMo8BfJc9A9bJoNHs3wT1jmVyDkRKXxm6NV3OPJ0hXC-qpbWUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] Remove unnecessary variables for
 function return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Mar 22, 2018 at 10:23 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 22 March 2018 at 17:19, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Ok, I can add a fixup that changes #include <xtensa-isa.h> to #include
>> "xtensa-isa.h".
>> Adding #include "qemu/osdep.h" there seems pointless to me.
>
> Every top level .c file must start with including osdep.h.
> Other headers that it might include rely on that.
> It looks like these files aren't actually top level .c files,
> but are only compiled by being #included from some other file.
> Our convention for that kind of thing is to give the file
> a .inc.c extension. If you follow that then clean-includes
> will skip the file rather than trying to apply the requirements
> for a top level .c file to it.

Ok, thanks. Will do that too.

-- 
Thanks.
-- Max
