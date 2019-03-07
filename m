Received: from eggs.gnu.org ([209.51.188.92]:34225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1h20wa-0003Kr-UU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1h20wX-0000U3-RU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:52:47 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lwhsu.freebsd@gmail.com>)
	id 1h20wX-0000Rd-GT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:52:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id x20so361528ywd.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 13:52:42 -0800 (PST)
MIME-Version: 1.0
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
	<CAPyFy2AnxWBXjUOWRy7_YpoSFadQBAXRooM+t4g6t6XOaF1XgA@mail.gmail.com>
	<84cc4186-86a8-2152-11ab-bd4001b05ee7@redhat.com>
In-Reply-To: <84cc4186-86a8-2152-11ab-bd4001b05ee7@redhat.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Fri, 8 Mar 2019 05:52:26 +0800
Message-ID: <CAKBkRUyXQ=MucPiKWT7Q2Qt0jFiO_bszYxfsOjxHBNAFP_Hbsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, Mar 8, 2019 at 4:30 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/03/2019 21.26, Ed Maste wrote:
> > On Mon, 4 Mar 2019 at 07:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
> >>
> >> On 3/4/19 11:32 AM, Thomas Huth wrote:
> >>> cirrus-ci.com also has the possibility to run CI tasks on macOS.
> >>> Since most of the QEMU developers do not have access to macOS yet,
> >>> let's add a CI pipeline for this operating system here, too.
> >>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Ed Maste <emaste@freebsd.org>
>
> Thanks! I can take this patch through my qtest tree.

Hi Thomas,

Sorry for the late reply, I checked and tested the patch, it works
fine.  BTW, may I suggest:

>From https://cirrus-ci.org/guide/macOS/ , the image high-sierra-base
is lasted as "Not maintained", how about change to mojave-base?

Also, perhaps we can put the common:

env:
  CIRRUS_CLONE_DEPTH: 1

in the global area?

Thanks,
Li-wen
