Received: from eggs.gnu.org ([2001:4830:134:3::10]:58895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkt1G-0003Yx-Ia
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkt1C-0007Sv-K4
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:26:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fkt1C-0007Sl-Dt
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:26:30 -0400
References: <20180801151417.23655-1-pbonzini@redhat.com>
	<CAAdtpL5Jp+KdspQCUyn=Lz5v3VnK7Pni1TEp4m5CS-bwuuuHRA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b667bf04-6318-3e46-67ef-d055d0bb0d5c@redhat.com>
Date: Wed, 1 Aug 2018 17:26:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5Jp+KdspQCUyn=Lz5v3VnK7Pni1TEp4m5CS-bwuuuHRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fix "Missing break in switch" coverity
 reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 01/08/2018 17:25, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>     @@ -12277,6 +12277,7 @@ int arm_rmode_to_sf(int rmode)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME: add support for TIEAWAY=
 and ODD */
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP, "arm: un=
implemented rounding mode:
>     %d\n",
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0rmode);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through for now */
>=20
>=20
> This one looks weird, hidden bug?

There is already a FIXME comment.

Paolo

> For the rest:
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> <mailto:f4bug@amsat.org>>
