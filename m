Received: from eggs.gnu.org ([2001:4830:134:3::10]:52445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciOYG-0007PS-LU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciOYF-0007jy-S0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:53:32 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciOYF-0007jg-LL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:53:31 -0500
Received: by mail-wr0-x236.google.com with SMTP id u108so26502365wrb.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 08:53:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <479997200.107486.1488213725522@communicator.strato.de>
References: <492427237.68231.1488183356160@communicator.strato.de>
	<CAFEAcA-hHnOvoWZYZgBt2sWjv60fyTFv4mmGkaBbnVDwEqg31w@mail.gmail.com>
	<1634823730.89363.1488206109043@communicator.strato.de>
	<CAFEAcA_O2ue4wkGgcJCAXwPSZy=OajBz0nREet5Kr+h0t4o8Dw@mail.gmail.com>
	<479997200.107486.1488213725522@communicator.strato.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 16:53:09 +0000
Message-ID: <CAFEAcA9rBELg1DwyGzGUjMGECdhsa=2HrMtwhny6=bbnq-vnpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] pl190: Fix off-by-one error in priority
 handling when reading VECTADDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Bommert <marc@brightwise.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 16:42, Marc Bommert <marc@brightwise.de> wrote:
> Hello Peter, you are completely right. The bug isn't in master
> and my patch is to be rejected. There was once a version of pl190.c
> (like uhhm, around 2011) which didn't have the [i+1] in the array
> index and somehow (please don't ask) it made it into my qemu build.

Ah, yes -- commit 14c126baf1c was that bugfix.

> Thank you for pointing this out.

No problem -- glad we've figured out what's going on.
(You should probably check you don't have any other ancient
wrong copies of source files lying around :-))

thanks
-- PMM
