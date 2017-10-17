Received: from eggs.gnu.org ([2001:4830:134:3::10]:37835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e4XNR-000159-02
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e4XNM-0001R3-TM
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:18:08 -0400
Received: from jessie.kos.to ([212.47.231.226]:36766 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1e4XNM-0001Oh-Mn
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:18:04 -0400
Date: Tue, 17 Oct 2017 19:18:00 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171017191800.GA16659@kos.to>
References: <20171017103514.5859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171017103514.5859-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On Tue, Oct 17, 2017 at 11:35:14AM +0100, Alex Benn=C3=A9e wrote:
> This adds the -dfilter support to linux-user. There is a minor
> checkpatch complaint about formatting which I've ignored for aesthetic
> reasons.

Applied to linux-user, thanks
=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> ---
> v2
>   - add r-b tags
>   - expand comment to mention checkpatch failure
> ---
>  linux-user/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 829f974662..5072aa855b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -3854,6 +3854,11 @@ static void handle_arg_log(const char *arg)
>      qemu_set_log(mask);
>  }
> =20
> +static void handle_arg_dfilter(const char *arg)
> +{
> +    qemu_set_dfilter_ranges(arg, NULL);
> +}
> +
>  static void handle_arg_log_filename(const char *arg)
>  {
>      qemu_set_log_filename(arg, &error_fatal);
> @@ -4054,6 +4059,8 @@ static const struct qemu_argument arg_table[] =3D=
 {
>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
>       "item[,...]", "enable logging of specified items "
>       "(use '-d help' for a list of items)"},
> +    {"dfilter",    "QEMU_DFILTER",     true,  handle_arg_dfilter,
> +     "range[,...]","filter logging based on address range"},
>      {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
>       "logfile",     "write logs to 'logfile' (default stderr)"},
>      {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
> --=20
> 2.14.1
>=20
