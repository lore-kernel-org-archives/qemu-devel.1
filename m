Received: from eggs.gnu.org ([2001:4830:134:3::10]:50430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fo3DB-0006I2-D6
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fo3D7-0000dB-EF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:55:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fo3D6-0000cL-Ue
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:55:53 -0400
Received: by mail-wm0-x243.google.com with SMTP id n11-v6so1082947wmc.2
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 01:55:52 -0700 (PDT)
References: <20180808123934.17450-1-alex.bennee@linaro.org>
	<20180808123934.17450-2-alex.bennee@linaro.org>
	<20180810033200.GA8773@localhost.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180810033200.GA8773@localhost.localdomain>
Date: Fri, 10 Aug 2018 09:55:50 +0100
Message-ID: <878t5eppm1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] scripts/decodetree.py: add a
 disassembly generator (HACK!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, Cleber Rosa <crosa@redhat.com>


Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Aug 08, 2018 at 01:39:31PM +0100, Alex Benn=C3=A9e wrote:
>> Given our issues with failing disassembly we could try and re-use the
>> decode tree data to output what instruction is being decoded. This
>> will be used if registered as a fall-back for when the "proper"
>> disassembler fails to decode an instruction.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I don't have an opinion on the approach you are taking, but the
> Python code you are adding is consistent with the existing style
> of the script.
>
> That said, I find the existing code full of output() calls very
> hard to read.  If anybody wants to volunteer to improve the
> readability of the output generation, it would be welcome.

If we expect to have the script output a number of different forms I
guess re-factoring it with some sort of template based approach would be
worthwhile. I wonder if there are other examples in the code base? We
wouldn't want to have multiple template types.

>
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>


--
Alex Benn=C3=A9e
