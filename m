Received: from eggs.gnu.org ([2001:4830:134:3::10]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovzg-0004aD-If
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovzb-0003M7-Tp
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:21:08 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dovzb-0003Lm-MZ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:21:03 -0400
Received: by mail-wr0-x231.google.com with SMTP id n33so3522820wrn.4
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 11:21:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
	<d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 19:20:41 +0100
Message-ID: <CAFEAcA8-pX+QoqSwNzL9vvRqwByoazOzB2970a2K5Zg8CXKL+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

On 4 September 2017 at 19:09, Thomas Huth <thuth@redhat.com> wrote:
> On 04.09.2017 19:19, Peter Maydell wrote:
>> Nobody has mentioned AIX host support on the mailing list for years,
>> and we have no test systems for it so it is most likely broken.
>> We've advertised in configure for two releases now that we plan
>> to drop support for this host OS, and have had no complaints.
>
> We just added this some weeks ago to our qemu-doc.texi:
>
> "Prior to the 2.10.0 release there was no official policy on how long
> features would be deprecated prior to their removal, nor any documented
> list of which features were deprecated. Thus any features deprecated
> prior to 2.10.0 will be treated as if they were first deprecated in the
> 2.10.0 release."

We pretty clearly say in the configure message
    echo "The QEMU project intends to remove support for this host OS in"
    echo "a future release if nobody volunteers to maintain it and to"
    echo "provide a build host for our continuous integration setup."

and my intention when I wrote that was absolutely to dump old
OSes in a couple of releases... The amount of code removed here
isn't great so I guess waiting a little longer doesn't hurt,
but I feel like somebody's moved the goalposts in adding that
language and not listing the deprecated host OSes and CPUs
in the list of deprecated features in 2.10 :-(

thanks
-- PMM
