Received: from eggs.gnu.org ([2001:4830:134:3::10]:40686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUaDM-0003I9-6z
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUaDL-00053F-Fo
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:30:52 -0500
MIME-Version: 1.0
In-Reply-To: <87r33ydmts.fsf@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-27-alex.bennee@linaro.org>
	<87a8amr3sj.fsf@gmail.com> <87r33ydmts.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 20 Jan 2017 09:30:20 -0500
Message-ID: <CAJhHMCAdK7A_41=cvE8UFxUkX4t01FyQUELS4fzUwgVs0TVYTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 26/27] tcg: enable MTTCG by default for
 ARM on x86 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Claudio Fontana <claudio.fontana@huawei.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On Fri, Jan 20, 2017 at 5:53 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> The case that x86 doesn't handle normally is store-after-load which is
> what I assumed TCG_MO_LD_ST was. Perhaps we need some better comments
> for each of the enums?
>

OK. The enum is of the form TCG_MO_A_B, where A and B are in program
order. So x86 will be TCG_MO_ST_LD, i.e., a load following a store is
re-ordered before the store.

I'll send a patch adding this comment.

Thanks,
--=20
Pranith
