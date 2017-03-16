Received: from eggs.gnu.org ([2001:4830:134:3::10]:37676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coZar-000802-3y
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coZaq-00040b-0p
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:53:45 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coZap-00040N-QM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:53:43 -0400
Received: by mail-wr0-x233.google.com with SMTP id g10so37296218wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 10:53:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
References: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 17:53:21 +0000
Message-ID: <CAFEAcA-iY7-CHwG4Zo6rRBJCEqjG8wvPXWjXW0nZvf4ym=-0SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/7] cirrus: more blitter security
 fixes.
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

On 16 March 2017 at 09:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Another pile of cirrus blitter fixes, including cve fixes for known
> issues, so clearly 2.9 material.
>
> Patches 6+7 implement a new approach to blitter memory access sanity
> checking.  We pass around offsets not pointers, and at the place where
> the actual memory access happens we mask the offset to the valid
> range before calculating the pointer.
>
> That should put an end to security holes due to blit_is_unsafe() sanity
> checks failing to calculate some special case correctly, or due to
> blit_is_unsafe() calls missing, and kill any dragons which might still
> be lurking in the code.  In theory this even obsoletes blit_is_unsafe(),
> but I don't feel like ripping it out right away ...
>
> please pull,
>   Gerd
>
> The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-cirrus-20170316-1
>
> for you to fetch changes up to ffaf857778286ca54e3804432a2369a279e73aa7:
>
>   cirrus: stop passing around src pointers in the blitter (2017-03-16 08:58:16 +0100)
>
> ----------------------------------------------------------------
> cirrus: blitter fixes.
>

Applied, thanks.

-- PMM
