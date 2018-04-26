Received: from eggs.gnu.org ([2001:4830:134:3::10]:56784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBdcF-00050J-Ma
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBdcE-0003ZK-VJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:55:03 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBdcE-0003YD-RE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:55:02 -0400
Received: by mail-oi0-x22d.google.com with SMTP id e23-v6so23560024oiy.1
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 02:55:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <91e6dbdd-6086-7c60-4bc9-a6ace1d041fc@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<91e6dbdd-6086-7c60-4bc9-a6ace1d041fc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 10:54:41 +0100
Message-ID: <CAFEAcA9jr3t4zAdB+HraNOaA+EN0b8x9jitwNGv2U880EC7T1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Olaf Hering <olaf@aepfle.de>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 26 April 2018 at 10:19, Thomas Huth <thuth@redhat.com> wrote:
> On 26.04.2018 10:17, Peter Maydell wrote:
>> I've also upgraded Xcode, which means I now have a machine with
>> a clang that emits all the -Waddress-of-packed-member complaints.
>> I have configured the test build so those aren't fatal
>> (via --extra-cflags='-Werror -Wno-error=address-of-packed-member
>> -Wno-error=deprecated-declarations') but I'm now more interested in
>> getting those cleaned up so they don't clutter up my logfiles :-)
>
> Isn't the -Wno-error=address-of-packed-members flag added by Gerd's
> patch already? See:
>
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=0e39c4aa7ecc5699bc391fcb

So it is -- I guess the compile failed because of the deprecation
warning, and I just assumed I needed to add both -Wno-error=
settings.

thanks
-- PMM
