Received: from eggs.gnu.org ([2001:4830:134:3::10]:59381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKlWC-0003Ro-WF
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKlWB-0003Ct-3e
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:42:48 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKlWA-000364-Sk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:42:47 -0500
Received: by mail-oi1-x241.google.com with SMTP id v198-v6so17113626oif.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:42:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5786633e-6edf-50c3-59e8-967db6c10dd7@redhat.com>
References: <20181106153330.5139-1-peter.maydell@linaro.org>
	<5786633e-6edf-50c3-59e8-967db6c10dd7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 14:42:18 +0000
Message-ID: <CAFEAcA85Z4SNQio96EuprVUpDmCEg0-BnpmCXg9tBvESSzKieQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] replay: Exit on errors reading
 from replay log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 6 November 2018 at 22:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/11/2018 16:33, Peter Maydell wrote:
>> Currently replay_get_byte() does not check for an error
>> from getc(). Coverity points out (CID 1390622) that this
>> could result in unexpected behaviour (such as looping
>> forever, if we use the replay_get_dword() return value
>> for a loop count). We don't expect reads from the replay
>> log to fail, and if they do there is no way we can
>> continue. So make them fatal errors.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---


> Makes sense, can you apply it directly to qemu.git as soon as Pavel
> reviews it (or in some time if he doesn't)?

Applied to master, thanks.

-- PMM
