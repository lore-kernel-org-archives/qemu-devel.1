Received: from eggs.gnu.org ([2001:4830:134:3::10]:36253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhXgq-0005Ue-Bb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhXgm-0001Lz-BS
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:03:40 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhXgm-0001L7-3H
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:03:36 -0400
Received: by mail-wm0-x244.google.com with SMTP id o18-v6so577242wmc.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 03:03:35 -0700 (PDT)
References: <20180717195553.9111-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180717195553.9111-1-alex.bennee@linaro.org>
Date: Mon, 23 Jul 2018 11:03:33 +0100
Message-ID: <87o9eytgju.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for 3.0 00/18] docker fixes (and one tcg
 test tweak)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> I've missed the boat for today's rc1 but I'd like to get this merged
> before rc2. The new docker.py change is technically new functionality
> but I'm counting it as a usability bug fix as it replaces a random
> back trace failure with a preemptive failure and message mentioning
> binfmt_misc configuration. This would have saved Richard a lot of head
> scratching as he tried to setup a powerpc-user setup to test his
> setcontext fix (he had a custom binfmt_misc pointing to his src tree).
>
> Finally we also drop the runcom test. It was cute that it got
> resurrected but it is ultimately a pointless test for something I'm
> sure no one actually uses.
>
> There will be a follow-up RFC series after this that cleans-up some of
> the rough edges when your host is not an x86_64 box but that series
> won't be targeting the 3.0 release.
>
> : The following patches need review
> : patch docker/disable debian powerpc user cross.patch
> : patch docker/drop QEMU_TARGET check fallback in EXECUTABLE.patch
> : patch docker/Update debootstrap script after Debian migrat.patch
> : patch docker/ignore distro versioning of debootstrap.patch
> : patch docker/perform basic binfmt_misc validation in docke.patch
> : patch tests/tcg remove runcom test.patch

Ping?

--
Alex Benn=C3=A9e
