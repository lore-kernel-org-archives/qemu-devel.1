Received: from eggs.gnu.org ([2001:4830:134:3::10]:56516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNbVl-0006hf-2C
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNbVg-00077u-4Z
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:05:49 -0400
Date: Tue, 29 May 2018 12:05:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180529120533.1a264193.cohuck@redhat.com>
In-Reply-To: <20180528232719.4721-4-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/21] target: Do not include
 "exec/address-spaces.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:S390" <qemu-s390x@nongnu.org>

On Mon, 28 May 2018 20:27:01 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Code change produced with:
>     $ git grep '#include "exec/address-spaces.h"' target | \
>       cut -d: -f-1 | \
>       xargs egrep -L "(get_system_|address_space_)" | \
>       xargs sed -i.bak '/#include "exec\/address-spaces.h"/d'
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/i386/hvf/x86_task.c | 1 -
>  target/s390x/kvm.c         | 1 -
>  target/s390x/mem_helper.c  | 1 -
>  target/s390x/misc_helper.c | 1 -
>  target/sparc/mmu_helper.c  | 1 -
>  5 files changed, 5 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
