Received: from eggs.gnu.org ([209.51.188.92]:58312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Nm-00048T-IX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Nk-0002Xv-KI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:39:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Nk-0002XB-4b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:39:12 -0500
Received: by mail-ot1-x343.google.com with SMTP id g16so5410995otg.11
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
	<f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
	<4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
	<20190124165253.GT7953@redhat.com>
	<509cf069-5d03-8e2e-fb3c-5828d32f38e1@comstyle.com>
	<6e71d755-8dcd-5275-d635-f238271cf459@tuxfamily.org>
	<1284f2c4-57ad-061a-c920-c21cd7e142d4@comstyle.com>
In-Reply-To: <1284f2c4-57ad-061a-c920-c21cd7e142d4@comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:38:59 +0000
Message-ID: <CAFEAcA9iGqC7pfwNRuGe2nOniYTp_aEzwQLRoGpt_yCGqZT2=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, 25 Jan 2019 at 18:36, Brad Smith <brad@comstyle.com> wrote:
>
> On 1/25/2019 1:24 AM, Thomas Huth wrote:
>
> > On 2019-01-25 01:48, Brad Smith wrote:
> >> Our ports tree has an option which results in the QEMU binaries being
> >> linked with "-z wxneeded".
> > Then it's maybe high time to send such changes upstream now ;-)
>
>
> I have not considered submitting such a patch as it's just a workaround
> for an
> issue within QEMU. Everything else that we had as local patches or local
> build
> fiddling to build things properly has been integrated in some manner.

We'll happily take a patch that fixes the underlying issue properly
if you'd prefer...

thanks
-- PMM
