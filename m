Received: from eggs.gnu.org ([209.51.188.92]:35678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaNn-0007Pk-68
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaNl-0008F9-47
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:45:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaNh-00086D-Cd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:45:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id f2so2352721wmj.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:45:46 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-4-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-4-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:45:44 +0100
Message-ID: <87k1f74k47.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 03/12] target/rx: CPU definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
<snip>
> +{
> +    *pc =3D env->pc;
> +    *cs_base =3D 0;
> +    *flags =3D FIELD_DP32(*flags, PSW, PM, env->psw_pm);

You can't reference flags here, the caller expect you to be setting it's
value. Otherwise the compiler will rightfully complain you've just
accessed unitialised data.

  *flags =3D FIELD_DP32(0, PSW, PM, env->psw_pm);


--
Alex Benn=C3=A9e
