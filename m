Received: from eggs.gnu.org ([2001:4830:134:3::10]:44788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK7CS-0001yP-Lj
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK7CR-0004Ip-5V
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:30:40 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:35189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cK7CQ-0004II-Tv
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:30:39 -0500
Received: by mail-ua0-x231.google.com with SMTP id 2so113533046uax.2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 09:30:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222155915.7232-1-pbonzini@redhat.com>
References: <20161222155915.7232-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Dec 2016 17:30:17 +0000
Message-ID: <CAFEAcA_gQ4pMcfVevAEiY6LfoW_HzR8DARHb2QpGFEA2hTAMHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 22 December 2016 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This moves out of libqemustub.a those functions which can be handled
> simply by $(call lnot), like we already do for pci-stub.c or kvm-stub.c.
> libqemustub.a keep the more complex cases where a small part of the
> executables we build needs an implementation of a small subset of an API.

So why is doing it this way round better? (I don't have a strong
opinion here, but you don't really give a rationale for this change.)

thanks
-- PMM
