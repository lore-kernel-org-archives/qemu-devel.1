Received: from eggs.gnu.org ([209.51.188.92]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMD2a-0003qU-7Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMD2Z-00027l-DP
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:50:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMD2Z-00026R-5I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:50:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id o4so3799896wra.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:50:26 -0700 (PDT)
References: <20190502092728.32727-1-alex.bennee@linaro.org>
	<CABoDooPLQAGi+gtYX+jPaZk9=OgGOLwpJdwfJML-aKMiHu3Azw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CABoDooPLQAGi+gtYX+jPaZk9=OgGOLwpJdwfJML-aKMiHu3Azw@mail.gmail.com>
Date: Thu, 02 May 2019 15:50:24 +0100
Message-ID: <877eb86hcf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>


Laurent Desnogues <laurent.desnogues@gmail.com> writes:

> Hello,
>
> On Thu, May 2, 2019 at 11:31 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> When linux-user/exit was introduced we failed to move the gprof
>> include at the same time. The CI didn't notice because it only builds
>> system emulation. Fix it for those that still find gprof useful.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Sadly running programs then fails because of the SIG_PROF signal getting
passed to the guest. I wonder how this ever worked?

--
Alex Benn=C3=A9e
