Received: from eggs.gnu.org ([2001:4830:134:3::10]:56021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH7Ko-00065p-Ll
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH7Kn-0003DO-TL
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:39:42 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH7Kn-0003DD-Fn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:39:41 -0400
Received: by mail-ot0-x243.google.com with SMTP id l12-v6so6055349oth.6
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:39:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <751a3b4f-55ef-dec0-aec9-6b48922b7843@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
	<751a3b4f-55ef-dec0-aec9-6b48922b7843@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:39:20 +0100
Message-ID: <CAFEAcA8zNZEKTQNQ_XEa_sRv=RydX0Wo6-JuQfV2Rzz4uFr=6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/30] Misc patches for 2018-05-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 May 2018 at 13:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 11/05/2018 14:19, Peter Maydell wrote:
>> Some of my build setups barf on the new glib version requirement:
>>
>>  * my aarch64 build host (a gcc compile farm machine which is running
>>    Ubuntu 14.04.5 LTS and has glib 2.40.2)
>>  * my windows cross compile setups (which have glib 2.34.3)
>>
>> The latter could probably be fixed, but it will be a pain because
>> gtk.org don't distribute prebuilt glib &c zipfiles usable for cross
>> compile any more. For the former, that LTS is apparently still
>> in support for another year.
>
> Fair enough.  I suppose that for now we can still uniformly bump up to
> 2.34, which is enough to remove all compatibility shims except for a couple.
>
> I'll resend the pull request without that part.

Thanks. If somebody has a recipe for doing mingw32/w64 cross builds
on Ubuntu hosts with a newer glib then I can look at updating
that bit of my build setup...

-- PMM
