Received: from eggs.gnu.org ([2001:4830:134:3::10]:33772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRMPl-0006IW-FZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRMPh-0000i7-Dw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:19:25 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:38254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRMPf-0000fu-FM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:19:21 -0500
Received: by mail-pg1-x535.google.com with SMTP id g189so6617892pgc.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:19:15 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org> <87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<CAHDbmO1NTj0NcXoxM-iPFCECATkcpbf9tcg2SLvm4GYtoPx1PQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b22c9d78-9568-6904-d681-23a03a6a91b7@linaro.org>
Date: Mon, 26 Nov 2018 11:19:11 -0800
MIME-Version: 1.0
In-Reply-To: <CAHDbmO1NTj0NcXoxM-iPFCECATkcpbf9tcg2SLvm4GYtoPx1PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 11/26/18 10:56 AM, Alex Bennée wrote:
> 
> 
> On Mon, 26 Nov 2018, 18:27 Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org> wrote:
> 
>     On 11/26/18 6:52 AM, Alex Bennée wrote:
>     > I'm not convinced this is the best way to go about it. We end up having
>     > to sprinkle the plugin calls into each decoder rather than keeping all
>     > the infrastructure in the common main loop. However the common loop will
>     > need to know the total number of bytes decoded so we could change the
>     > declaration to:
>     >
>     >   int (*translate_insn)(DisasContextBase *db, CPUState *cpu);
>     >
>     > and return the number of bytes decoded.
> 
>     Returning the number of bytes is more difficult than simply just
> 
>         old_pc = db->pc_next;
>         opc->translate_insn(db, cpu);
>         bytes = db->pc_next - old_pc;
> 
>     requiring no target changes at all.
> 
> 
> If that's always true then great, but what happens with direct branches?

pc_next is still updated by the size of the branch, not it's destination;
db->is_jmp will be != DISAS_NEXT, ending the TB.


r~
