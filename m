Received: from eggs.gnu.org ([2001:4830:134:3::10]:54928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSWMV-0007GE-96
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSWMR-0002No-C4
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:32:03 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSWMR-0002NU-6X
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:31:59 -0400
Received: by mail-pg0-x241.google.com with SMTP id j186so28790021pge.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 15:31:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
	<528c921e-d04c-f064-08f8-2c6a0b3f23f1@twiddle.net>
	<8760f8av0c.fsf@frigg.lan>
	<CAFEAcA8VPgejz7oUKMR7965BjyU3t+DA8Vq7GatUUhTC0j9XRg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ee87713c-82f1-5a3f-2c42-41833e2ea932@twiddle.net>
Date: Tue, 4 Jul 2017 12:31:51 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8VPgejz7oUKMR7965BjyU3t+DA8Vq7GatUUhTC0j9XRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/04/2017 09:14 AM, Peter Maydell wrote:
> On 4 July 2017 at 19:59, Lluís Vilanova <vilanova@ac.upc.edu> wrote:
>> Richard Henderson writes:
>>> Any reason not to stuff the cpu pointer into the DisasContextBase instead of
>>> passing it around separately?
>>
>> None, really. I'll move it from DisasContext (in targets where it's present)
>> into DisasContextBase, and use that one everywhere.
> 
> I kind of like not having CPUState* in DisasContext, because
> it enforces the rule that you can't read from fields of
> it inside the target translate.c code without jumping through
> a hoop (ie copying the info from CPUState->foo to
> DisasContext->foo). That then acts as a useful flag in code
> review (or when writing the code) to confirm that foo really
> is constant for the life of the simulation (or to recommend
> using a TB flag instead).

I don't see how the spelling "cpu" vs "dc->cpu" really affects that.

More practically, I don't see that "cpu" will actually be used by most of those 
hooks.  But because of things like cpu->some_target_feature, it's kind of hard 
to predict.


r~
