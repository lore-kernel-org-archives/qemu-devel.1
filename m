Received: from eggs.gnu.org ([2001:4830:134:3::10]:34685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKhA3-0003ba-K5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKhA2-0001TS-S6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:26:51 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKhA2-0001TA-JK
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:26:50 -0400
Received: by mail-wr0-x233.google.com with SMTP id q97so131366805wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 01:26:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4a61a587-6dff-e5fd-58aa-fd168e27f876@redhat.com>
References: <20170608070716.2954-1-kraxel@redhat.com>
	<CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
	<CAFEAcA9YuwACfrciwQnHV-S60AMYZoaNzTKecEE7KzuCt2Wtyg@mail.gmail.com>
	<4a61a587-6dff-e5fd-58aa-fd168e27f876@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 09:26:28 +0100
Message-ID: <CAFEAcA-yoQuDtKx-hePwCh47S6Um7_nxcdXLiQKUQN5=eHm7Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2017 at 06:14, Thomas Huth <thuth@redhat.com> wrote:
> On 12.06.2017 20:08, Peter Maydell wrote:
>> On 12 June 2017 at 19:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> This causes configure to barf warnings in my build logs on half
>>> my build machines:
>>>
>>> WARNING: Support for gtk2 will be dropped in future releases.
>>> WARNING: Please consider using gtk3 instead.
>>>
>>> I don't think it is yet possible to drop gtk2.
>>
>> Oh, one of them was the warning about SDL1.2.
>
> Adding the warning does not necessarily mean that we've really got to
> drop support for these in the very near future, but it's a good start to
> remind people that support for the old versions won't be around forever
> ;-) And AFAIK the old versions of these libraries are not maintained by
> the upstream projects anymore, too, so at one point in time, we've
> really got to deprecate support for these in QEMU, too.
>
> So would it at least be feasible to install SDL 2 on that build
> machines? (IMHO installing SDL 2 from sources is not too much of a pain,
> e.g. it does not require lots of other additional libraries around)

Yes, I'll circle back and have a look at whether it's just a matter
of installing an extra -dev package. If it's necessary to build from
source then it's definitely too early to deprecate though.

(Mostly if I have a long pullreq queue than printing warning messages
in my build logs is a good way to get your pull request pushed to
the end of the todo list :-))

thanks
-- PMM
