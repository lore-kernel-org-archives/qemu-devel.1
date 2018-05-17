Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKp1-0000Yo-Kb
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKp0-00032p-Qg
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:28:03 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJKp0-00032U-LS
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:28:02 -0400
Received: by mail-ot0-x233.google.com with SMTP id m11-v6so5508151otf.3
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512092824.13848-6-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
	<20180512092824.13848-6-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:27:41 +0100
Message-ID: <CAFEAcA9_zd0FyG8ndOepaWoSXd-D5kFowPft5ANnVmZo_QQHSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 5/8] checkpatch: emit a warning on file
 add/move/delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 12 May 2018 at 10:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> From: Joe Perches <joe@perches.com>
>
> Whenever files are added, moved, or deleted, the MAINTAINERS file
> patterns can be out of sync or outdated.
>
> To try to keep MAINTAINERS more up-to-date, add a one-time warning
> whenever a patch does any of those.
>

This seems to generate false positives: it just warned me about
"xlnx-zdma: Add a model of the Xilinx ZynqMP generic DMA", but
there are already entries in the MAINTAINERS file that cover
the new files.

thanks
-- PMM
