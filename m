Received: from eggs.gnu.org ([2001:4830:134:3::10]:57332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX2vD-0006M2-4v
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX2vC-000336-Do
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:06:35 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX2vC-00032Y-3v
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:06:34 -0400
Received: by mail-wm0-x233.google.com with SMTP id t70so10452800wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:06:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717093944.GA18516@lemon>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
	<CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
	<20170717093944.GA18516@lemon>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 11:06:12 +0100
Message-ID: <CAFEAcA-hzAq=fP6Pndre3b4truxJFV3go0C91d702pMsLGZRrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 10:39, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 07/17 10:28, Peter Maydell wrote:
>> Ideally we'd streamline our make process to not produce so much
>> irrelevant output :-)
>
> Does that mean to make "quite-command" absolutely quiet if V=1 is not specified?

The current 'quiet' mode is not quite aimed at the same purpose:
it's good for interactive use where you don't want the long detail
of command lines but you do want some periodic indication of
progress through the compile. For entirely noninteractive
setups like travis and patchew there's no need to produce
what is in effect a rather verbose progress bar...

thanks
-- PMM
