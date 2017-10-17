Received: from eggs.gnu.org ([2001:4830:134:3::10]:42273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4R2a-0008KE-Ch
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4R2U-00066C-V2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:32:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-37-f4bug@amsat.org>
	<0e1e9d13-9b7f-ef72-757b-7b4262986a48@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7070309a-db76-b9ca-7f2c-0b0bbf5b509a@amsat.org>
Date: Tue, 17 Oct 2017 09:31:46 -0300
MIME-Version: 1.0
In-Reply-To: <0e1e9d13-9b7f-ef72-757b-7b4262986a48@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/39] i386/pc: move pvpanic.c from
 hw/misc/ to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 10/17/2017 08:04 AM, Paolo Bonzini wrote:> pvpanic does not _have_ to
be i386-specific, and losing the
> configurability with default-configs/ is a bit of a pity (there are
> people who change the configurations), so I think it's better to leave
> out this change.

Good to know, OK! (patch dropped)
