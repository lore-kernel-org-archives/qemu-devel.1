Received: from eggs.gnu.org ([2001:4830:134:3::10]:44595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g75DO-0006RP-NL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 16:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g74zj-0003P6-8g
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 16:40:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:38849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g74zi-0003OC-SN
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 16:40:43 -0400
Received: by mail-ot1-x32a.google.com with SMTP id h15-v6so14562515otj.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 13:40:42 -0700 (PDT)
References: <20180919175423.GA25553@flamenco> <87va71uijc.fsf@linaro.org>
	<20181001183423.GA27555@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d2fbab5-13c8-1c19-5e58-02968cdcfef0@linaro.org>
Date: Mon, 1 Oct 2018 15:40:37 -0500
MIME-Version: 1.0
In-Reply-To: <20181001183423.GA27555@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] ideas for improving TLB performance (help with TCG
 backend wanted)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>

On 10/1/18 1:34 PM, Emilio G. Cota wrote:
> On Thu, Sep 20, 2018 at 01:19:51 +0100, Alex Bennée wrote:
>> If we are going to have an indirection then we can also drop the
>> requirement to scale the TLB according to the number of MMU indexes we
>> have to support. It's fairly wasteful when a bunch of them are almost
>> never used unless you are running stuff that uses them.
> 
> So with dynamic TLB sizing, what you're suggesting here is to resize
> each MMU array independently (depending on their use rate) instead
> of using a single "TLB size" for all MMU indexes. Am I understanding
> your point correctly?

You cannot do that without flushing the TBs (and with out-of-line memory ops,
the prologue as well) and regenerating.  The TLB size is baked into the code.
And we really don't have any extra registers free to vary that.


r~
