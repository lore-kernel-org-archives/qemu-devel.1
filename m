Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFNJq-0003j8-FR
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 10:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFNJl-0000cg-Jb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 10:42:42 -0500
Received: from mail-wj0-f172.google.com ([209.85.210.172]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFNJl-0000cY-68
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 10:42:37 -0500
Received: by mail-wj0-f172.google.com with SMTP id xy5so17761256wjc.0
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:42:37 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-5-git-send-email-rth@twiddle.net>
	<87oa0pz1n4.fsf@linaro.org>
	<d7e69d4d-974b-a3f1-a8b7-86524569740e@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d7e69d4d-974b-a3f1-a8b7-86524569740e@twiddle.net>
Date: Fri, 09 Dec 2016 15:41:33 +0000
Message-ID: <87shpxxg7m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 04/64] tcg/aarch64: Implement field
 extraction opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>


Richard Henderson <rth@twiddle.net> writes:

> On 12/06/2016 04:24 AM, Alex Bennée wrote:
>>> > +    case INDEX_op_extract_i64:
>>> > +    case INDEX_op_extract_i32:
>>> > +        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
>>> > +        break;
>>> > +
>>> > +    case INDEX_op_sextract_i64:
>>> > +    case INDEX_op_sextract_i32:
>>> > +        tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
>>> > +        break;
>>> > +
>> This isn't right is it? As I'm reading it extract takes from a
>> offset+len from the source register to low bits of the destination
>> register. The Bitfield Move instructions are the other way around,
>> moving from the low order bits in the source register to an offset+len
>> in the destination.
>>
>
> It is right.  Extract is written as ofs/len in assembly, but encoded as lsb/msb
> in the opcode -- just like bitfield move.
>
> Boot an armv7 guest and there should be enough uses to convince you.

Yeah I got confused by the description and missed that UBFX is an alias
in those cases.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
