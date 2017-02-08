Received: from eggs.gnu.org ([2001:4830:134:3::10]:44649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cbZu2-0006ob-NJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cbZu1-00007g-PZ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:50 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cbZu1-00007B-LD
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:49 -0500
Received: by mail-yw0-x242.google.com with SMTP id v73so12945780ywg.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:35:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87a89yxqky.fsf@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<20170206153113.27729-6-alex.bennee@linaro.org>
	<CAJhHMCDJS31TtUs0z4g5bjZctPG9nV9fBdENgJeD7OrqqvOzcg@mail.gmail.com>
	<87a89yxqky.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 8 Feb 2017 16:35:16 -0500
Message-ID: <CAJhHMCCc1kGO+Ekk1P92irstAxeyrPW9+XNecS_t7xz77FrtTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 05/23] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Alex,

On Tue, Feb 7, 2017 at 5:06 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Pranith Kumar <bobby.prani@gmail.com> writes:
>
> >> +
> >> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> >> +{
> >> +    const char *t =3D qemu_opt_get(opts, "thread");
> >> +    if (t) {
> >> +        if (strcmp(t, "multi") =3D=3D 0) {
> >> +            if (TCG_OVERSIZED_GUEST) {
> >> +                error_setg(errp, "No MTTCG when guest word size >
> hosts");
> >> +            } else {
> >> +                if (!check_tcg_memory_orders_compatible()) {
> >> +                    error_report("Guest requires stronger MO that
> host");
> >>
> >
> > s/MO that host/MO than host/?
>
> Good catch.
>
> >
> > Also, this message is a bit cryptic for end users. How about saying
> "Guest
> > and host architectures are incompatible, you may encounter errors!" or
> > something similar?
>
> "Guest assumes a stronger memory ordering than the host provides, this
> may cause strange/hard to debug errors."
>
> ?
>

s/assumes/expects/?

Otherwise, this statement looks good to me.

Thanks,
--=20
Pranith
