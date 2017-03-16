Received: from eggs.gnu.org ([2001:4830:134:3::10]:43400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coROd-0008GZ-82
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coROc-0002Vw-F1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coROc-0002VU-9l
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:08:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170316070427.17120-1-stefanha@redhat.com>
	<20170316070427.17120-2-stefanha@redhat.com>
Date: Thu, 16 Mar 2017 10:08:29 +0100
In-Reply-To: <20170316070427.17120-2-stefanha@redhat.com> (Stefan Hajnoczi's
	message of "Thu, 16 Mar 2017 15:04:25 +0800")
Message-ID: <87fuidzj02.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 1/3] makefile: merge GENERATED_HEADERS &
 GENERATED_SOURCES variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Sorry for chiming in late, I had missed this change.

Stefan Hajnoczi <stefanha@redhat.com> writes:

> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> The only functional difference between the GENERATED_HEADERS
> and GENERATED_SOURCES variables is that 'Makefile' has a
> dependancy on GENERATED_HEADERS, causing generated header files
> to be created immediatey at the start of the build process.
> There is no reason why this early creation should be restricted
> to the .h files, and not include .c files too.

Actually, there is.

Any prerequisites of Makefile are made even by make -n.  Restricting
them to the ones make -n absolutely needs is good practice.

Generated headers must be prerequisites of Makefile, because automatic
dependency generation may fail without them.

There is no such reason for generated non-headers.

>                                                Merge both of
> the variables into a single GENERATED_FILES variable to make
> it clear it is for any type of generated file.

I don't hate this quite enough for an outright NAK at this late stage.
I do hate it enough to ask you to think about it once more.
