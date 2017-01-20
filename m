Received: from eggs.gnu.org ([2001:4830:134:3::10]:50387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUajh-0007zI-PV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUaje-0005Tg-0O
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:04:17 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cUajd-0005T8-Rp
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:04:13 -0500
Received: by mail-ot0-x241.google.com with SMTP id 73so7778044otj.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 07:04:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pojheqfu.fsf@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-6-alex.bennee@linaro.org>
	<878tq6r03a.fsf@gmail.com> <87pojheqfu.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 20 Jan 2017 10:03:42 -0500
Message-ID: <CAJhHMCBf8o2sh9nS7piLnU+Hh=TUGOkbV1BU85R9DQLsG6ghHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 05/27] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Claudio Fontana <claudio.fontana@huawei.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Fri, Jan 20, 2017 at 9:50 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> That's the wrong way round. TCG_DEFAULT_MO is the guest memory order.
> Maybe I should rename them to be explicitly:
>
> TCG_GUEST_DEFAULT_MO
> TCG_HOST_DEFAULT_MO
>
> But that introduces another terminology into the TCG code.
>

Ah, that's not the first time I got confused. May be just add a comment?


--=20
Pranith
