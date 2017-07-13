Received: from eggs.gnu.org ([2001:4830:134:3::10]:57056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVhkz-0008BH-GR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVhky-0005fs-I9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:18:29 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVhky-0005fS-AP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:18:28 -0400
Received: by mail-wm0-x229.google.com with SMTP id i127so33082284wma.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 10:18:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d194xnyp.fsf@dusky.pond.sub.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
	<87lgnt99xz.fsf@dusky.pond.sub.org>
	<CAFEAcA-oEZZgPDOayLpZ1_aC0hEeOcYBL3+XejtJXnt4wDyqow@mail.gmail.com>
	<87d194xnyp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 18:18:06 +0100
Message-ID: <CAFEAcA-XrYnnzH58LkyObyJH-eGuEHK-BuQkRjwFbZmMr1oeXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 13 July 2017 at 18:10, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 12 July 2017 at 12:22, Markus Armbruster <armbru@redhat.com> wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> In some situations it's useful to have a qdev property which doesn't
>>>> automatically set its default value when qdev_property_add_static is
>>>> called (for instance when the default value is not constant).
>>>>
>>>> Support this by adding a flag to the Property struct indicating
>>>> whether to set the default value.  This replaces the existing test
>>>> for whether the PorpertyInfo set_default_value function pointer is
>>>
>>> PropertyInfo
>>>
>>>> NULL, and we set the .set_default field to true for all those cases
>>>> of struct Property which use a PropertyInfo with a non-NULL
>>>> set_default_value, so behaviour remains the same as before.
>>>>
>>>> We define two new macros DEFINE_PROP_SIGNED_NODEFAULT and
>>>> DEFINE_PROP_UNSIGNED_NODEFAULT, to cover the most plausible use cases
>>>> of wanting to set an integer property with no default value.
>>>
>>> Your text makes me wonder what is supposed to set the default value
>>> then.  Glancing ahead to PATCH 3, it looks like method instance_init()
>>> is.  Can you think of a scenario where something else sets it?
>>
>> OK, proposed extra paragraph for commit message:
>>
>> This gives us the semantics of:
>>  * if .set_default is true and .info->set_default_value is not NULL,
>>    then .defval is used as the the default value of the property
>
> If I read your patch correctly, then this should be "if .set_default is
> true, then .info->set_default_value() must not be null, and .defval is
> used ..."

Yes.

thanks
-- PMM
