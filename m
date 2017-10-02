Received: from eggs.gnu.org ([2001:4830:134:3::10]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dz5VD-0005iZ-VV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dz5VD-000120-5r
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:31:40 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:51379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dz5VD-00011Z-1j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:31:39 -0400
Received: by mail-qt0-x231.google.com with SMTP id q4so8565728qtq.8
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 11:31:38 -0700 (PDT)
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-5-richard.henderson@linaro.org>
	<87zi99zk7v.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3565e7e6-5484-ca91-9803-c1d9057a72e9@linaro.org>
Date: Mon, 2 Oct 2017 14:31:35 -0400
MIME-Version: 1.0
In-Reply-To: <87zi99zk7v.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] disas: Support the Capstone
 disassembler library
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 10:40 AM, Alex Bennée wrote:
>> +    if (cap_insn == NULL) {
>> +        cap_insn = cs_malloc(*handle);
>> +        if (cap_insn == NULL) {
> 
> if (!cap_insn)?

Eh.  Depends on your philosophy, I suppose.  I'm not especially keen on !
except on boolean expressions.  Though of course both expressions are identical.

>> +        /* If the target memory is not consumed, go back for more... */
>> +        if (size != 0) {
>> +            /* ... taking care to move any remaining fractional insn
>> +               to the beginning of the buffer.  */
>> +            if (csize != 0) {
> 
> Given we are moving stuff and both size/csize are of size_t wouldn't if
> (size > 0) be clearer here?

*shrug* I dunno, would it?  For me, not obviously so.  Of course the two
expressions compile to the same code.


r~
