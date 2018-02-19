Received: from eggs.gnu.org ([2001:4830:134:3::10]:33975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eniDb-0006ZF-Mn
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eniDY-0003RU-JE
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:58:43 -0500
References: <1518824446-20235-1-git-send-email-cota@braap.org>
	<1518824446-20235-2-git-send-email-cota@braap.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <143c1ee0-2315-388d-26a3-d4f96a4f3bb9@redhat.com>
Date: Mon, 19 Feb 2018 10:58:24 +0100
MIME-Version: 1.0
In-Reply-To: <1518824446-20235-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] target/s390x: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

>      switch (status) {
> -    case EXIT_GOTO_TB:
> -    case EXIT_NORETURN:
> +    case DISAS_GOTO_TB:
> +    case DISAS_NORETURN:
>          break;
> -    case EXIT_PC_STALE:
> -    case EXIT_PC_STALE_NOCHAIN:
> +    case DISAS_TOO_MANY:
> +    case DISAS_PC_STALE:
> +    case DISAS_PC_STALE_NOCHAIN:
>          update_psw_addr(&dc);


Not sure if this is really the right thing to do for DISAS_TOO_MANY but
it seems to work for now :)

>          /* FALLTHRU */
> -    case EXIT_PC_UPDATED:
> +    case DISAS_PC_UPDATED:
>          /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
>             cc op type is in env */
>          update_cc_op(&dc);
>          /* FALLTHRU */
> -    case EXIT_PC_CC_UPDATED:
> +    case DISAS_PC_CC_UPDATED:
>          /* Exit the TB, either by raising a debug exception or by retu=
rn.  */
>          if (do_debug) {
>              gen_exception(EXCP_DEBUG);
> -        } else if (use_exit_tb(&dc) || status =3D=3D EXIT_PC_STALE_NOC=
HAIN) {
> +        } else if (use_exit_tb(&dc) || status =3D=3D DISAS_PC_STALE_NO=
CHAIN) {
>              tcg_gen_exit_tb(0);
>          } else {
>              tcg_gen_lookup_and_goto_ptr();
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
