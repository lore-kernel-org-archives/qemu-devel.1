Received: from eggs.gnu.org ([2001:4830:134:3::10]:49972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNczx-0007S1-EJ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNczw-00044W-QN
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:41:05 -0400
Date: Tue, 29 May 2018 13:40:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180529134053.1ea9f46d.cohuck@redhat.com>
In-Reply-To: <20180528232719.4721-10-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/21] target: Do not include
 "exec/exec-all.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open
	list:S390" <qemu-s390x@nongnu.org>

On Mon, 28 May 2018 20:27:07 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Code change produced with:
>     $ git grep '#include "exec/exec-all.h"' | \
>       cut -d: -f-1 | \
>       xargs egrep -L "(cpu_address_space_init|cpu_loop_|tlb_|tb_|GETPC|si=
nglestep|TranslationBlock)" | \

Hm, does this expression catch all files that need to include
exec-all.h? The resulting patch seems fine, though.

>       xargs sed -i.bak '/#include "exec\/exec-all.h"/d'
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
