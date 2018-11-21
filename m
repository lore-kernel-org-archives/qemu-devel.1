Received: from eggs.gnu.org ([2001:4830:134:3::10]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPRLq-0006tv-82
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPRAu-0004Iq-IB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:00:10 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPRAu-0004IP-61
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:00:08 -0500
Received: by mail-oi1-x244.google.com with SMTP id p82-v6so4279282oih.11
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 04:00:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1f31e8e0-cde2-db7a-56ae-26eb70bb13d9@redhat.com>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-2-minyard@acm.org>
	<8add8514-f353-b914-78e8-e9f3e9be840d@redhat.com>
	<c0c4051d-fe57-7399-9904-65425c6efc26@acm.org>
	<CAFEAcA_Ubfuf-w66JJcPT+nWFFw-aa+Wfdm1ocGHf+VCSM_-qQ@mail.gmail.com>
	<1f31e8e0-cde2-db7a-56ae-26eb70bb13d9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Nov 2018 11:59:46 +0000
Message-ID: <CAFEAcA-naK9m3hm_kVgTfdn_T3a3bK6i0jbtTv-=7sC77yje2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/12] i2c: Split smbus into parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Corey Minyard <minyard@acm.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 20 November 2018 at 19:30, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 20/11/18 16:47, Peter Maydell wrote:
>> We don't yet use SPDX headers. (They're just a different and
>> shorter way to write the license statement.)
>
>
> Does that mean we can use them, or you rather prefer we don't?
>
> While they are machine parseable, I find them easier to understand than t=
he
> big chunk of legal text that sometime are not correctly written.

It means that I'm not going to absolutely insist on dropping
the line if somebody submits a patch with an SPDX tag, but
I probably will mention that we don't use SPDX tags, and
definitely I'm not going to ask for them.

Overall I don't think there's much point in having them
added to one or two files randomly. If we want them then
we should consistently require them as policy. But that is
work, and so I think we should not do that until/unless
somebody (probably a corporate somebody) steps forward
to make the argument for "this is why we should have them,
we as a contributor to the project think they are worthwhile
and a useful feature for us, and we will make the effort to
add them, review that they are correct, update checkpatch to
insist on tags for new files, etc". In other words, "if it
ain't broke, don't fix it"; nobody is yet complaining that
our current setup is broken.

thanks
-- PMM
