Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO4kZ-0003Ya-Dx
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO4kY-0007wN-Lw
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:14:31 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO4kY-0007w4-F7
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:14:30 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so29904532wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 09:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149814756006.27338.8723356702388175951.stgit@bahia>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 17:14:08 +0100
Message-ID: <CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Separate function types from opaque types
 in include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote:
> Function types cannot reside in the same sorted list as opaque types since
> they may depend on a type which would be defined later.
>
> Of course, the same problem could arise if a function type depends on
> another function type with greater alphabetical order. Hopefully we
> don't have that at this time.

The other approach would be to put function types somewhere
else and leave typedefs.h for the simple 'opaque types
for structures' that it was started as.

For instance we have include/qemu/fprintf-fn.h as a precedent.

thanks
-- PMM
