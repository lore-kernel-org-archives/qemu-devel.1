Received: from eggs.gnu.org ([2001:4830:134:3::10]:36946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnhtM-0005U7-8h
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnhtH-0004JQ-GH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:10:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnhtH-0004Hz-8U
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:09:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id u12-v6so4641894wrr.4
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 03:09:59 -0700 (PDT)
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809034033.10579-6-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 11:09:57 +0100
Message-ID: <87lg9fq2a2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] target/arm: Fix typo in
 helper_sve_ld1hss_r
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Cc: qemu-stable@nongnu.org (3.0.1)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/sve_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index c3cbec9cf5..e03f954a26 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4045,7 +4045,7 @@ DO_LD1(sve_ld1bdu_r, cpu_ldub_data_ra, uint64_t, ui=
nt8_t, )
>  DO_LD1(sve_ld1bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
>
>  DO_LD1(sve_ld1hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
> -DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
> +DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int16_t, H1_4)
>  DO_LD1(sve_ld1hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
>  DO_LD1(sve_ld1hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )


--
Alex Benn=C3=A9e
