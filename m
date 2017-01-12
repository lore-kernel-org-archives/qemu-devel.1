Received: from eggs.gnu.org ([2001:4830:134:3::10]:55448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRdOk-0004yz-EL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRdOf-0003II-OL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:18:26 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRdOf-0003I1-IM
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:18:21 -0500
Received: by mail-ua0-x235.google.com with SMTP id y9so11775086uae.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 03:18:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cd10cc95-39dc-d960-ac06-f7c9f0946df3@msgid.tls.msk.ru>
References: <20161212173151.18092-1-marcandre.lureau@redhat.com>
	<20161212173151.18092-2-marcandre.lureau@redhat.com>
	<cd10cc95-39dc-d960-ac06-f7c9f0946df3@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 11:18:00 +0000
Message-ID: <CAFEAcA_wEmy1ZBeBFf1QOeE7-k8_PWf3nNSdPOJVWUHwKMafSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] object.h: improve OBJECT/OBJECT_CLASS
 doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 12 January 2017 at 10:46, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 12.12.2016 20:31, Marc-Andr=C3=A9 Lureau wrote:
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qom/object.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index c5e6fc1f5d..c5456db05d 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -467,7 +467,7 @@ struct TypeInfo
>>   * OBJECT:
>>   * @obj: A derivative of #Object
>>   *
>> - * Converts an object to a #Object.  Since all objects are #Objects,
>> + * Converts an object to a #Object.  Since all objects are #Object,
>>   * this function will always succeed.
>
> I'm not sure this is a good change. Yes the type name is "Object"
> (singular), but we refer to multiple objectS (plural), so... :)
> If we had some coloring, we'd wrote it like, eg, #<b>Object</b>s,
> with "s" being outside of the type name.

Mmm, but doc-comment parsers won't be able to figure out that
#Objects should refer to the #Object type. You could rephrase
as "Since every object is an #Object" to get around that.

thanks
-- PMM
