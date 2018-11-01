Received: from eggs.gnu.org ([2001:4830:134:3::10]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIE7H-000589-Dy
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIDzU-0001Lb-12
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:30:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIDzS-0001HK-Rc
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:30:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id o14so17915011oth.4
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 07:30:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bcf1457b-8f0c-3d02-cb40-529eddb19316@redhat.com>
References: <20181030001841.1658-1-philmd@redhat.com>
	<bcf1457b-8f0c-3d02-cb40-529eddb19316@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 14:30:08 +0000
Message-ID: <CAFEAcA_p9oTtur8T1Zz5J4hzV2Ly7Jd2Y0xHODCZu2vm-QXx4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/bios-tables-test: Sanitize test
 verbose output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1 November 2018 at 14:26, Eric Blake <eblake@redhat.com> wrote:
> Umm, this prints a blank line even if I run 'make check V=0' - do we support
> V=0 as a way to disable verbosity

Empirically, we do not. Our rules.make defines
quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))

which will suppress the verbose printing of command lines
only if $(V) expands to the empty string, so V=0 will
print verbosely here too.

thanks
-- PMM
