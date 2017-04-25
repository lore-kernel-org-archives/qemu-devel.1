Received: from eggs.gnu.org ([2001:4830:134:3::10]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d30Zo-0002Vn-2a
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d30Zi-0007N4-4z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:32:20 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d30Zh-0007MZ-Ta
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:32:14 -0400
Received: by mail-wm0-x235.google.com with SMTP id r190so96541035wme.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:32:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493103101-25165-3-git-send-email-clg@kaod.org>
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 14:31:51 +0100
Message-ID: <CAFEAcA9Y0C_byA8KsiMXdzsMDE73ZKmMcQZaMc7uwAF2bZC+hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 25 April 2017 at 07:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Currenlty, the code relies on the fact that open() handles NULL
> filenames but that can cause an error with new clang:
>
>   hw/core/loader.c:67:15: runtime error: null pointer passed as argument =
1,
>   which is declared to never be null

This isn't "new clang", incidentally, it's just clang with the
runtime-static-analysis enabled, which causes warnings to be
printed at runtime for undefined behaviours. You can enable
this by passing configure --extra-cflags=3D-fsanitize=3Dundefined .
(I have clang 3.8.0 here.)

thanks
-- PMM
