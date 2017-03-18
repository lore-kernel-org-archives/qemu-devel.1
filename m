Received: from eggs.gnu.org ([2001:4830:134:3::10]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpI5L-0001iv-Fq
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpI5K-0004xZ-Il
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:24:11 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpI5K-0004x2-Ba
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:24:10 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u132so36082352wmg.0
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 10:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <64e3466a-58e9-4720-e158-27227bc69d2f@redhat.com>
References: <20170317152412.8472-1-pbonzini@redhat.com>
	<64e3466a-58e9-4720-e158-27227bc69d2f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 17:23:48 +0000
Message-ID: <CAFEAcA-NY8izZr3iuJsjomtc42Q0GC-chVr04+ZOguKMUCrVkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] curl: fix compilation on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 18 March 2017 at 02:27, Max Reitz <mreitz@redhat.com> wrote:
> On 17.03.2017 16:24, Paolo Bonzini wrote:
>> EPROTO is not found in OpenBSD.   We usually use EIO when no better
>> errno is available, do that here too.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  block/curl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks, applied to my block branch:
>
> https://github.com/XanClic/qemu/commits/block

Thanks; I've applied it to master as a build fix, though,
so you can drop it (or leave it and let the merge
sort it out if you like).

thanks
-- PMM
