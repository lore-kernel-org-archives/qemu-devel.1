Received: from eggs.gnu.org ([2001:4830:134:3::10]:44173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0PlR-0003Yx-1G
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0PlQ-0004Q8-EV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:49:37 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0PlQ-0004Q2-7x
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:49:36 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w64so51761263wma.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 02:49:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E8F93B5C-51EA-46F6-849E-3C0A2C2E33E1@gmail.com>
References: <E8F93B5C-51EA-46F6-849E-3C0A2C2E33E1@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Apr 2017 10:49:14 +0100
Message-ID: <CAFEAcA-GptJjzNCEWXcsiVMtC8PcT=taMrJP=QU0f_m6XOkW1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] define constant in .risu file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 18 April 2017 at 05:20, G 3 <programmingkidx@gmail.com> wrote:
> Is there a way to define a constant in a .risu file? Something like this:
>
> my $upper_imm_limit = 500;

No - the risu file is just a bunch of patterns, with a
few fragments of executable code mixed in.

Currently constants defined in the perl source will
be visible to the perl fragments in the risu file,
but that's pretty ugly and one day I'll make it
a requirement that the perl explicitly exports the
functions/constants the risu fragments should see.

thanks
-- PMM
