Received: from eggs.gnu.org ([2001:4830:134:3::10]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxtV-0002l8-B1
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxtU-0006RR-DJ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:10:13 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxtU-0006RF-8h
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:10:12 -0500
Received: by mail-vk0-x22f.google.com with SMTP id x186so93562836vkd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:10:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 19:09:51 +0000
Message-ID: <CAFEAcA-1HfBNOxXxK=_5DZ8Ow_bdk4QpCnWnL+UBw-WsayzGMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 00/10] Record/payback patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 9 December 2016 at 11:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> I did a bunch of tweaking to see if I could abstract the hackage for
> record/replay a bit more. With a little bit of light re-factoring of
> the send and recv functions I can move all the specific send/recv
> logic into the main risu.c file and avoid having copy and pasted
> functions for each architecture.
>
> I've also introduced a header which makes tracking where you are in
> the recorded stream a little easier when debugging.
>
> It should be noted the functions:
>
>   int send_register_info(write_fn write_fn, void *uc);
>   int recv_and_compare_register_info(read_fn read_fn, respond_fn respond,=
 void *uc);
>
> are pretty identical for each arch. I did consider folding even more
> of the logic into the common code but I wasn't sure if that would
> loose flexibility in the future for other architectures so I left it
> as is.
>
> I've make the same changes to ppc64 although I've been compiling and
> testing under a qemu linux-user environment which might explain why
> I'm seeing crashes when I try and run it. I would appreciate the PPC
> guys trying it on real hardware and debugging if needed.
>
> For reference I'm using a linux-user powered docker image (built with
> the debian-bootstrap recipe in the qemu.git tree) for cross compiling:
>
>   docker run --rm -it -v /home/alex/lsrc/qemu/risu.git:/src --user=3Dalex=
:alex -w /src debian:ppc64el make
>
> There have been some minor clean-ups to the helper scripts mainly to
> aid testing by allowing the override of the RISU binary (I have
> risu-arm, risu-arm64 and risu-ppc64 in my development directory).
> Notes in the --- comments on each patch.

This generally looks good -- I've applied the two trivial typo
fixes, and commented on the other patches except for the new
scripts. I don't think there's much more work to do to get these
applied.

Could we have a patch which updates README to document the
new functionality?

I won't have a chance to look at the scripts until next year, I
expect, but from a quick glance they seem to be reasonably
separate from the actual record/replay implementation.

thanks
-- PMM
