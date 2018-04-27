Received: from eggs.gnu.org ([2001:4830:134:3::10]:41552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC6BB-0008Vo-Eq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC6BA-0000na-HF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:25:01 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC6BA-0000mz-9k
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:25:00 -0400
Received: by mail-ot0-x22e.google.com with SMTP id l22-v6so2675624otj.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:25:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 17:24:38 +0100
Message-ID: <CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 27 April 2018 at 17:17, Thomas Huth <thuth@redhat.com> wrote:
> On 27.04.2018 17:51, Peter Maydell wrote:
>> Hi; I usually let people forget about releases for a month or
>> so before bringing this topic up, but:
>>
>> (1) do we want to call the next release 2.13, or something else?
>> There's no particular reason to bump to 3.0 except some combination of
>>  * if we keep going like this we'll get up to 2.42, which starts to
>>    get silly
>>  * Linus-style "avoid being too predictable"
>>  * triskaidekaphobia
>
> and maybe:
>
>  * Celebrate 15 years of QEMU

Oh, hey, I hadn't noticed that. That's as good a reason as
any other!

> By the way, just another crazy idea for v3.0 (i.e. feel free to turn it
> down immediately ;-)): Since compilation and testing time for QEMU is
> really huge, what do you think if we got rid of some QEMU binaries?
> qemu-system-aarch64 is a superset of qemu-system-arm, qemu-system-x86_64
> is a superset of qemu-system-i386 and qemu-system-ppc64 is a superset of
> qemu-system-ppc (and qemu-system-ppcemb). Would be feasible to get rid
> of the subset binaries with some work? (I think they were especially
> useful on 32-bit machines in the past, but most people are using 64-bit
> machines nowadays, aren't they?).

I think Markus' backward-compatibility rubber chicken may prevent
us from removing those executables...

(In the utopian far future I'd like us to have just one QEMU
executable that could handle all architectures at once :-))

thanks
-- PMM
