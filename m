Received: from eggs.gnu.org ([2001:4830:134:3::10]:58348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eDIU1-0006z3-Ng
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eDITy-0005UF-JT
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:13:09 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eDITy-0005Td-Co
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:13:06 -0500
Received: by mail-wm0-f47.google.com with SMTP id b14so5463491wme.2
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 15:13:06 -0800 (PST)
References: <20171110202556.28541-1-michael.nawrocki@gtri.gatech.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <888aa8cc-25d3-bcc5-9a97-78d59b972c05@redhat.com>
Date: Sat, 11 Nov 2017 00:12:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171110202556.28541-1-michael.nawrocki@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/1] Add 8-byte wide AMD
 flash support, partial interleaving
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mreitz@redhat.com

On 10/11/2017 21:25, Mike Nawrocki wrote:
> This patch set does a few things. First, it switches the AMD CFI flash MMIO
> operations from the old MMIO API to the new one. Second, it enables 8-byte wide
> flash arrays. Finally, it adds flash interleaving using the "device-width" and
> "max-device-width" properties, using the same interface as pflash_cfi01.c. Much
> of the code was taken and adapted from that file.

This unfortunately is not a patch set, it's a patch that does many
things.  You should split it in three parts, according to the three
things you've mentioned in the message above.

Paolo
