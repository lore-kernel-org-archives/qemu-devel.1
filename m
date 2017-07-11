Received: from eggs.gnu.org ([2001:4830:134:3::10]:40796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV1vn-00069o-Dm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV1vm-0004w5-Hr
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:38:51 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dV1vm-0004vr-Bl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:38:50 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so5182180wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:38:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711184615.GH2223@work-vm>
References: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
	<1496679576-14336-3-git-send-email-peter.maydell@linaro.org>
	<20170711184615.GH2223@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 21:38:28 +0100
Message-ID: <CAFEAcA8JVfhyw7s5mfLXhTPY_5NOe-4QzrdOM-T0XexrCsWfpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Handle error returns from
 sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

On 11 July 2017 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> sosendoob() can return a failure code, but all its callers ignore it.
>> This is OK in sbappend(), as the comment there states -- we will try
>> again later in sowrite(). Add a (void) cast to tell Coverity so.
>> In sowrite() we do need to check the return value -- we should handle
>> a write failure in sosendoob() the same way we handle a write failure
>> for the normal data.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I think this is OK, I do have one worry, which is perhaps there
> were errors previously that would just loose OOB but get silently
> ignored that perhaps we survived OK.
> There's a comment there about seeing EAGAIN or EINTR in the normal
> data path and not erroring;   hopefully we don't in the OOB case?

Let's hope :-) This way round at least we'll find out if
we ever do.

> However, it generally seems to be sane, so:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

thanks
-- PMM
