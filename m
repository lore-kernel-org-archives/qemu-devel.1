Received: from eggs.gnu.org ([2001:4830:134:3::10]:53858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fW0L9-0007bo-Kx
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fW0L8-00016o-7B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:13:35 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fW0L8-00016Q-1E
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:13:34 -0400
Received: by mail-wm0-x242.google.com with SMTP id z6-v6so3386020wma.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:13:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ+g4wUCi4ao8z7K6CvuO4Zt9VqOi46o4voo3e8Vceeyg@mail.gmail.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
	<20180621145405.197d5106@redhat.com>
	<CAJ+F1CKFq5=Afoqg8YZGw-TO8vJqTPwjpW_UAMh6G8LPp4ZztA@mail.gmail.com>
	<CAJ+F1CJ+g4wUCi4ao8z7K6CvuO4Zt9VqOi46o4voo3e8Vceeyg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Jun 2018 16:13:32 +0200
Message-ID: <CAJ+F1CKwFY7zM2mqYU3QtOdpx9jOXNFTtgfEvNJZionByas6Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, Jun 21, 2018 at 3:22 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Thu, Jun 21, 2018 at 3:21 PM, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>
>>>> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
>>> not quite sure how this method (supposed to ) work(s),
>>> it could use nice comment explaining mechanics.
>>>
>>
>> Windows doesn't like DerefOf (FUNC [N]), it returned wrong values. It
>> took me a while to figure this out. My laptop TPM ACPI table uses the
>> same trick, so I assume this is a Windows acpi bug/limitation. Instead
>> we use a function that returns the corresponding field.
>
> Sorry, I am wrong, my laptop doesn't use such table. I don't know
> where I saw someone using the same trick though..

fwiw, I also asked on OSR list for help but got no answer:
http://www.osronline.com/showThread.CFM?link=3D288617





--=20
Marc-Andr=C3=A9 Lureau
