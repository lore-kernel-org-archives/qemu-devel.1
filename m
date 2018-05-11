Received: from eggs.gnu.org ([2001:4830:134:3::10]:50252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH71x-0008BX-Po
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH71w-0000mv-Mg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:20:13 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:43738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH71w-0000mU-IS
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:20:12 -0400
Received: by mail-ot0-x22a.google.com with SMTP id y10-v6so5973959otg.10
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:20:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:19:51 +0100
Message-ID: <CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/30] Misc patches for 2018-05-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 23:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit cc8f8ba754bba17eea9791d67b572eb26e30b4ce:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-05-08 15:25:17 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3c128df2ec239f5c1abd0aa59254c433a779a347:
>
>   rename included C files to foo.inc.c, remove osdep.h (2018-05-09 00:13:41 +0200)
>
> ----------------------------------------------------------------
> * Don't silently truncate extremely long words in the command line
> * bump min required glib library version to 2.42
> * dtc configure fixes
> * MemoryRegionCache second try
> * Deprecated option removal
> * add support for Hyper-V reenlightenment MSRs
>
> ----------------------------------------------------------------

Some of my build setups barf on the new glib version requirement:

 * my aarch64 build host (a gcc compile farm machine which is running
   Ubuntu 14.04.5 LTS and has glib 2.40.2)
 * my windows cross compile setups (which have glib 2.34.3)

The latter could probably be fixed, but it will be a pain because
gtk.org don't distribute prebuilt glib &c zipfiles usable for cross
compile any more. For the former, that LTS is apparently still
in support for another year.

thanks
-- PMM
