Received: from eggs.gnu.org ([2001:4830:134:3::10]:35035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffVgX-0000b6-Ua
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffVgX-0000it-4X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:30:57 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffVgW-0000g9-UM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:30:57 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so4212097oib.6
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:30:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k1ptydqg.fsf@secure.mitica>
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-2-quintela@redhat.com>
	<20180717124646.GP18603@redhat.com> <87wottyeqk.fsf@secure.mitica>
	<CAFEAcA8S1rG4X37Qmgk5YawCh32p=yw7o=22uQuZQWJMBBke7Q@mail.gmail.com>
	<87k1ptydqg.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 20:30:35 +0100
Message-ID: <CAFEAcA-w0Mcm9tLHqmXRDcrMDnE5JO4NoHPtv_RsvZ56i5A48g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/25] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 17 July 2018 at 18:27, Juan Quintela <quintela@redhat.com> wrote:
> On the other hand, sometimes it looks like I am the only user that use
> this.  The original reason for this was to be able to compile out
> drivers that downstream don't care about.  There were a couple of
> intents to integrate with something like kernel kconfig, but I think
> that we never end integrating anything from there.

I think "be able to compile out stuff you don't want" is
useful from a "reduce the security boundary" perspective,
and indeed we have at least one fork of QEMU which is
basically aimed at chopping stuff out, so there's a group
of users who'd like to be able to do that -- you're not on
your own in that sense. But it probably does require more
serious effort if we want to address this use case, so as
always it comes down to whether anybody wants to do the work,
I guess.

thanks
-- PMM
