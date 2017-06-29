Received: from eggs.gnu.org ([2001:4830:134:3::10]:57981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQc8w-0001DW-3J
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQc8s-00044Q-S4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:18:10 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQc8s-000449-Nb
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:18:06 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so11860241qta.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:18:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
	<dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
	<db5c43ba-10b1-9fce-30e6-c40368ecc46c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66391ecc-dd44-58c7-1409-75e74d17dd52@amsat.org>
Date: Thu, 29 Jun 2017 13:18:01 -0300
MIME-Version: 1.0
In-Reply-To: <db5c43ba-10b1-9fce-30e6-c40368ecc46c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

On 06/29/2017 12:47 PM, Paolo Bonzini wrote:
> On 29/06/2017 17:46, Thomas Huth wrote:
>>> TCI is enabled only with a specific configure argument if your machine
>>> is not supported by TCG.  This would break _build_ configurations, not
>>> user configurations.  It's a remote possibility that users are building
>>> their own QEMU, with TCI enabled, to work around a TCG bug.  So we can
>>> be more speedy in removing the code.
>> You never know ... it's unlikely, but there might be people around who
>> run configure with "--enable-tcg-interpreter" on purpose.
> 
> And they have never reported a bug? :)  But I agree it's not a big deal.
>   Richard should decide.
> 
> Paolo
> 
>> And why the
>> hurry for removing this? It's been around in the current shape since
>> years, so waiting for two more releases does not hurt, does it?

It is unlikely someone is using it for ARM aarch64 (see patch 5).

MTTCG was not in 2.9 but is now enabled by default on alpha/arm* since 
February 2017 and on ppc64 since April 2017. Looking at the 6 different 
bugs I show in the cover, I'm pretty sure no active developer but me 
keep trying to use tci :p

Phil.
