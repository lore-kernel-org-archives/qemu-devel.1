Received: from eggs.gnu.org ([2001:4830:134:3::10]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ4g7-00064N-UG
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ4g4-0005Fj-SN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZ4g4-0005FF-Mx
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:51:04 -0500
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<58763C1D-20EB-4C1F-86EC-C9903F87BDB3@gmail.com>
	<97ae663a-f2d1-c45d-bb8d-8be352d8f84c@redhat.com>
	<87B90AC4-A4F9-4A6B-83F9-4E351BC71F80@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d27660e-84a3-d200-aa50-5bce1ab56046@redhat.com>
Date: Wed, 1 Feb 2017 15:50:58 -0800
MIME-Version: 1.0
In-Reply-To: <87B90AC4-A4F9-4A6B-83F9-4E351BC71F80@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>



On 01/02/2017 15:36, G 3 wrote:
> On Feb 1, 2017, at 6:17 PM, Paolo Bonzini wrote:
>> The requirements for the format are:
>>
>> * support for HTML and man as output formats, optionally PDF and text
>> * support for QEMU's usual submission workflow
>> * producing documentation with a consistent look
>> * tool support and extensibility
>> * being easy to use and not too obscure
>>
>> in this order.  Based on this, the only formats we could plausibly use
>> are Texinfo (if only because that's what we use now), Markdown,
>> restructuredText, Docbook and Asciidoc.  The poll mentioned all of these
>> except Asciidoc, plus LaTeX as a "control group".
> 
> Ok. I understand.
> 
> For the above requirements of "tool support and extensibility", what do
> you mean by this? Do you mean command-line tool support? What do you
> mean by extensibility?

Basically, easily integrating QEMU-specific code in the build.  This
way, we don't need 20 different steps in the Makefile; instead a single
tool invocation will do everything from parsing the input, to extracting
documentation comments from C source, to finally generating the output.

Of course you need to find the right balance between redoing the same
work over and over (a solution purely based on Make can do that best)
and ease of use.

Paolo
