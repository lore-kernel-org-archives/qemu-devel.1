Received: from eggs.gnu.org ([209.51.188.92]:57721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfR-00071I-H5
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfO-0003Cz-VE
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:33 -0500
Date: Mon, 7 Jan 2019 11:41:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190107004123.GC13339@umbus.fritz.box>
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20190104181208.7809-4-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 07:12:08PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Many functions have documentation before the implementation in
> cutils.c. Since we expect documentation around the prototype
> declaration in headers, move the comments in cutils.h.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qemu/cutils.h | 224 ++++++++++++++++++++++++++++++++++++++++++
>  util/cutils.c         | 185 ----------------------------------
>  2 files changed, 224 insertions(+), 185 deletions(-)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 644f2d75bd..f41b00ad37 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -47,6 +47,7 @@
>   *    bytes and then add a NUL
>   */
>  void pstrcpy(char *buf, int buf_size, const char *str);
> +
>  /**
>   * strpadcpy:
>   * @buf: buffer to copy string into
> @@ -60,6 +61,7 @@ void pstrcpy(char *buf, int buf_size, const char *str);
>   * first @buf_size characters of @str, with no terminator.
>   */
>  void strpadcpy(char *buf, int buf_size, const char *str, char pad);
> +
>  /**
>   * pstrcat:
>   * @buf: buffer containing existing string
> @@ -77,6 +79,7 @@ void strpadcpy(char *buf, int buf_size, const char *str=
, char pad);
>   * Returns: @buf.
>   */
>  char *pstrcat(char *buf, int buf_size, const char *s);
> +
>  /**
>   * strstart:
>   * @str: string to test
> @@ -94,6 +97,7 @@ char *pstrcat(char *buf, int buf_size, const char *s);
>   * Returns: true if @str starts with prefix @val, false otherwise.
>   */
>  int strstart(const char *str, const char *val, const char **ptr);
> +
>  /**
>   * stristart:
>   * @str: string to test
> @@ -110,6 +114,7 @@ int strstart(const char *str, const char *val, const =
char **ptr);
>   *          false otherwise.
>   */
>  int stristart(const char *str, const char *val, const char **ptr);
> +
>  /**
>   * qemu_strnlen:
>   * @s: string
> @@ -126,6 +131,7 @@ int stristart(const char *str, const char *val, const=
 char **ptr);
>   * Returns: length of @s in bytes, or @max_len, whichever is smaller.
>   */
>  int qemu_strnlen(const char *s, int max_len);
> +
>  /**
>   * qemu_strsep:
>   * @input: pointer to string to parse
> @@ -147,6 +153,16 @@ int qemu_strnlen(const char *s, int max_len);
>   * Returns: the pointer originally in @input.
>   */
>  char *qemu_strsep(char **input, const char *delim);
> +
> +/**
> + * qemu_strchrnul:
> + *
> + * @s: String to parse.
> + * @c: Character to find.
> + *
> + * Searches for the first occurrence of @c in @s, and returns a pointer
> + * to the trailing null byte if none was found.
> + */
>  #ifdef HAVE_STRCHRNUL
>  static inline const char *qemu_strchrnul(const char *s, int c)
>  {
> @@ -155,27 +171,235 @@ static inline const char *qemu_strchrnul(const cha=
r *s, int c)
>  #else
>  const char *qemu_strchrnul(const char *s, int c);
>  #endif
> +
>  time_t mktimegm(struct tm *tm);
>  int qemu_fdatasync(int fd);
>  int fcntl_setfl(int fd, int flag);
>  int qemu_parse_fd(const char *param);
> +
> +/**
> + * qemu_strtoi:
> + *
> + * Convert string @nptr to an integer, and store it in @result.
> + *
> + * This is a wrapper around strtol() that is harder to misuse.
> + * Semantics of @nptr, @endptr, @base match strtol() with differences
> + * noted below.
> + *
> + * @nptr may be null, and no conversion is performed then.
> + *
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
> + *
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL.  This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows @result, store INT_MAX in @result,
> + * and return -ERANGE.
> + *
> + * If the conversion underflows @result, store INT_MIN in @result,
> + * and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
> + */
>  int qemu_strtoi(const char *nptr, const char **endptr, int base,
>                  int *result);
> +
> +/**
> + * qemu_strtoui:
> + *
> + * Convert string @nptr to an unsigned integer, and store it in @result.
> + *
> + * This is a wrapper around strtoul() that is harder to misuse.
> + * Semantics of @nptr, @endptr, @base match strtoul() with differences
> + * noted below.
> + *
> + * @nptr may be null, and no conversion is performed then.
> + *
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
> + *
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL.  This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows @result, store UINT_MAX in @result,
> + * and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
> + *
> + * Note that a number with a leading minus sign gets converted without
> + * the minus sign, checked for overflow (see above), then negated (in
> + * @result's type).  This is exactly how strtoul() works.
> + */
>  int qemu_strtoui(const char *nptr, const char **endptr, int base,
>                   unsigned int *result);
> +
> +/**
> + * qemu_strtol:
> + *
> + * Convert string @nptr to a long integer, and store it in @result.
> + *
> + * This is a wrapper around strtol() that is harder to misuse.
> + * Semantics of @nptr, @endptr, @base match strtol() with differences
> + * noted below.
> + *
> + * @nptr may be null, and no conversion is performed then.
> + *
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
> + *
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL.  This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows @result, store LONG_MAX in @result,
> + * and return -ERANGE.
> + *
> + * If the conversion underflows @result, store LONG_MIN in @result,
> + * and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
> + */
>  int qemu_strtol(const char *nptr, const char **endptr, int base,
>                  long *result);
> +
> +/**
> + * qemu_strtoul:
> + *
> + * Convert string @nptr to an unsigned long, and store it in @result.
> + *
> + * This is a wrapper around strtoul() that is harder to misuse.
> + * Semantics of @nptr, @endptr, @base match strtoul() with differences
> + * noted below.
> + *
> + * @nptr may be null, and no conversion is performed then.
> + *
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
> + *
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL.  This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows @result, store ULONG_MAX in @result,
> + * and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
> + *
> + * Note that a number with a leading minus sign gets converted without
> + * the minus sign, checked for overflow (see above), then negated (in
> + * @result's type).  This is exactly how strtoul() works.
> + */
> +
>  int qemu_strtoul(const char *nptr, const char **endptr, int base,
>                   unsigned long *result);
> +
> +/**
> + * qemu_strtoi64:
> + *
> + * Convert string @nptr to an int64_t.
> + *
> + * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
> + * and INT_MIN on underflow.
> + */
>  int qemu_strtoi64(const char *nptr, const char **endptr, int base,
>                    int64_t *result);
> +
> +/**
> + * qemu_strtou64:
> + *
> + * Convert string @nptr to an uint64_t.
> + *
> + * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
> + */
>  int qemu_strtou64(const char *nptr, const char **endptr, int base,
>                    uint64_t *result);
> +
> +/**
> + * qemu_strtod:
> + *
> + * Convert string @nptr to a double.
> + *
> + * This is a wrapper around strtod() that is harder to misuse.
> + * Semantics of @nptr and @endptr match strtod() with differences
> + * noted below.
> + *
> + * @nptr may be null, and no conversion is performed then.
> + *
> + * If no conversion is performed, store @nptr in *@endptr and return
> + * -EINVAL.
> + *
> + * If @endptr is null, and the string isn't fully converted, return
> + * -EINVAL. This is the case when the pointer that would be stored in
> + * a non-null @endptr points to a character other than '\0'.
> + *
> + * If the conversion overflows, store +/-HUGE_VAL in @result, depending
> + * on the sign, and return -ERANGE.
> + *
> + * If the conversion underflows, store +/-0.0 in @result, depending on t=
he
> + * sign, and return -ERANGE.
> + *
> + * Else store the converted value in @result, and return zero.
> + */
>  int qemu_strtod(const char *nptr, const char **endptr, double *result);
> +
> +/**
> + * qemu_strtod_finite:
> + *
> + * Convert string @nptr to a finite double.
> + *
> + * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
> + * with -EINVAL and no conversion is performed.
> + */
>  int qemu_strtod_finite(const char *nptr, const char **endptr, double *re=
sult);
> =20
> +/**
> + * parse_uint:
> + *
> + * @s: String to parse
> + * @value: Destination for parsed integer value
> + * @endptr: Destination for pointer to first character not consumed
> + * @base: integer base, between 2 and 36 inclusive, or 0
> + *
> + * Parse unsigned integer
> + *
> + * Parsed syntax is like strtoull()'s: arbitrary whitespace, a single op=
tional
> + * '+' or '-', an optional "0x" if @base is 0 or 16, one or more digits.
> + *
> + * If @s is null, or @base is invalid, or @s doesn't start with an
> + * integer in the syntax above, set *@value to 0, *@endptr to @s, and
> + * return -EINVAL.
> + *
> + * Set *@endptr to point right beyond the parsed integer (even if the in=
teger
> + * overflows or is negative, all digits will be parsed and *@endptr will
> + * point right beyond them).
> + *
> + * If the integer is negative, set *@value to 0, and return -ERANGE.
> + *
> + * If the integer overflows unsigned long long, set *@value to
> + * ULLONG_MAX, and return -ERANGE.
> + *
> + * Else, set *@value to the parsed integer, and return 0.
> + */
>  int parse_uint(const char *s, unsigned long long *value, char **endptr,
>                 int base);
> +
> +/**
> + * parse_uint_full:
> + *
> + * @s: String to parse
> + * @value: Destination for parsed integer value
> + * @base: integer base, between 2 and 36 inclusive, or 0
> + *
> + * Parse unsigned integer from entire string
> + *
> + * Have the same behavior of parse_uint(), but with an additional check
> + * for additional data after the parsed number. If extra characters are =
present
> + * after the parsed number, the function will return -EINVAL, and *@v wi=
ll
> + * be set to 0.
> + */
>  int parse_uint_full(const char *s, unsigned long long *value, int base);
> =20
>  int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
> diff --git a/util/cutils.c b/util/cutils.c
> index a8a3a3ba3b..a4c8858712 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -296,30 +296,6 @@ static int check_strtox_error(const char *nptr, char=
 *ep,
>      return -libc_errno;
>  }
> =20
> -/**
> - * Convert string @nptr to an integer, and store it in @result.
> - *
> - * This is a wrapper around strtol() that is harder to misuse.
> - * Semantics of @nptr, @endptr, @base match strtol() with differences
> - * noted below.
> - *
> - * @nptr may be null, and no conversion is performed then.
> - *
> - * If no conversion is performed, store @nptr in *@endptr and return
> - * -EINVAL.
> - *
> - * If @endptr is null, and the string isn't fully converted, return
> - * -EINVAL.  This is the case when the pointer that would be stored in
> - * a non-null @endptr points to a character other than '\0'.
> - *
> - * If the conversion overflows @result, store INT_MAX in @result,
> - * and return -ERANGE.
> - *
> - * If the conversion underflows @result, store INT_MIN in @result,
> - * and return -ERANGE.
> - *
> - * Else store the converted value in @result, and return zero.
> - */
>  int qemu_strtoi(const char *nptr, const char **endptr, int base,
>                  int *result)
>  {
> @@ -348,31 +324,6 @@ int qemu_strtoi(const char *nptr, const char **endpt=
r, int base,
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to an unsigned integer, and store it in @result.
> - *
> - * This is a wrapper around strtoul() that is harder to misuse.
> - * Semantics of @nptr, @endptr, @base match strtoul() with differences
> - * noted below.
> - *
> - * @nptr may be null, and no conversion is performed then.
> - *
> - * If no conversion is performed, store @nptr in *@endptr and return
> - * -EINVAL.
> - *
> - * If @endptr is null, and the string isn't fully converted, return
> - * -EINVAL.  This is the case when the pointer that would be stored in
> - * a non-null @endptr points to a character other than '\0'.
> - *
> - * If the conversion overflows @result, store UINT_MAX in @result,
> - * and return -ERANGE.
> - *
> - * Else store the converted value in @result, and return zero.
> - *
> - * Note that a number with a leading minus sign gets converted without
> - * the minus sign, checked for overflow (see above), then negated (in
> - * @result's type).  This is exactly how strtoul() works.
> - */
>  int qemu_strtoui(const char *nptr, const char **endptr, int base,
>                   unsigned int *result)
>  {
> @@ -407,30 +358,6 @@ int qemu_strtoui(const char *nptr, const char **endp=
tr, int base,
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to a long integer, and store it in @result.
> - *
> - * This is a wrapper around strtol() that is harder to misuse.
> - * Semantics of @nptr, @endptr, @base match strtol() with differences
> - * noted below.
> - *
> - * @nptr may be null, and no conversion is performed then.
> - *
> - * If no conversion is performed, store @nptr in *@endptr and return
> - * -EINVAL.
> - *
> - * If @endptr is null, and the string isn't fully converted, return
> - * -EINVAL.  This is the case when the pointer that would be stored in
> - * a non-null @endptr points to a character other than '\0'.
> - *
> - * If the conversion overflows @result, store LONG_MAX in @result,
> - * and return -ERANGE.
> - *
> - * If the conversion underflows @result, store LONG_MIN in @result,
> - * and return -ERANGE.
> - *
> - * Else store the converted value in @result, and return zero.
> - */
>  int qemu_strtol(const char *nptr, const char **endptr, int base,
>                  long *result)
>  {
> @@ -449,31 +376,6 @@ int qemu_strtol(const char *nptr, const char **endpt=
r, int base,
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to an unsigned long, and store it in @result.
> - *
> - * This is a wrapper around strtoul() that is harder to misuse.
> - * Semantics of @nptr, @endptr, @base match strtoul() with differences
> - * noted below.
> - *
> - * @nptr may be null, and no conversion is performed then.
> - *
> - * If no conversion is performed, store @nptr in *@endptr and return
> - * -EINVAL.
> - *
> - * If @endptr is null, and the string isn't fully converted, return
> - * -EINVAL.  This is the case when the pointer that would be stored in
> - * a non-null @endptr points to a character other than '\0'.
> - *
> - * If the conversion overflows @result, store ULONG_MAX in @result,
> - * and return -ERANGE.
> - *
> - * Else store the converted value in @result, and return zero.
> - *
> - * Note that a number with a leading minus sign gets converted without
> - * the minus sign, checked for overflow (see above), then negated (in
> - * @result's type).  This is exactly how strtoul() works.
> - */
>  int qemu_strtoul(const char *nptr, const char **endptr, int base,
>                   unsigned long *result)
>  {
> @@ -496,12 +398,6 @@ int qemu_strtoul(const char *nptr, const char **endp=
tr, int base,
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to an int64_t.
> - *
> - * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
> - * and INT_MIN on underflow.
> - */
>  int qemu_strtoi64(const char *nptr, const char **endptr, int base,
>                   int64_t *result)
>  {
> @@ -521,11 +417,6 @@ int qemu_strtoi64(const char *nptr, const char **end=
ptr, int base,
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to an uint64_t.
> - *
> - * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
> - */
>  int qemu_strtou64(const char *nptr, const char **endptr, int base,
>                    uint64_t *result)
>  {
> @@ -549,30 +440,6 @@ int qemu_strtou64(const char *nptr, const char **end=
ptr, int base,
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to a double.
> -  *
> - * This is a wrapper around strtod() that is harder to misuse.
> - * Semantics of @nptr and @endptr match strtod() with differences
> - * noted below.
> - *
> - * @nptr may be null, and no conversion is performed then.
> - *
> - * If no conversion is performed, store @nptr in *@endptr and return
> - * -EINVAL.
> - *
> - * If @endptr is null, and the string isn't fully converted, return
> - * -EINVAL. This is the case when the pointer that would be stored in
> - * a non-null @endptr points to a character other than '\0'.
> - *
> - * If the conversion overflows, store +/-HUGE_VAL in @result, depending
> - * on the sign, and return -ERANGE.
> - *
> - * If the conversion underflows, store +/-0.0 in @result, depending on t=
he
> - * sign, and return -ERANGE.
> - *
> - * Else store the converted value in @result, and return zero.
> - */
>  int qemu_strtod(const char *nptr, const char **endptr, double *result)
>  {
>      char *ep;
> @@ -589,12 +456,6 @@ int qemu_strtod(const char *nptr, const char **endpt=
r, double *result)
>      return check_strtox_error(nptr, ep, endptr, errno);
>  }
> =20
> -/**
> - * Convert string @nptr to a finite double.
> - *
> - * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
> - * with -EINVAL and no conversion is performed.
> - */
>  int qemu_strtod_finite(const char *nptr, const char **endptr, double *re=
sult)
>  {
>      double tmp;
> @@ -614,10 +475,6 @@ int qemu_strtod_finite(const char *nptr, const char =
**endptr, double *result)
>      return ret;
>  }
> =20
> -/**
> - * Searches for the first occurrence of 'c' in 's', and returns a pointer
> - * to the trailing null byte if none was found.
> - */
>  #ifndef HAVE_STRCHRNUL
>  const char *qemu_strchrnul(const char *s, int c)
>  {
> @@ -629,34 +486,6 @@ const char *qemu_strchrnul(const char *s, int c)
>  }
>  #endif
> =20
> -/**
> - * parse_uint:
> - *
> - * @s: String to parse
> - * @value: Destination for parsed integer value
> - * @endptr: Destination for pointer to first character not consumed
> - * @base: integer base, between 2 and 36 inclusive, or 0
> - *
> - * Parse unsigned integer
> - *
> - * Parsed syntax is like strtoull()'s: arbitrary whitespace, a single op=
tional
> - * '+' or '-', an optional "0x" if @base is 0 or 16, one or more digits.
> - *
> - * If @s is null, or @base is invalid, or @s doesn't start with an
> - * integer in the syntax above, set *@value to 0, *@endptr to @s, and
> - * return -EINVAL.
> - *
> - * Set *@endptr to point right beyond the parsed integer (even if the in=
teger
> - * overflows or is negative, all digits will be parsed and *@endptr will
> - * point right beyond them).
> - *
> - * If the integer is negative, set *@value to 0, and return -ERANGE.
> - *
> - * If the integer overflows unsigned long long, set *@value to
> - * ULLONG_MAX, and return -ERANGE.
> - *
> - * Else, set *@value to the parsed integer, and return 0.
> - */
>  int parse_uint(const char *s, unsigned long long *value, char **endptr,
>                 int base)
>  {
> @@ -698,20 +527,6 @@ out:
>      return r;
>  }
> =20
> -/**
> - * parse_uint_full:
> - *
> - * @s: String to parse
> - * @value: Destination for parsed integer value
> - * @base: integer base, between 2 and 36 inclusive, or 0
> - *
> - * Parse unsigned integer from entire string
> - *
> - * Have the same behavior of parse_uint(), but with an additional check
> - * for additional data after the parsed number. If extra characters are =
present
> - * after the parsed number, the function will return -EINVAL, and *@v wi=
ll
> - * be set to 0.
> - */
>  int parse_uint_full(const char *s, unsigned long long *value, int base)
>  {
>      char *endp;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwyoDMACgkQbDjKyiDZ
s5JWfw/+J+ws53c5PZgWFbMQ3xWp3f4P27JFjTguCB9flo1byUyugE20oPLXz/TW
xnDzGL70iJU7sRJjtVEbFFRhNWCkIC4a+42kfNRZSJMYa7UUr61TE0OHNXOQfzWQ
fsRWw8qoSKj7wPWBrLm2hmSJr/Ez4Mnk84/wSUrwL4gNZZAa9vhwtTfwgNLDGoAB
3Pm6RB8MMjHXTCZyvGa3ktSrNXvKoM0VNuv5ACGWwNCaE4KZBk8gFiWSMpnog7uu
sbWiGJthu+dGjAxJqoF25cthAJMecPgB8ut+qKEoN9MI3v3TZob+3G3ULw+Yx8q5
6wFr4soVj0/RMiH/+gdXtpEASsXLEWeEEGElxvMSiRZicoDa3WszPVzARP1X4y0g
EKj56LUyUtzvZ3ydAgOi3kRnEwb+uqRM1u2VEQKcoizHtav7rJ0rAXkcwQ+Zx3b4
V5cuut7J3raYls76FY/RigyEsZwYKZW+mhCbYHQMLg7aeLcqKCDjs2ORIoVHlv3Q
tFO/YLJUA3+hnlTr5LtOHZX/EKoV58id0Cb7fUw7ZWR03jCHwFP+4SLowQEcnOq+
0y3dYICykG2opo/bAkDEPuQxfQNIzMr3bB9dgmcN52DBMK47SbRv0Nf4p85sgAXG
NqHMDaAZ/Vzn3UdDVX7tFTkA0lm06fscsd4voz2HKtX+YBO+6CU=
=6Oxa
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
