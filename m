Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecTg9-0003HQ-3z
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecTg8-00071h-C0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:13:45 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:38093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecTg8-00070f-63
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:13:44 -0500
Received: by mail-oi0-x22e.google.com with SMTP id m65so783025oig.5
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 02:13:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118213022-mutt-send-email-mst@kernel.org>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
	<CAFEAcA-En6Pqo=bjOrDMfkNmnN5UR-7S=b45Vu6P34Ag4jdMEQ@mail.gmail.com>
	<20180118213022-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 10:13:22 +0000
Message-ID: <CAFEAcA8tkOPWEPgk2GpM7HHqd7EMtnG2=h72jj4zMQQ01LNzJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/34] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 January 2018 at 19:30, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jan 18, 2018 at 10:09:09AM +0000, Peter Maydell wrote:
>> Hi -- this pullreq triggers a lot of alignment warnings for vhost
>> in the clang runtime sanitizer:
>
> Are these build or make check errors?

They're runtime, so they fire during make check.

thanks
-- PMM
