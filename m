Received: from eggs.gnu.org ([2001:4830:134:3::10]:36355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyC5T-0002Qg-Ar
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyC5O-00066O-CI
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:25:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fyC5O-00063z-6F
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:25:50 -0400
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-3-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fbd32e27-eaa3-5ef0-c6ec-926577a14d56@redhat.com>
Date: Fri, 7 Sep 2018 10:25:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/12] cutils: add qemu_pstrcmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 2018-09-07 09:59, Marc-Andr=C3=A9 Lureau wrote:
> A char** variant of strcmp().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/cutils.h | 12 ++++++++++++
>  util/cutils.c         |  5 +++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 47aaa3b0b9..0941639f36 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -169,4 +169,16 @@ bool test_buffer_is_zero_next_accel(void);
>  int uleb128_encode_small(uint8_t *out, uint32_t n);
>  int uleb128_decode_small(const uint8_t *in, uint32_t *n);
> =20
> +/**
> + * qemu_pstrcmp:
> + * @str1: a pointer to a C string
> + * @str2: a pointer to a C string
> + *
> + * Compares *str1 and *str2 with g_strcmp0().
> + *
> + * Returns: an integer less than, equal to, or greater than zero, if
> + * *str1 is <, =3D=3D or > than *str2 .
> + */

Maybe add a comment that str1 or str2 can also be NULL?

Reviewed-by: Thomas Huth <thuth@redhat.com>
