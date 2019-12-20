Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D23CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 08:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084A1206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 08:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cAKHx1WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084A1206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiDov-00066E-5E
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 03:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iiDo4-0005YY-0O
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 03:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iiDo1-0007ME-RV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 03:38:43 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:56691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iiDo0-0006zS-Ip; Fri, 20 Dec 2019 03:38:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47fMbG5jwkz9sPc; Fri, 20 Dec 2019 19:38:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576831114;
 bh=zVzY3KvMBYHFimsJvmES5imXTCeGug8MHqqkcsnUfCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cAKHx1WSMrHEc+Zb2aIj1VrsZEMyWa7VELRtjLyAp3C6B/bnGy7BIz4mt8diRantL
 Tl2tyJtP7H4Q/za3nj5eyXlTMX1nVeOMj+KWmLdQ3Jw2nJ1m6QfBGr11vR9X15UBJg
 EKVtIru98bL4A8vva6SjDEcPX5pqRRnyhB1lhcQ8=
Date: Fri, 20 Dec 2019 19:23:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 1/6] tpm: Move tpm_tis_show_buffer to tpm_util.c
Message-ID: <20191220082303.GA2304@umbus.fritz.box>
References: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
 <20191219140605.3243321-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20191219140605.3243321-2-stefanb@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 09:06:00AM -0500, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Do you want me to queue this in my ppc tree?

> ---
>  hw/tpm/tpm_tis.c    | 32 ++++----------------------------
>  hw/tpm/tpm_util.c   | 25 +++++++++++++++++++++++++
>  hw/tpm/tpm_util.h   |  3 +++
>  hw/tpm/trace-events |  2 +-
>  4 files changed, 33 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 7aaf9b946d..5b17c88a7d 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -107,30 +107,6 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr add=
r)
>      return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
>  }
> =20
> -static void tpm_tis_show_buffer(const unsigned char *buffer,
> -                                size_t buffer_size, const char *string)
> -{
> -    size_t len, i;
> -    char *line_buffer, *p;
> -
> -    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
> -
> -    /*
> -     * allocate enough room for 3 chars per buffer entry plus a
> -     * newline after every 16 chars and a final null terminator.
> -     */
> -    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
> -
> -    for (i =3D 0, p =3D line_buffer; i < len; i++) {
> -        if (i && !(i % 16)) {
> -            p +=3D sprintf(p, "\n");
> -        }
> -        p +=3D sprintf(p, "%.2X ", buffer[i]);
> -    }
> -    trace_tpm_tis_show_buffer(string, len, line_buffer);
> -
> -    g_free(line_buffer);
> -}
> =20
>  /*
>   * Set the given flags in the STS register by clearing the register but
> @@ -156,8 +132,8 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t =
flags)
>   */
>  static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
>  {
> -    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
> -        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
> +    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> +        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
>      }
> =20
>      /*
> @@ -325,8 +301,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
>      s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
>      s->rw_offset =3D 0;
> =20
> -    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
> -        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
> +    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> +        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
>      }
> =20
>      if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 62b091f0c0..c0a0f3d71f 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -350,3 +350,28 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
>      tsb->buffer =3D NULL;
>      tsb->size =3D 0;
>  }
> +
> +void tpm_util_show_buffer(const unsigned char *buffer,
> +                          size_t buffer_size, const char *string)
> +{
> +    size_t len, i;
> +    char *line_buffer, *p;
> +
> +    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
> +
> +    /*
> +     * allocate enough room for 3 chars per buffer entry plus a
> +     * newline after every 16 chars and a final null terminator.
> +     */
> +    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
> +
> +    for (i =3D 0, p =3D line_buffer; i < len; i++) {
> +        if (i && !(i % 16)) {
> +            p +=3D sprintf(p, "\n");
> +        }
> +        p +=3D sprintf(p, "%.2X ", buffer[i]);
> +    }
> +    trace_tpm_util_show_buffer(string, len, line_buffer);
> +
> +    g_free(line_buffer);
> +}
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index f397ac21b8..7889081fba 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -79,4 +79,7 @@ typedef struct TPMSizedBuffer {
> =20
>  void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
> =20
> +void tpm_util_show_buffer(const unsigned char *buffer,
> +                          size_t buffer_size, const char *string);
> +
>  #endif /* TPM_TPM_UTIL_H */
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 89804bcd64..357c9e9a84 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -14,6 +14,7 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expec=
ted) "tpm_resp->len =3D %u,
>  tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_r=
esp->hdr.len =3D %u, expected =3D %zu"
>  tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp-=
>len =3D %u, expected =3D %zu"
>  tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
> +tpm_util_show_buffer(const char *direction, size_t len, const char *buf)=
 "direction: %s len: %zu\n%s"
> =20
>  # tpm_emulator.c
>  tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
> @@ -36,7 +37,6 @@ tpm_emulator_pre_save(void) ""
>  tpm_emulator_inst_init(void) ""
> =20
>  # tpm_tis.c
> -tpm_tis_show_buffer(const char *direction, size_t len, const char *buf) =
"direction: %s len: %zu\nbuf: %s"
>  tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
>  tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
>  tpm_tis_abort(uint8_t locty) "New active locality is %d"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl38hOQACgkQbDjKyiDZ
s5LbIBAAzuMGmCjw6L1LF753F7UlyGkwWmA7NGwiMfcITtljpiwBYwFtZlA7sCW3
0kVwp0EjdIyFj4+qd+KThz+o7hp7THQ470PFYD28qRRnWoiBT8YnMXasB37WDbsG
VOm+u3rUBq5FvapluHZmwyvrYCO7Y8SbkGT1Lx+PgVLfKUrlImB9qt+UkEwl2w0I
oT/glc/Nl0z5O1CCT5yuPIHKWLTk0WQwOIPpRIiO0ovoGrw7On+m9CZttZ2edM66
aEM5U/AFisPXaC3gbkb2Zt3shGb89J8hcS1Ux4bClKF9RiexyKiOvz1N3BfhXNJ6
tknYyiLsuOvZyuB8VDPNp+TUVggwj7l9OVtJAyqtv8+JgoNf1d+6tOxLl3i6+W9Q
xR48cIcWqhqq7NvSEanJb8UICTfcvCL3olqia8IHCrLN0CPiuaP/W2mc4/JoRXrm
ct50CtDFv7AykEZy5z+AMEFNe9bqo6ck2itJ+KEigzKwYAD1tRSnMusMpnzneRxX
KTuLJ+0XUTEQMf4hEysR1Ig83bUBRVOqpgb/G/YUNp5uZ9JlAyeNdn7SI5rnxJl4
C9TPXifr5O+Nle97cFMhReTq9LscuS3UliVTq5D/VmQlreBJma+mQYASCqQVgfL1
+ND5bCkQnBOCerXUHaN7VViU1dTeN6q5av+CvgSU1KK5Sxhv9kI=
=4fyI
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

