Received: from eggs.gnu.org ([2001:4830:134:3::10]:45053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUywI-0005CJ-Rm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUywF-00086c-L0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:27:10 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUywF-00085l-Fb
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:27:07 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so8338959wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:27:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1158652012.49603326.1499793308542.JavaMail.zimbra@redhat.com>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
	<1158652012.49603326.1499793308542.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 18:25:45 +0100
Message-ID: <CAFEAcA8ud++Mpp5s_myOx1=CQYak1gQfs0tfhjn8Hd5EvxjXVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qdev: support properties which don't
 set a default value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 11 July 2017 at 18:15, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
>> @@ -793,7 +793,7 @@ void qdev_property_add_static(DeviceState *dev, Prop=
erty
>> *prop,
>>                                      prop->info->description,
>>                                      &error_abort);
>>
>> -    if (prop->info->set_default_value) {
>> +    if (prop->set_default) {
>
> Not sure if it's worth to have an assert(prop->info->set_default_value), =
probably not necessary.
>
>>          prop->info->set_default_value(obj, prop);

Yes, we'll just segfault on the NULL pointer immediately anyway.
I tend to the view that assertions are for turning obscure
and delayed failures into clearer and more immediate
failures, and in this case the failure is already pretty
clear and immediate.

thanks
-- PMM
