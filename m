Received: from eggs.gnu.org ([2001:4830:134:3::10]:55892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8q9-0002Eg-AA
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8q8-0002dP-EW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:08:01 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk8q8-0002d5-8O
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:08:00 -0400
Received: by mail-oi0-x242.google.com with SMTP id k12-v6so21437068oiw.8
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 07:08:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180727132311.2777-1-f4bug@amsat.org>
References: <20180727132311.2777-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 15:07:39 +0100
Message-ID: <CAFEAcA8eyggMm5QH_VyJYHO2orQUgS1vRdRV9s4qrit+QvpiJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/arm: Remove duplicate 'host' entry
 in '-cpu ?' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 July 2018 at 14:23, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Since 86f0a186d6f the TYPE_ARM_HOST_CPU is only compiled when CONFIG_KVM
> is enabled.
>
> Remove the now redundant special-case introduced in a96c0514ab7, to avoid=
:
>
>   $ qemu-system-aarch64 -machine virt -cpu \? | fgrep host
>   host
>   host (only available in KVM mode)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/arm/helper.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 22d812240a..66afb08ee0 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5591,12 +5591,6 @@ void arm_cpu_list(FILE *f, fprintf_function cpu_fp=
rintf)
>      (*cpu_fprintf)(f, "Available CPUs:\n");
>      g_slist_foreach(list, arm_cpu_list_entry, &s);
>      g_slist_free(list);
> -#ifdef CONFIG_KVM
> -    /* The 'host' CPU type is dynamically registered only if KVM is
> -     * enabled, so we have to special-case it here:
> -     */
> -    (*cpu_fprintf)(f, "  host (only available in KVM mode)\n");
> -#endif
>  }

Applied to target-arm.next for 3.0, thanks.

-- PMM
