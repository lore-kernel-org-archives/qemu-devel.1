Received: from eggs.gnu.org ([2001:4830:134:3::10]:55936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAx9m-0008QR-6K
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAx9l-0003Fv-A8
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:34:50 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:39228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAx9l-0003FF-4x
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:34:49 -0400
Received: by mail-oi0-x233.google.com with SMTP id n65-v6so17480473oig.6
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 05:34:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87po2ohk68.fsf@dusky.pond.sub.org>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-2-marcandre.lureau@redhat.com>
	<d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
	<CAJ+F1C+X9vAi2xx5Z7yoi_65o_C9SxfE_HNrV9BDBd81Y1wxwg@mail.gmail.com>
	<87po2ohk68.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Apr 2018 13:34:27 +0100
Message-ID: <CAFEAcA-ynm85eJ9Q7F8mtYNNiUBY+BQQcCdEg_eAdfmVTD4GRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 24 April 2018 at 13:18, Markus Armbruster <armbru@redhat.com> wrote:
> We define hundreds of QOM types without ever bothering to check the
> super type comes first.  We don't even bother to clearly document it has
> to come first.

If you don't put the super type first then the first time you
do MyParent *p = MY_PARENT(me); then the QOM cast will assert
on you, so you'll figure it out pretty quickly...

thanks
-- PMM
