Received: from eggs.gnu.org ([2001:4830:134:3::10]:58086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAHGw-00089I-D4
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAHGv-00013S-Nq
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:23:42 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAHGv-00011F-AO
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:23:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id q50so5967367otd.0
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 09:23:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
	<118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Oct 2018 17:23:19 +0100
Message-ID: <CAFEAcA9NBu+L4wHfkLTv93wy90wjnV05EZ12PT6PmLjdZ5h_YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] scripts/qemu.py: set predefined
 machine type based on arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 10 October 2018 at 16:47, Cleber Rosa <crosa@redhat.com> wrote:
> To make sure we're on the same page, we're still going to have default
> machine types, based on the arch, for those targets that don't provide
> one (aarch64 is one example).  Right?

Does it make sense to define a default? The reason arm
doesn't specify a default machine type is because you
can't just run any old guest on any old machine type.
You need to know "this guest image will run on machine
type X", and run it on machine type X. This is like
knowing you need to run a test on x86 PC and not
on PPC spapr.

Would it make more sense for each test to specify
which machine types it can work on?

thanks
-- PMM
