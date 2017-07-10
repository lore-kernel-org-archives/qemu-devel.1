Received: from eggs.gnu.org ([2001:4830:134:3::10]:36342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUdrN-0001a9-CE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUdrM-0005T7-Jy
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:56:41 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
	<20170710154749.13624-3-alex.bennee@linaro.org>
	<CAFEAcA8OjCS9=UJ6NV2_PgT7zciOmcnvrzpTY6FL55D8x965aw@mail.gmail.com>
	<0b397419-08d4-b29d-028e-fe196d8122a3@twiddle.net>
	<87mv8c9m3a.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <261b7f4f-d3dc-d23b-aeba-8709941de579@twiddle.net>
Date: Mon, 10 Jul 2017 08:55:29 -1000
MIME-Version: 1.0
In-Reply-To: <87mv8c9m3a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/6] target/arm/translate.c: make
 DISAS_UPDATE match declared semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 08:35 AM, Alex Bennée wrote:
> Well this was more in the guise of having well defined semantics across
> all the translators. I agree just keeping DISAS_EXIT is cleaner w.r.t
> the ARM code.

I hope we can do that within the context of (or after) LLuis' changes.
Doing it beforehand is just going to confuse the issue.

> So without messing with where we do gen_set_pc_im(dc, dc->pc); shall I
> just cut this down to not falling through to DISAS_JUMP?

Yes, that seems like the best short-term solution.


r~
