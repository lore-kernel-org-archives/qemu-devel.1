Received: from eggs.gnu.org ([2001:4830:134:3::10]:41331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLCq-0002KU-QV
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLCm-0007Ia-I7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:14:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daLCm-0007I8-Bm
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:14:20 -0400
References: <20170726114437.19624-1-pbonzini@redhat.com>
	<CAFEAcA9_fcrXw-H2wgVMTKP3G_A11wMYP3YH+fZ9ub7gXQF2rg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <391d683f-aa1f-5346-9bb8-4a79651fcbfc@redhat.com>
Date: Wed, 26 Jul 2017 14:14:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_fcrXw-H2wgVMTKP3G_A11wMYP3YH+fZ9ub7gXQF2rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On 26/07/2017 13:52, Peter Maydell wrote:
>>  * Reproduce the problem directly with a QEMU command-line.  Avoid frontends and management stacks, to ensure that the bug is in QEMU itself and not in a frontend.
>>
>> -* Include as information about the guest (operating system, version, 32/64-bit).
>> +* Include as information about the host and guest (operating system, version, 32/64-bit).
> I'm not sure what the "as" here is for: should this say just
> "Include information" or "Include as much information as possible"
> or something else?

Interesting pre-existing error.  Both of them, but I think "Include
information" is lighter and flows better.

Paolo
