Received: from eggs.gnu.org ([2001:4830:134:3::10]:38651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnjwb-0005ld-T8
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnjwZ-0002Nx-6a
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:44:45 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnjwY-0002NV-Ux
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:44:43 -0400
Received: by mail-lf0-x242.google.com with SMTP id y193so13779777lfd.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:44:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA-Qb2fp1kvksE4gBc+-1s29swwqTApFTcaMXnTO7aWDcg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db6cb6b2-d618-b158-9ac8-955375093b9b@redhat.com>
Date: Tue, 14 Mar 2017 11:44:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Qb2fp1kvksE4gBc+-1s29swwqTApFTcaMXnTO7aWDcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>



On 14/03/2017 11:39, Peter Maydell wrote:
>> 3. Is it safer than C even when writing code to operate on guest RAM
>>    (i.e. it's no good if you must use unsafe primitives to do the
>>    systems programming tasks that QEMU requires)?
> My impression is that many of our security vulnerabilities are
> overflows in local arrays in the device emulation (for instance
> good old VENOM), so I think that even if a candidate safer
> language only provided bounds-checking on arrays it knew about
> and not on raw guest RAM it would still be a significant
> improvement. (Accesses to guest RAM are often via APIs that
> we could add bounds-checks to "by hand" anyway.) 

Right, this was one of the reasons behind the introduction of
MemoryRegionCache: get both speed (like address_space_map) and bounds
checking (like address_space_rw).

It looks like it should be easy to wrap it in any language, be it Rust
or a scripting language like Lua.

Paolo
