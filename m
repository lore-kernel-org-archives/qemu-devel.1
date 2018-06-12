Received: from eggs.gnu.org ([2001:4830:134:3::10]:55463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSf36-0008Ia-BH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSf35-0005fH-G2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:53:08 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSf35-0005el-A8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:53:07 -0400
Received: by mail-oi0-x241.google.com with SMTP id t133-v6so20374632oif.10
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 01:53:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612062430.GA15344@xz-mi>
References: <20180612062430.GA15344@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 09:52:45 +0100
Message-ID: <CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On 12 June 2018 at 07:24, Peter Xu <peterx@redhat.com> wrote:
> For example, I wanted to compile QEMU once and install it on multiple
> systems.  What would be the suggested way to do so?

For this, I would recommend using whatever the packaging
format for those systems is. Eg for Debian use the existing
Debian QEMU packages, for Redhat systems use RPMs, etc.
If you want a newer version of QEMU than is in the distro's
packages, you can probably forward port the packaging parts
to a newer QEMU without too much pain.

Or you can use a distro-agnostic packaging tool of some sort;
there are a few out there but I have no particular recommendations.

thanks
-- PMM
