Received: from eggs.gnu.org ([2001:4830:134:3::10]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH3Sh-0002IC-UY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH3Sh-0007P4-75
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:03:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gH3Sg-0007Ol-Vj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:03:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id 189-v6so7335513wmw.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 02:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
In-Reply-To: <20181003114454.5662-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Oct 2018 13:03:37 +0400
Message-ID: <CAJ+F1CJxCqe99yzZaSKD=SP=swE0WaRHMqf_nhkWwziibvo3Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Mark non-volatile memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Guangrong Xiao <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Oct 3, 2018 at 3:46 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> As discussed in the "[PATCH v10 6/6] tpm: add ACPI memory clear
> interface" thread, and proposed in the "[PATCH] RFC: mark non-volatile
> memory region", here is a small series to mark non-volvatile memory
> regions and skip them on dump. Upcoming TCG "Platform Reset Attack
> Mitigation" will also use this information to eventually skip
> non-volatile memory.
>
> Thanks
>
> Marc-Andr=C3=A9 Lureau (3):
>   memory: learn about non-volatile memory region
>   nvdimm: set non-volatile on the memory region
>   memory-mapping: skip non-volatile memory regions in GuestPhysBlockList

Only last patch got reviews, but that means the first are probably ok as we=
ll.
Is anybody reviewing & picking the series?

thanks

>
>  include/exec/memory.h    | 25 ++++++++++++++++++++++
>  hw/mem/nvdimm.c          |  1 +
>  memory.c                 | 45 +++++++++++++++++++++++++++++++---------
>  memory_mapping.c         |  3 ++-
>  docs/devel/migration.rst |  1 +
>  5 files changed, 64 insertions(+), 11 deletions(-)
>
> --
> 2.19.0.271.gfe8321ec05
>
>


--=20
Marc-Andr=C3=A9 Lureau
