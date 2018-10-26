Received: from eggs.gnu.org ([2001:4830:134:3::10]:38208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gG2CE-0000c0-M8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gG2CB-0002St-Dv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:30:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gG2CA-0002Oi-W3
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:30:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id r63-v6so1523397wma.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 06:30:30 -0700 (PDT)
References: <784f1213-282f-14ca-4126-145dead59a77@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <784f1213-282f-14ca-4126-145dead59a77@gmail.com>
Date: Fri, 26 Oct 2018 14:30:27 +0100
Message-ID: <87efcc25u4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest application exit point.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Rafael K. V. Maeda" <rafaelkioji@gmail.com>
Cc: qemu-devel@nongnu.org


Rafael K. V. Maeda <rafaelkioji@gmail.com> writes:

> Hi,
>
> I am implementing a plugin that allocates several resources. I need to
> cleanup some of these resources when QEMU finishes executing the guest
> application. Where is the best exit point to place my cleanup
> functions?
>
> I have tried registering a function call "atexit" but it does not seem
> to work. Any suggestions? At the moment, I am looking for a solution
> for x86_64 (user emulation mode).

For linux-user have a look at preexit_cleanup() in linux-user/exit.c

>
> Kind regards,
> Rafael


--
Alex Benn=C3=A9e
