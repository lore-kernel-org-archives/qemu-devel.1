Received: from eggs.gnu.org ([2001:4830:134:3::10]:53634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIG9-0002HR-8p
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIG8-0002LA-JD
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:13:29 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzIG8-0002KA-Ao
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:13:28 -0400
Received: by mail-wm0-x241.google.com with SMTP id y139-v6so20590294wmc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 02:13:28 -0700 (PDT)
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180903171831.15446-5-cota@braap.org>
Date: Mon, 10 Sep 2018 10:13:26 +0100
Message-ID: <87efe1d8ax.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] cpus: initialize
 timers_state.vm_clock_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> We forgot to initialize the spinlock introduced in 94377115b2
> ("cpus: protect TimerState writes with a spinlock", 2018-08-23).
> Fix it.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/cpus.c b/cpus.c
> index 8ee6e5db93..ebc13bac2d 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -823,6 +823,7 @@ int cpu_throttle_get_percentage(void)
>  void cpu_ticks_init(void)
>  {
>      seqlock_init(&timers_state.vm_clock_seqlock);
> +    qemu_spin_init(&timers_state.vm_clock_lock);
>      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
>      throttle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
>                                             cpu_throttle_timer_tick, NULL=
);


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
