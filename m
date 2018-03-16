Received: from eggs.gnu.org ([2001:4830:134:3::10]:33369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewlkG-0000Eb-7m
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewlkD-0008Os-3e
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:33:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewlkC-0008Nb-QA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:33:49 -0400
References: <20180315191958.28937-1-laurent@vivier.eu>
	<8ed72173-427f-d16f-bcec-26649511836d@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <381ae840-5b37-2341-192c-1bc0f24bcb11@vivier.eu>
Date: Fri, 16 Mar 2018 10:33:42 +0100
MIME-Version: 1.0
In-Reply-To: <8ed72173-427f-d16f-bcec-26649511836d@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: fix TCGv array overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Le 15/03/2018 à 20:34, Richard Henderson a écrit :
> On 03/16/2018 03:19 AM, Laurent Vivier wrote:
>> I try to fix this by introducing a new TCG function
>> to try to free a TCGv if it is a temporary one and
>> do nothing otherwise (patches 1 and 2)
> 
> I would prefer not to approach this in this way.

OK. This is why it was an RFC.

> Better is to have translator helpers that allocate temps
> that are freed at the end of the insn.
> 
> C.f. new_tmp_a64 in target/arm/translate-a64.c.

I'm going to try that.

Thank you,
Laurent
