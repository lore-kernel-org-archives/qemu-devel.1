Received: from eggs.gnu.org ([2001:4830:134:3::10]:42356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Edx-0003E9-Uk
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Edx-0002be-7j
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:18:37 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171030181459.1951-1-f4bug@amsat.org>
References: <20171030181459.1951-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 15:18:35 -0300
Message-ID: <CAAdtpL44=a-Ws5OQNQCwXN_TYgQFMxnitRrM2hjCCRSSZna7hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

Oops this isn't RFC anymore, this one is v1 ... sorry!

On Mon, Oct 30, 2017 at 3:14 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
[...]
> ---
> since RFC:
>   - use much cleaner object_class_get_list(TYPE_ACCEL, false)
>
>  vl.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
