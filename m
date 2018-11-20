Received: from eggs.gnu.org ([2001:4830:134:3::10]:36449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5ub-0000es-HW
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5ua-0002QN-Ip
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:17:53 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP5ua-0002Q9-E3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:17:52 -0500
Received: by mail-ot1-x342.google.com with SMTP id s5so1592024oth.7
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 05:17:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJq7VHKTJw-OKYoEdwaZJWS9v-v8ENkEWLByZAWYNOZZw@mail.gmail.com>
References: <20181115154639.29949-1-dgilbert@redhat.com>
	<CAJ+F1CJq7VHKTJw-OKYoEdwaZJWS9v-v8ENkEWLByZAWYNOZZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 13:17:31 +0000
Message-ID: <CAFEAcA-NN+yoMfR0rQo89xfnP5Qrgisj-gc1=ob5eBxbb87Raw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.1] x86: Add 3.1 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 15 November 2018 at 19:48, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> On Thu, Nov 15, 2018 at 7:47 PM Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
>>
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> x86 doesn't need a 3.1 machine type, because there's no incompatibility,
>> but it looks odd not having one, especially since s390, ppc and ARM have
>> it.  Join the party.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>
> I sent same patch already reviewed by Michael a few weeks ago:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06574.html

Could you post that as a standalone patch marked as for-3.1 please?
Then we can put it into the release without having to manually
fish it out of a big patchset.

thanks
-- PMM
