Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxIgq-0000KZ-V8
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxIgq-00079E-0r
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:16:48 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxIgp-00077i-By
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:16:47 -0400
Received: by mail-oi0-x242.google.com with SMTP id c190-v6so9576134oig.6
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 14:16:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <907dd14c-0707-3153-bd35-da0ee5ed3bdf@redhat.com>
References: <20180904123603.10016-1-berrange@redhat.com>
	<907dd14c-0707-3153-bd35-da0ee5ed3bdf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Sep 2018 22:16:26 +0100
Message-ID: <CAFEAcA_n_Ah87Z7E5xBuSXr8-==ZD8hF4A8kUMqNDmqB_zZRjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] configure: preserve various environment
 variables in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 4 September 2018 at 17:21, Eric Blake <eblake@redhat.com> wrote:
> I still find it odd
> that we aren't precisely mirroring the (nice!) semantics that autoconf users
> have come to rely on

I think that's more the result of (a) most people don't know the
details of the autoconf semantics and (b) configure works well-enough
that nobody spends more time messing with it than they need to. I think
as an aspiration "behave like an autoconf configure script" is
probably a sensible goal.

thanks
-- PMM
