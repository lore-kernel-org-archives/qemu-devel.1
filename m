Received: from eggs.gnu.org ([2001:4830:134:3::10]:38561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPq1-00049r-KE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPq0-0006Fi-RH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:50:45 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTPq0-0006FL-Ly
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:50:44 -0400
Received: by mail-ot0-x241.google.com with SMTP id p95-v6so6537179ota.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 03:50:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180614081420.GG6355@redhat.com>
References: <20180612062430.GA15344@xz-mi>
	<CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
	<20180613040259.GI15344@xz-mi> <20180613092809.GF27901@redhat.com>
	<20180614025521.GR15344@xz-mi> <20180614081420.GG6355@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 11:50:23 +0100
Message-ID: <CAFEAcA-d8mVd2d7mAAVH6aWGHwyi=9yzKiwm2pX9unJ5OaACxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On 14 June 2018 at 09:14, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Thu, Jun 14, 2018 at 10:55:21AM +0800, Peter Xu wrote:
>> Then is there an easy way to port the specfile and tools to QEMU
>> repository so that we can pack that even with a git tree?

> Well if we want to have a RPM spec file for QEMU distributed with upstrea=
m
> QEMU, then I think it would be better todo what libvirt does[2], and simp=
ly
> have the real Fedora  specfile kept in QEMU git [3].

I would prefer not to. I think packaging is a job for downstream
distributors, and having our own (probably under-maintained)
version of the packaging infrastructure in upstream git just
makes things awkward for downstream, and requires us to make
choices about which distros we think "important" enough to
provide packaging for...

thanks
-- PMM
