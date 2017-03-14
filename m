Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnjsL-00051h-Jq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnjsK-0000Qr-LN
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:40:21 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnjsK-0000QN-ES
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:40:20 -0400
Received: by mail-wm0-x232.google.com with SMTP id t189so60278533wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:40:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314081312.GB13140@stefanha-x1.localdomain>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:39:58 +0100
Message-ID: <CAFEAcA-Qb2fp1kvksE4gBc+-1s29swwqTApFTcaMXnTO7aWDcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> The minimum requirements for the new language:

> 3. Is it safer than C even when writing code to operate on guest RAM
>    (i.e. it's no good if you must use unsafe primitives to do the
>    systems programming tasks that QEMU requires)?

My impression is that many of our security vulnerabilities are
overflows in local arrays in the device emulation (for instance
good old VENOM), so I think that even if a candidate safer
language only provided bounds-checking on arrays it knew about
and not on raw guest RAM it would still be a significant
improvement. (Accesses to guest RAM are often via APIs that
we could add bounds-checks to "by hand" anyway.) So I wouldn't
consider this as a "minimum requirement", only a "nice to have".

thanks
-- PMM
