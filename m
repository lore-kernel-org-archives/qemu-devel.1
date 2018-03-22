Received: from eggs.gnu.org ([2001:4830:134:3::10]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4Co-0007x9-7y
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4Cn-0003dV-8a
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:40:50 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:41201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez4Cn-0003ck-33
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:40:49 -0400
Received: by mail-oi0-x22b.google.com with SMTP id 6-v6so4610078oip.8
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 10:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4886c0dc-e017-8e39-649c-058b5f7b65f3@redhat.com>
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-5-lvivier@redhat.com>
	<CAMo8BfKkwM0wzX1yCBvwJ-Av4SZbgSrxmOGzD+Z_+bY0DTcgYg@mail.gmail.com>
	<6fd26097-aa7e-38cf-0d9e-09d0d36bd88b@redhat.com>
	<CAMo8Bf+K_XCsZ2tLVT15v5v0ssEbGSmYj+HuT-x5UMYZTKBZ4Q@mail.gmail.com>
	<4886c0dc-e017-8e39-649c-058b5f7b65f3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 17:40:27 +0000
Message-ID: <CAFEAcA85YZB3_k2o0QQtbboaYr=t5k5=ePUwuc0qtcq3ioDwvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] Remove unnecessary variables for
 function return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <lvivier@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 22 March 2018 at 17:30, Eric Blake <eblake@redhat.com> wrote:
> I'm less certain of whether our Coccinelle scripts have easy ways to exclude
> specific files.  We already have scripts/cocci-macro-file.h to help
> Coccinelle not choke on some our existing files, but I'm not sure if
> Coccinelle has a config-file like way that is easy to maintain as a data
> file in-tree for blacklist files to leave alone (right now, when I run
> Coccinelle, I have to manually remember to pass a long command line cribbed
> out of the commit message of an earlier run to pick up things like
> cocci-macro-file.h, instead of an easy formula that points to a single
> config file to pull in all the usual options).

Coccinelle itself doesn't seem to have a config file mechanism.
We could probably approximate one by using a wrapper script
that skips some files and run the passed spatch file on the rest;
scripts/clean-includes has some "skip files we don't want to try
to run on" code that could perhaps be generalized.

thanks
-- PMM
