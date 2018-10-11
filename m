Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAeoL-0001FX-Qj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAeoL-0000TZ-2h
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:31:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAeoK-0000Sk-ML
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:31:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id v69-v6so7725793oif.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 10:31:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fb29c57e-27ce-7f80-12c2-881daea53309@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
	<118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
	<CAFEAcA9NBu+L4wHfkLTv93wy90wjnV05EZ12PT6PmLjdZ5h_YA@mail.gmail.com>
	<00aa913d-a7e9-3c5d-34a8-fc9ff59091db@redhat.com>
	<CAFEAcA_fTb5uYaB3vxr3iPXLskaOmQQr1Yrd89h91noxPF1O5Q@mail.gmail.com>
	<fb29c57e-27ce-7f80-12c2-881daea53309@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 18:31:22 +0100
Message-ID: <CAFEAcA9DP8yH40KRUOW1ae-xbYc3SrR+4oRm1Bs36VoV2YdNdg@mail.gmail.com>
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

On 10 October 2018 at 20:54, Cleber Rosa <crosa@redhat.com> wrote:
> On 10/10/18 2:07 PM, Peter Maydell wrote:
>> We should aim to test the machines we care about (regardless
>> of what architectures they are), rather than thinking about it
>> in terms of "testing architectures X, Y, Z", I think.
>>
>
> To me it's clear that:
>
>  1) I lack a complete understanding of what "we care about"
>  2) It's easier to start with something, and tweak it to taste

Right. Effectively you're already defining a set of
"machines we care about" -- it's just that rather than
explicitly saying 'we care about x86-64 pc, i386 pc, aarch64 virt,
ppc spapr, ...' you're implicitly doing it by defining
a 'default machine' for various architectures and a list
of architectures. I think you should just list the machines
you're testing with, instead.

I don't mind if we start with a list of what we're testing
that's small (or even wrong!) -- we can expand and correct it
later. I'd just like the list to be the correct shape.

thanks
-- PMM
