Received: from eggs.gnu.org ([2001:4830:134:3::10]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZeFf-0004nu-Br
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZeFb-0005u3-RT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:22:27 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dZeFb-0005tL-L3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:22:23 -0400
Received: by mail-wr0-x233.google.com with SMTP id v105so76683011wrb.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 07:22:23 -0700 (PDT)
References: <20170720134716.13049-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170720134716.13049-1-alex.bennee@linaro.org>
Date: Mon, 24 Jul 2017 15:22:20 +0100
Message-ID: <87wp6xdieb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 0/3] some docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org


Alex Bennée <alex.bennee@linaro.org> writes:

> Hi,
>
> I noticed some problems while running my local builds and while trying
> to reproduce Travis failures. They apply on top of the currently in
> flight pull-req pull-ci-updates-for-softfreeze-180717-2
>
> Alex Bennée (3):
>   docker: ensure NOUSER for travis images
>   docker: fix dirty/stash detection  on some systems
>   docker: ignore submodules when checking diff
>
>  tests/docker/Makefile.include | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Ping?

Any more reviews? Happy for me to roll a pull-req?

--
Alex Bennée
