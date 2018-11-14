Received: from eggs.gnu.org ([2001:4830:134:3::10]:38351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMwD1-0006yI-G3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMwD0-0000A3-O7
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:31:59 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMwD0-00008z-6y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:31:58 -0500
Received: by mail-oi1-x241.google.com with SMTP id g188-v6so13714739oif.8
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 06:31:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1a2e6935-d76b-ca8f-1e9f-63454dc1b7dc@redhat.com>
References: <20181113184641.4492-1-peter.maydell@linaro.org>
	<20181113184641.4492-3-peter.maydell@linaro.org>
	<163db126-4441-3e4a-2dd0-1334c6ef4fb9@redhat.com>
	<1a2e6935-d76b-ca8f-1e9f-63454dc1b7dc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Nov 2018 14:31:36 +0000
Message-ID: <CAFEAcA-84iyXqez8CG99ieLdQsahUhEvwGTQv=8uvumRxP2iiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] scripts/coverity-scan: Add Docker
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 14 November 2018 at 12:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> ENV COVERITY_TOOL_BASE=/coverity-tools
>> COPY run-coverity-scan run-coverity-scan
>> RUN --mount=type=secret,id=coverity.token,required ./run-coverity-scan
>> --update-tools-only --tokenfile /run/secrets/coverity.token
>
> If the tokenfile is not needed when updating the tools, you could also
> move the Dockerfile to tests/docker/dockerfiles/fedora-coverity.docker
> and just do "make docker-image-fedora-coverity"

It is needed when updating the tools, which is why I had
to mess around with the secrets to pass it in. (Specifically,
you have to pass the token to the Coverity web site to be
able to download the tools zipfile.)

thanks
-- PMM
