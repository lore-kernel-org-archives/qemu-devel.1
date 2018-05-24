Received: from eggs.gnu.org ([2001:4830:134:3::10]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrlz-0001Z0-44
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrln-0007ER-Ik
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:03:23 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:36205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLrln-0007Dv-EM
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:03:11 -0400
Received: by mail-ot0-x22d.google.com with SMTP id m11-v6so2312180otf.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:03:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527172175-129517-1-git-send-email-mst@redhat.com>
References: <1527172175-129517-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 16:02:50 +0100
Message-ID: <CAFEAcA89eVunGQA8zFLzKa5g-d59WuvvL4MUT8sEZKkt8MyZQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Tiwei Bie <tiwei.bie@intel.com>, Markus Armbruster <armbru@redhat.com>

On 24 May 2018 at 15:30, Michael S. Tsirkin <mst@redhat.com> wrote:
> Right now tests report OK status if QEMU crashes during cleanup.
> Let's catch that case and fail the test.
>

Ha -- I've occasionally wondered why some obvious
test failures got reported as OK. Thanks for tracking
down what was going on.

-- PMM
