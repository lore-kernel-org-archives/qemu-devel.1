Received: from eggs.gnu.org ([2001:4830:134:3::10]:49720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSMWG-0003iq-9B
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSMW6-0001YE-Kx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:01:28 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dSMW6-0001WY-EA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:01:18 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c11so248060500wrc.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 05:01:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170704111404.28569-1-berrange@redhat.com>
References: <20170704111404.28569-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2017 13:00:54 +0100
Message-ID: <CAFEAcA9EKaUP_7JgT553fZ2_z2kcg_UsKwdgwQKRQVQMH3fbfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>

On 4 July 2017 at 12:14, Daniel P. Berrange <berrange@redhat.com> wrote:
> This is a followup to
>
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01286.html
>
> The goal is to clarify to users & app developers what they can expect
> from QEMU in terms of feature lifecycle & any deprecation policy should
> it be neccessary to remove features.
>
> The list of features marked as deprecated was determined by looking at
> the QEMU source for the word "deprecated'. It was then compared with
> the doc Thomas put up at http://wiki.qemu.org/Features/LegacyRemoval
>
> Key differences with the wiki page that Thomas wrote up vs patch 2
> in this series
>
>  - Deprecated features are given a fixed lifespan of 2 releases,
>    rather than listing deletion at a future "major" v3.0.0 release.
>    This ensures that applications like libvirt have a predictable
>    fixed amount of time to react to deprecations.

That's 8 months. Is that enough time for QEMU versions to get into
distros and out to users? (I don't necessarily think it's too short,
but it seems worth thinking about.)

thanks
-- PMM
