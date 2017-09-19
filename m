Received: from eggs.gnu.org ([2001:4830:134:3::10]:44643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duERr-0005bv-H4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duERl-0003Eb-Ja
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:04:07 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:44571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duERl-0003EF-Cg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:04:01 -0400
Received: by mail-wr0-x235.google.com with SMTP id v109so2476968wrc.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:04:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918215719.16415-1-f4bug@amsat.org>
References: <20170918215719.16415-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 10:03:39 +0100
Message-ID: <CAFEAcA8wBR6R9FNgmg0YAPuVVxjj5Ls_xEoS1VZ8OdxjJK1mrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl.c: add is_system_on_chip flag to
 force board default cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 September 2017 at 22:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> add a property to restrict the CPU for SoCs once on machine creation and =
avoid
> duplicate code in each board.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com
>
>  include/hw/boards.h |  3 +++
>  vl.c                | 11 +++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6b67adaef6..20dc0a0ab9 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -129,6 +129,8 @@ typedef struct {
>   *    specifies default CPU_TYPE, which will be used for parsing target
>   *    specific features and for creating CPUs if CPU name wasn't provide=
d
>   *    explicitly at CLI
> + * @is_system_on_chip:
> + *    If true, board does not support other CPUs than default_cpu_type.

Being an SoC isn't the only reason a board might only support one
CPU type (perhaps it just never existed with other than a single
CPU soldered into it), so maybe a different name?

thanks
-- PMM
