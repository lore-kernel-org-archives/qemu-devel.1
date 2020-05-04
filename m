Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E70C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 20:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D43B21582
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 20:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIduGHrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D43B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVhJU-0006Ji-AH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 16:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVhIV-0005Tf-Bg; Mon, 04 May 2020 16:02:39 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVhII-000121-Tj; Mon, 04 May 2020 16:02:29 -0400
Received: by mail-lf1-x143.google.com with SMTP id j14so10907752lfg.9;
 Mon, 04 May 2020 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=1ZRVItxSUyE76IZ6saMxIU3BRAPFxl/Gzq7MdyDijYw=;
 b=DIduGHrPqfwghA5rQl59ldTycw3SH+7/6d2j58LDUB7WYPiAUHfJPaHBapqnXrcNq5
 TyW3iyB6XZ6s8I/reQpTFJAyDwnmOkMdtd7eOmq6KrfDGvMSrU5PGZ4CNkW0gQ2nWwtF
 KyuVy9nByo6i77ePT6JhUaubboNHWyjWFHQd0pEVjcK1OW04oJ2MBLq7UfN7Y2sRx8WF
 cqGgF9nNiDUw9DUGdMIZkwRiaEtwzsR5N4dF97Q9XPnNYFcQ78ug3eYgTiVdHsWtt5LA
 2y2/l7yXuAh1/h/y2It6UVVJS+dGmCTGiL+MiyQqrqQjqLlWfwOpNlSKscIUI8g3kWTW
 5/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=1ZRVItxSUyE76IZ6saMxIU3BRAPFxl/Gzq7MdyDijYw=;
 b=lJMNsK2zluOvqzp8A6g8dU4lF+FeSZJEXLT9DycIYsALpew0LRQzfJSemUia0Bdz/M
 YElN11T4MDCUlKCAO8WHPFyoxyNYmvaEwN2TycfI8Vt15ewTj0qn09U3TOXrSZzdFnhp
 lYe/JnqV+xOS4eEFVUgRY/uOHNxt6vDIShru50w7ag6j0yXM5rMlqTcy34666OzRhn98
 m0oXdigfO8b0QmHMmCKhpYfGJe8nCap6xZkgFclkwepLI0u79A7Te4FczON7amgu6hyK
 hN8mCXYxFO0nrUK5yMh/OVy3yTU0va63FcUgZ+MZagplhQTAcZwoFmqNlYMBql2zmNoE
 MEqg==
X-Gm-Message-State: AGi0PubP+iPJwh7JY7y9Mgo96A2Lb0O4upJ5YKN+JQ2HQwNAZu1vo61+
 zNL1Uj8PuEUxkhzc8mrBMUOeXK7MQnjL97MJPoClmFrT0TNqJ4kI
X-Google-Smtp-Source: APiQypJF13V6GfdE9IAj2jFSkujQK0O5Q5AjgBBNP0fuBn2V73wH8rxz1PWc+QqGtQXK+RZlMAvzTtRaGP7AdCXutng=
X-Received: by 2002:a05:6512:3b0:: with SMTP id
 v16mr12691745lfp.213.1588622544101; 
 Mon, 04 May 2020 13:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200504192954.1387-1-luoyonggang@gmail.com>
In-Reply-To: <20200504192954.1387-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 5 May 2020 04:02:12 +0800
Message-ID: <CAE2XoE_-+mGPnowt0VhutfyHNPQPD4XXSG0TdcWf4piyjN5BqA@mail.gmail.com>
Subject: Re: [PATCH] ppc: Use hard-float in ppc fp_hlper as early as possible.
 This would increase the performance better than enable hard-float it
 in
 soft-float.c; Just using fadd fsub fmul fdiv as a simple bench demo. With
 this patch, performance are increased 2x. and 1.3x than the one enable
 hard-float in soft-float.c Both version are not considerate inexact fp
 exception yet.
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006c682e05a4d80298"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: luoyonggang@gmail.com
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006c682e05a4d80298
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bench result;
orignal:
-> FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 27.768 sec
MFLOPS: 38.65
FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 28.359 sec
MFLOPS: 37.84


soft-hard-float:

GCC version: 4.3.3
Ops count: 1073217024
Time spent: 14.874 sec
MFLOPS: 72.15
FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 14.249 sec
MFLOPS: 75.32

direct-hard-float:

-> FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 13.021 sec
MFLOPS: 82.42
FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 12.472 sec
MFLOPS: 86.05
FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 11.803 sec
MFLOPS: 90.93
FLOPS 3.00
GCC version: 4.3.3
Ops count: 1073217024
Time spent: 11.945 sec
MFLOPS: 89.85

bench program:

```
#include <stdio.h>
#include <stdlib.h>
#ifdef __vxworks
#include <sys/resource.h>
#include <vxworks.h>
#include <timers.h>
#include <time.h>
#elif defined(_MSC_VER)
#include <Windows.h>
#include <time.h>
#else
#include <time.h>
#endif
/*
cl -O2 test_flops.c
gcc -O2 test_flops.c -o test_flops

*/
#ifndef DIM
#define DIM 1024
const long long int nop =3D 1073217024;
#else
#define COUNT
long long int nop =3D 0;
#endif

void printm(double A[DIM][DIM])
{
int i,j;
for (i=3D0; i<DIM; i++) {
for (j=3D0; j<DIM; j++)
printf("%6.3f", A[i][j]);
printf("\n");
}
}

void initm(double A[DIM][DIM])
{
int i,j;
srand(38741);
for (i =3D 0; i < DIM; i++)
for (j =3D 0; j < DIM; j++)
A[i][j] =3D (double)rand() / (double)RAND_MAX - 0.5;
}

void dge(double A[DIM][DIM])
{
int i, j, k;
double c;
for (k =3D 1; k < DIM; k++) {
for (i =3D k; i < DIM; i++) {
c =3D A[i][k-1] / A[k-1][k-1];
#ifdef COUNT
nop +=3D 1;
#endif
for (j =3D 0; j < DIM; j++) {
A[i][j] -=3D c * A[k-1][j];
#ifdef COUNT
nop +=3D 2;
#endif
}
}
}
}

double X[DIM][DIM];

/*
 * return a timestamp with sub-second precision
 * QueryPerformanceCounter and clock_gettime have an undefined starting
point (null/zero)
 * and can wrap around, i.e. be nulled again.
 */
double get_seconds()
{
#ifdef _MSC_VER
  static LARGE_INTEGER frequency;
  if (frequency.QuadPart =3D=3D 0)
    QueryPerformanceFrequency(&frequency);
  LARGE_INTEGER now;
  QueryPerformanceCounter(&now);
  return (now.QuadPart * 1.0) / frequency.QuadPart;
#else
  struct timespec now;
  clock_gettime(CLOCK_REALTIME, &now);
  return now.tv_sec + now.tv_nsec * 1e-9;
#endif
}

int main (int argc, char **argv)
{
double a =3D 1.0;
double b =3D 2.0;
double c =3D a + b;
double t;
int count =3D 1;
int i;
printf("FLOPS %.2lf\n", c);
#ifdef _MSC_VER
printf("MSC_VER version: %d\n", _MSC_VER);
#else
printf("GCC version: " __VERSION__ "\n");
#endif
initm(X);
t =3D get_seconds();
#ifndef __vxworks
if (argc > 1) {
sscanf(argv[1], "%d", &count);
}
#endif
for (i =3D 0; i < count; i +=3D 1) {
dge(X);
}
t =3D get_seconds() - t;
printf("Ops count: %llu\n", nop * count);
printf("Time spent: %.3lf sec\n", t);
printf("MFLOPS: %.2f\n", 1e-6 * nop * count / t );
#ifdef PRINTM
printm(X);
#endif
return 0;
}
```

On Tue, May 5, 2020 at 3:30 AM <luoyonggang@gmail.com> wrote:

> From: Yonggang Luo <luoyonggang@gmail.com>
>
> Just post as an idea to improve PPC fp performance.
> With this idea, we have no need to adjust the helper orders.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/ppc/fpu_helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 2bd49a2cdf..79051e4540 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -926,6 +926,17 @@ static void float_invalid_op_addsub(CPUPPCState *env=
,
> bool set_fpcc,
>  /* fadd - fadd. */
>  float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd + u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_add(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> @@ -941,6 +952,17 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1,
> float64 arg2)
>  /* fsub - fsub. */
>  float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd - u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_sub(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> @@ -967,6 +989,17 @@ static void float_invalid_op_mul(CPUPPCState *env,
> bool set_fprc,
>  /* fmul - fmul. */
>  float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd * u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_mul(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> @@ -997,6 +1030,17 @@ static void float_invalid_op_div(CPUPPCState *env,
> bool set_fprc,
>  /* fdiv - fdiv. */
>  float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd / u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_div(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> --
> 2.23.0.windows.1
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006c682e05a4d80298
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Bench result;<div>orignal:<br>-&gt; FLOPS 3.00 =C2=A0 =C2=
=A0 <br>GCC version: 4.3.3<br>Ops count: 1073217024 <br>Time spent: 27.768 =
sec<br>MFLOPS: 38.65<br>FLOPS 3.00 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>GCC versi=
on: 4.3.3<br>Ops count: 1073217024 <br>Time spent: 28.359 sec<br>MFLOPS: 37=
.84<br><br><br>soft-hard-float:<br><br>GCC version: 4.3.3<br>Ops count: 107=
3217024 <br>Time spent: 14.874 sec<br>MFLOPS: 72.15<br>FLOPS 3.00 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>GCC version: 4.3.3<br>Ops count: 1073217024 <br>Tim=
e spent: 14.249 sec<br>MFLOPS: 75.32<br><br>direct-hard-float:<br><br>-&gt;=
 FLOPS 3.00 =C2=A0 =C2=A0 <br>GCC version: 4.3.3<br>Ops count: 1073217024 <=
br>Time spent: 13.021 sec<br>MFLOPS: 82.42<br>FLOPS 3.00 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<br>GCC version: 4.3.3<br>Ops count: 1073217024 <br>Time spent: 1=
2.472 sec<br>MFLOPS: 86.05<br>FLOPS 3.00 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>GCC=
 version: 4.3.3<br>Ops count: 1073217024 <br>Time spent: 11.803 sec<br>MFLO=
PS: 90.93<br>FLOPS 3.00 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>GCC version: 4.3.3<b=
r>Ops count: 1073217024 <br>Time spent: 11.945 sec<br>MFLOPS: 89.85<br></di=
v><div><br></div><div>bench program:</div><div><br></div><div>```</div><div=
>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br>#ifdef __vxworks<=
br>#include &lt;sys/resource.h&gt;<br>#include &lt;vxworks.h&gt;<br>#includ=
e &lt;timers.h&gt;<br>#include &lt;time.h&gt;<br>#elif defined(_MSC_VER)<br=
>#include &lt;Windows.h&gt;<br>#include &lt;time.h&gt;<br>#else<br>#include=
 &lt;time.h&gt;<br>#endif<br>/*<br>cl -O2 test_flops.c<br>gcc -O2 test_flop=
s.c -o test_flops<br><br>*/<br>#ifndef DIM<br>#define DIM 1024<br>const lon=
g long int nop =3D 1073217024;<br>#else<br>#define COUNT<br>long long int n=
op =3D 0;<br>#endif<br><br>void printm(double A[DIM][DIM])<br>{<br>	int i,j=
;<br>	for (i=3D0; i&lt;DIM; i++) {<br>		for (j=3D0; j&lt;DIM; j++)<br>			pr=
intf(&quot;%6.3f&quot;, A[i][j]);<br>		printf(&quot;\n&quot;);<br>	}<br>}<b=
r><br>void initm(double A[DIM][DIM])<br>{<br>	int i,j;<br>	srand(38741);<br=
>	for (i =3D 0; i &lt; DIM; i++)<br>		for (j =3D 0; j &lt; DIM; j++)<br>			=
A[i][j] =3D (double)rand() / (double)RAND_MAX - 0.5;<br>}<br><br>void dge(d=
ouble A[DIM][DIM])<br>{<br>	int i, j, k;<br>	double c;<br>	for (k =3D 1; k =
&lt; DIM; k++) {<br>		for (i =3D k; i &lt; DIM; i++) {<br>			c =3D A[i][k-1=
] / A[k-1][k-1];<br>#ifdef COUNT<br>			nop +=3D 1;<br>#endif<br>			for (j =
=3D 0; j &lt; DIM; j++) {<br>				A[i][j] -=3D c * A[k-1][j];<br>#ifdef COUN=
T<br>				nop +=3D 2;<br>#endif<br>			}<br>		}<br>	}<br>}<br><br>double X[DI=
M][DIM];<br><br>/*<br>=C2=A0* return a timestamp with sub-second precision<=
br>=C2=A0* QueryPerformanceCounter and clock_gettime have an undefined star=
ting point (null/zero)<br>=C2=A0* and can wrap around, i.e. be nulled again=
.<br>=C2=A0*/<br>double get_seconds()<br>{<br>#ifdef _MSC_VER<br>=C2=A0 sta=
tic LARGE_INTEGER frequency;<br>=C2=A0 if (frequency.QuadPart =3D=3D 0)<br>=
=C2=A0 =C2=A0 QueryPerformanceFrequency(&amp;frequency);<br>=C2=A0 LARGE_IN=
TEGER now;<br>=C2=A0 QueryPerformanceCounter(&amp;now);<br>=C2=A0 return (n=
ow.QuadPart * 1.0) / frequency.QuadPart;<br>#else<br>=C2=A0 struct timespec=
 now;<br>=C2=A0 clock_gettime(CLOCK_REALTIME, &amp;now);<br>=C2=A0 return n=
ow.tv_sec + now.tv_nsec * 1e-9;<br>#endif<br>}<br><br>int main (int argc, c=
har **argv)<br>{<br>	double a =3D 1.0;<br>	double b =3D 2.0;<br>	double c =
=3D a + b;<br>	double t;<br>	int count =3D 1;<br>	int i;<br>	printf(&quot;F=
LOPS %.2lf\n&quot;, c);<br>#ifdef _MSC_VER<br>	printf(&quot;MSC_VER version=
: %d\n&quot;, _MSC_VER);<br>#else<br>	printf(&quot;GCC version: &quot; __VE=
RSION__ &quot;\n&quot;);<br>#endif<br>	initm(X);<br>	t =3D get_seconds();<b=
r>#ifndef __vxworks<br>	if (argc &gt; 1) {<br>		sscanf(argv[1], &quot;%d&qu=
ot;, &amp;count);<br>	}<br>#endif<br>	for (i =3D 0; i &lt; count; i +=3D 1)=
 {<br>		dge(X);<br>	}<br>	t =3D get_seconds() - t;<br>	printf(&quot;Ops cou=
nt: %llu\n&quot;, nop * count);<br>	printf(&quot;Time spent: %.3lf sec\n&qu=
ot;, t);<br>	printf(&quot;MFLOPS: %.2f\n&quot;, 1e-6 * nop * count / t );<b=
r>#ifdef PRINTM<br>	printm(X);<br>#endif<br>	return 0;<br>}<br></div><div>`=
``</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, May 5, 2020 at 3:30 AM &lt;<a href=3D"mailto:luoyonggang@gm=
ail.com">luoyonggang@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">From: Yonggang Luo &lt;<a href=3D"mailto:luoy=
onggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
<br>
Just post as an idea to improve PPC fp performance.<br>
With this idea, we have no need to adjust the helper orders.<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/ppc/fpu_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 44 insertions(+)<br>
<br>
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c<br>
index 2bd49a2cdf..79051e4540 100644<br>
--- a/target/ppc/fpu_helper.c<br>
+++ b/target/ppc/fpu_helper.c<br>
@@ -926,6 +926,17 @@ static void float_invalid_op_addsub(CPUPPCState *env, =
bool set_fpcc,<br>
=C2=A0/* fadd - fadd. */<br>
=C2=A0float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 CPU_DoubleU u1, u2;<br>
+<br>
+=C2=A0 =C2=A0 u1.d =3D arg1;<br>
+=C2=A0 =C2=A0 u2.d =3D arg2;<br>
+=C2=A0 =C2=A0 CPU_DoubleU retDouble;<br>
+=C2=A0 =C2=A0 retDouble.nd =3D u1.nd + u2.nd;<br>
+=C2=A0 =C2=A0 if (likely(float64_is_zero_or_normal(retDouble.d)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Handling inexact */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retDouble.d;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0float64 ret =3D float64_add(arg1, arg2, &amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0int status =3D get_float_exception_flags(&amp;env-&gt;f=
p_status);<br>
<br>
@@ -941,6 +952,17 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1, fl=
oat64 arg2)<br>
=C2=A0/* fsub - fsub. */<br>
=C2=A0float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 CPU_DoubleU u1, u2;<br>
+<br>
+=C2=A0 =C2=A0 u1.d =3D arg1;<br>
+=C2=A0 =C2=A0 u2.d =3D arg2;<br>
+=C2=A0 =C2=A0 CPU_DoubleU retDouble;<br>
+=C2=A0 =C2=A0 retDouble.nd =3D u1.nd - u2.nd;<br>
+=C2=A0 =C2=A0 if (likely(float64_is_zero_or_normal(retDouble.d)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Handling inexact */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retDouble.d;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0float64 ret =3D float64_sub(arg1, arg2, &amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0int status =3D get_float_exception_flags(&amp;env-&gt;f=
p_status);<br>
<br>
@@ -967,6 +989,17 @@ static void float_invalid_op_mul(CPUPPCState *env, boo=
l set_fprc,<br>
=C2=A0/* fmul - fmul. */<br>
=C2=A0float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 CPU_DoubleU u1, u2;<br>
+<br>
+=C2=A0 =C2=A0 u1.d =3D arg1;<br>
+=C2=A0 =C2=A0 u2.d =3D arg2;<br>
+=C2=A0 =C2=A0 CPU_DoubleU retDouble;<br>
+=C2=A0 =C2=A0 retDouble.nd =3D u1.nd * u2.nd;<br>
+=C2=A0 =C2=A0 if (likely(float64_is_zero_or_normal(retDouble.d)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Handling inexact */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retDouble.d;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0float64 ret =3D float64_mul(arg1, arg2, &amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0int status =3D get_float_exception_flags(&amp;env-&gt;f=
p_status);<br>
<br>
@@ -997,6 +1030,17 @@ static void float_invalid_op_div(CPUPPCState *env, bo=
ol set_fprc,<br>
=C2=A0/* fdiv - fdiv. */<br>
=C2=A0float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 CPU_DoubleU u1, u2;<br>
+<br>
+=C2=A0 =C2=A0 u1.d =3D arg1;<br>
+=C2=A0 =C2=A0 u2.d =3D arg2;<br>
+=C2=A0 =C2=A0 CPU_DoubleU retDouble;<br>
+=C2=A0 =C2=A0 retDouble.nd =3D u1.nd / u2.nd;<br>
+=C2=A0 =C2=A0 if (likely(float64_is_zero_or_normal(retDouble.d)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Handling inexact */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retDouble.d;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0float64 ret =3D float64_div(arg1, arg2, &amp;env-&gt;fp=
_status);<br>
=C2=A0 =C2=A0 =C2=A0int status =3D get_float_exception_flags(&amp;env-&gt;f=
p_status);<br>
<br>
-- <br>
2.23.0.windows.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000006c682e05a4d80298--

