Received: from eggs.gnu.org ([2001:4830:134:3::10]:55829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEIkg-0002bE-4l
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEIkb-0006YD-9u
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:37:58 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cEIkb-0006Y4-4h
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:37:53 -0500
Received: by mail-qk0-f193.google.com with SMTP id n204so44420548qke.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:37:53 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-5-git-send-email-rth@twiddle.net>
	<87oa0pz1n4.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d7e69d4d-974b-a3f1-a8b7-86524569740e@twiddle.net>
Date: Tue, 6 Dec 2016 08:36:49 -0800
MIME-Version: 1.0
In-Reply-To: <87oa0pz1n4.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>

On 12/06/2016 04:24 AM, Alex Bennée wrote:
>> > +    case INDEX_op_extract_i64:
>> > +    case INDEX_op_extract_i32:
>> > +        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
>> > +        break;
>> > +
>> > +    case INDEX_op_sextract_i64:
>> > +    case INDEX_op_sextract_i32:
>> > +        tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
>> > +        break;
>> > +
> This isn't right is it? As I'm reading it extract takes from a
> offset+len from the source register to low bits of the destination
> register. The Bitfield Move instructions are the other way around,
> moving from the low order bits in the source register to an offset+len
> in the destination.
> 

It is right.  Extract is written as ofs/len in assembly, but encoded as lsb/msb
in the opcode -- just like bitfield move.

Boot an armv7 guest and there should be enough uses to convince you.


r~
