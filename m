Received: from eggs.gnu.org ([209.51.188.92]:33527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3br-0008OG-JN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3bq-0000uu-0X
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:53:03 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3bo-0000sk-0V
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:53:01 -0500
Received: by mail-wr1-x433.google.com with SMTP id z5so23157947wrt.11
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 06:52:59 -0800 (PST)
References: <20190111182533.31593-1-ehabkost@redhat.com>
	<CAFEAcA-q-ZamiVtN6yLD9jFAywqLgo3aq6H7rukyBOZ62dQaDA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-q-ZamiVtN6yLD9jFAywqLgo3aq6H7rukyBOZ62dQaDA@mail.gmail.com>
Date: Mon, 14 Jan 2019 14:52:57 +0000
Message-ID: <877ef7p9yu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Work around test-qht-par + gprof issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 11 Jan 2019 at 18:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>> The following changes since commit e53f7796fbe71a5c7c24ffebf04b4aa9a759d=
a36:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-=
request' into staging (2019-01-11 13:35:48 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>>
>> for you to fetch changes up to ce2eefd7c21697fee87a0686353de881081d22c6:
>>
>>   tests: Disable qht-bench parallel test when using gprof (2019-01-11 16=
:21:45 -0200)
>>
>> ----------------------------------------------------------------
>> Work around test-qht-par + gprof issues
>>
>> Travis CI jobs are failing because of test-qht-par when gprof is
>> enabled.  Temporarily disable test-qht-par if gprof is enabled,
>> until we fix the bug.

I think we can revert 2/2 now with the usleep changes. I'll include it in
my PR.

--
Alex Benn=C3=A9e
