Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZDFa-00015C-5m
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZCzn-0005Yg-4N
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:53:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gZCzm-0005Sn-L9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:53:03 -0500
Received: by mail-wm1-x333.google.com with SMTP id f188so1590632wmf.5
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:53:02 -0800 (PST)
References: <20181217105650.27361-1-alex.bennee@linaro.org>
	<20181217105650.27361-9-alex.bennee@linaro.org>
	<20181218014707.GA10098@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181218014707.GA10098@flamenco>
Date: Tue, 18 Dec 2018 10:53:00 +0000
Message-ID: <87tvjb9kdv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 08/15] tests/fp: add fp-bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Dec 17, 2018 at 10:56:43 +0000, Alex Benn=C3=A9e wrote:
>> From: "Emilio G. Cota" <cota@braap.org>
>> +static void update_random_ops(int n_ops, enum precision prec)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < n_ops; i++) {
>> +        uint64_t r =3D random_ops[i];
>> +
>> +        if (prec =3D=3D PREC_SINGLE || PREC_FLOAT32) {
>> +            do {
>> +                r =3D xorshift64star(r);
>> +            } while (!float32_is_normal(r));
>> +        } else if (prec =3D=3D PREC_DOUBLE || PREC_FLOAT64) {
>
> I just noticed that there's a bug here (I was seeing non-normals
> where I didn't expect any):
>
>      for (i =3D 0; i < n_ops; i++) {
>          uint64_t r =3D random_ops[i];
>
> -        if (prec =3D=3D PREC_SINGLE || PREC_FLOAT32) {
> +        if (prec =3D=3D PREC_SINGLE || prec =3D=3D PREC_FLOAT32) {
>              do {
>                  r =3D xorshift64star(r);
>              } while (!float32_is_normal(r));
> -        } else if (prec =3D=3D PREC_DOUBLE || PREC_FLOAT64) {
> +        } else if (prec =3D=3D PREC_DOUBLE || prec =3D=3D PREC_FLOAT64) {
>              do {
>                  r =3D xorshift64star(r);
>              } while (!float64_is_normal(r));
>
> Let me know if you want me to send a proper patch (this is non-critical
> so it's OK to fix after merging) or you'd rather fix it up directly.
<snip>

I'll fix it up an resubmit - I suspect it won't get merged until the new
year now anyway.

--
Alex Benn=C3=A9e
