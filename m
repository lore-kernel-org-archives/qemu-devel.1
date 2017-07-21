Received: from eggs.gnu.org ([2001:4830:134:3::10]:58702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYV6I-0007MD-BL
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYV6H-0000xz-Gv
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:24:02 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYV6H-0000vw-BG
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:24:01 -0400
Received: by mail-wm0-x232.google.com with SMTP id e131so10103824wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 03:24:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 11:23:39 +0100
Message-ID: <CAFEAcA8zVjRNtvu7HiBy_8u+7NTXjWh3aT6Fx=+D4OSNSe9KPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 20 July 2017 at 17:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> On NetBSD, where tolower() and toupper() are implemented using an
> array lookup, the compiler warns if you pass a plain 'char'
> to these functions:
>
> gdbstub.c:914:13: warning: array subscript has type 'char'
>
> This reflects the fact that toupper() and tolower() give
> undefined behaviour if they are passed a value that isn't
> a valid 'unsigned char' or EOF.
>
> We have qemu_tolower() and qemu_toupper() to avoid this problem;
> use them.
>
> (The use in scsi-generic.c does not trigger the warning because
> it passes a uint8_t; we switch it anyway, for consistency.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied to master; thanks all for fast reviews/acks.

-- PMM
