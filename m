Received: from eggs.gnu.org ([2001:4830:134:3::10]:53622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eYyNn-00040n-PA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eYyNm-0000V2-V3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:12:19 -0500
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eYyNm-0000Un-Qk
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:12:18 -0500
Received: by mail-yb0-x244.google.com with SMTP id s10so6332034ybl.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 10:12:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92ceiqpHgnVQrxx2M452FxdA4v2kaTT-cQyf5x3Rsr0A@mail.gmail.com>
References: <1515433749-5839-1-git-send-email-jcmvbkbc@gmail.com>
	<CAFEAcA92ceiqpHgnVQrxx2M452FxdA4v2kaTT-cQyf5x3Rsr0A@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 9 Jan 2018 10:12:17 -0800
Message-ID: <CAMo8BfJsLchdZu6X=D=RsYXHDbHxsf-EWJ=mZF8_8eYh6WcEVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/16] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 9, 2018 at 9:44 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> /Users/pm215/src/qemu-for-merges/target/xtensa/helper.c:63:26: error:
> implicit declaration of function 'g_malloc_n' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>     config->opcode_ops = g_malloc_n(opcodes, sizeof(XtensaOpcodeOps *));
>                          ^
>
> g_malloc_n() only came in in glib 2.24, so this doesn't build on
> glib 2.22 (our minimum required version).

Sorry about that, fixed.

-- 
Thanks.
-- Max
