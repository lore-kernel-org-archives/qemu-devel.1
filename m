Received: from eggs.gnu.org ([2001:4830:134:3::10]:36553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elaMe-0006Ax-Qr
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elaMd-0003LK-Nq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:11:16 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elaMd-0003Kv-JH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:11:15 -0500
Received: by mail-ot0-x229.google.com with SMTP id a2so17242632otf.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 05:11:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2f4fd465-ab3a-d75d-ca91-86417b84ba9c@lauterbach.com>
References: <d23a2730-a103-6336-0658-e12fa9b0193f@lauterbach.com>
	<CAFEAcA-tc+-+KLcMPB=BV0zCmO6t7tuKHM4=kyRf_Xx0aCCidA@mail.gmail.com>
	<2f4fd465-ab3a-d75d-ca91-86417b84ba9c@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 13:10:54 +0000
Message-ID: <CAFEAcA8ZMjCVgWTVLkExSK78s7yYfUS4iRUq-aLEeSWJnqngCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] target-arm:Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2018 at 12:51, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:

>> Hi. I tried applying this patch to review it, but unfortunately your
>> email client has made a complete mess of it. In particular:
>>   * it is wrapping long lines
>>   * it is converting all the leading space characters to unicode
>>     non-breaking space characters
>>
>> which means that it won't apply. Can you resend using something that
>> doesn't mangle plaintext, please?
>
> Hi Peter,
>
> Thanks for the review!
> I'm sorry, I wasn't aware of such a wrapping problem. So, here it is the
> patch as
> a plain text email.
>
>
> Best regards,
> Abdallah
>
>  gdbstub.c              | 18 +++++++++++
>  include/qom/cpu.h      |  3 ++
>  target/arm/cpu.c       |  3 ++
>  target/arm/cpu.h       | 18 +++++++++++
>  target/arm/gdbstub.c   | 87
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/gdbstub64.c | 25 +++++++++++++++
>  target/arm/helper.c    |  3 +-
>  7 files changed, 155 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index f1d5148..f54053f 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -670,10 +670,20 @@ static const char *get_feature_xml(const char *p,
> const char **newp,

I'm afraid your email client is still wrapping long lines, as you can
see here. It is also doing the space-to-unicode-non-breaking-space
transformation.

It looks like you're using Thunderbird, in which case this might help:
https://www.kernel.org/doc/html/v4.11/process/email-clients.html#thunderbird-gui

It suggests disabling sending of format=flowed and wrapping of
long lines for patch emails.

Alternatively if you plan to send more patch mails in future
you might look into configuring the git-send-email command.

thanks
-- PMM
