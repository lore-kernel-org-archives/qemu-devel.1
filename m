Received: from eggs.gnu.org ([2001:4830:134:3::10]:36896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eboNW-0007Ic-Dy
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eboNR-0002Cg-Ly
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:07:46 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eboNR-0002CE-Ee
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:07:41 -0500
Received: by mail-pf0-x244.google.com with SMTP id p1so11604226pfh.4
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 06:07:41 -0800 (PST)
References: <20180116222212.1266-1-laurent@vivier.eu>
	<20180116222212.1266-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eca4c2b4-b400-8550-9373-8825efdb4dda@linaro.org>
Date: Wed, 17 Jan 2018 06:07:36 -0800
MIME-Version: 1.0
In-Reply-To: <20180116222212.1266-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] linux-user,
 m68k: select CPU according to ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aaron Sierra <asierra@xes-inc.com>, YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On 01/16/2018 02:22 PM, Laurent Vivier wrote:
> M680x0 doesn't support the same set of instructions
> as ColdFire, so we can't use "any" CPU type to execute
> m68020 instructions.
> We select CPU type ("m68040" or "any" for ColdFire)
> according to the ELF header. If we can't, we
> use by default the value used until now: "any".
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
