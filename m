Received: from eggs.gnu.org ([2001:4830:134:3::10]:47625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRLbL-00074V-PF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRLbI-000513-Jv
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:27:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:35399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRLbI-0004zU-DX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:27:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id p8so3982736plo.2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 10:27:16 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org> <87lg5f51sz.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
Date: Mon, 26 Nov 2018 10:27:12 -0800
MIME-Version: 1.0
In-Reply-To: <87lg5f51sz.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 11/26/18 6:52 AM, Alex Bennée wrote:
> I'm not convinced this is the best way to go about it. We end up having
> to sprinkle the plugin calls into each decoder rather than keeping all
> the infrastructure in the common main loop. However the common loop will
> need to know the total number of bytes decoded so we could change the
> declaration to:
> 
>   int (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> 
> and return the number of bytes decoded. 

Returning the number of bytes is more difficult than simply just

    old_pc = db->pc_next;
    opc->translate_insn(db, cpu);
    bytes = db->pc_next - old_pc;

requiring no target changes at all.


r~
