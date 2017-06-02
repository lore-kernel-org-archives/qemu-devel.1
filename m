Received: from eggs.gnu.org ([2001:4830:134:3::10]:55007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGlkZ-0004j5-DY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGlkY-0000Jk-Cm
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:32:19 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGlkY-0000JQ-4y
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:32:18 -0400
Received: by mail-wm0-x231.google.com with SMTP id d127so25404789wmf.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 05:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494860396-24930-3-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
	<1494860396-24930-3-git-send-email-Milos.Stojanovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 13:31:56 +0100
Message-ID: <CAFEAcA9H0WW7URH0mmLVEwuUXUXZNn6nurXkxUMVgc41QgsKOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/16] linux-user: add tkill(),
 tgkill() and rt_sigqueueinfo() strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <Milos.Stojanovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Miodrag.Dinic@rt-rk.com, Laurent Vivier <laurent@vivier.eu>, Petar Jovanovic <Petar.Jovanovic@rt-rk.com>, Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>, Yongbok Kim <yongbok.kim@imgtec.com>

On 15 May 2017 at 15:59, Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk=
.com> wrote:
> Improve strace support for syscall tkill(), tgkill() and rt_sigqueueinfo(=
)
> by implementing print functions that match arguments types of the system
> calls and add them to the corresponding starce.list entry.
>
> tkill:
> Prior to this commit, typical strace output used to look like this:
> 4886 tkill(4886,50,0,4832615904,0,-9151031864016699136) =3D 0
> After this commit, it looks like this:
> 4886 tkill(4886,50) =3D 0
>
> tgkill:
> Prior to this commit, typical strace output used to look like this:
> 4890 tgkill(4890,4890,50,8,4832630528,4832615904) =3D 0
> After this commit, it looks like this:
> 4890 tgkill(4890,4890,50) =3D 0
>
> rt_sigqueueinfo:
> Prior to this commit, typical strace output used to look like this:
> 8307 rt_sigqueueinfo(8307,50,1996483164,0,0,50) =3D 0
> After this commit, it looks like this:
> 8307 rt_sigqueueinfo(8307,50,0x00000040007ff6b0) =3D 0
>
> Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
