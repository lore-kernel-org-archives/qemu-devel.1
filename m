Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLU5b-0004TM-KK
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLU5a-0000pJ-L9
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:41:31 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLU5a-0000oz-DB
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:41:30 -0400
Received: by mail-wr0-x236.google.com with SMTP id 77so20320159wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 05:41:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497350473.8068.7.camel@redhat.com>
References: <20170608070716.2954-1-kraxel@redhat.com>
	<CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
	<1497350473.8068.7.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 13:41:08 +0100
Message-ID: <CAFEAcA948nCXN9Y0A9V9vRXTu8X=MGgH8NNL-WgTEQ1HnJVkvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2017 at 11:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Which systems are failing?  Any chance this is just gtk3-devel missing?
> gtk 3.0 was released more than five years ago, pretty much every distro
> should have packages meanwhile ...

I've gone through and checked, and yes, it generally was just
missing dependencies. I've fixed this on most of these systems,
but for the machine in the gcc compile farm I don't have root
access, so that will take a little time for the admins to
update.

thanks
-- PMM
