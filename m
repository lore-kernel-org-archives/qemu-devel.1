Received: from eggs.gnu.org ([2001:4830:134:3::10]:50300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIetN-0000dM-FL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIetK-0000gj-7Z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:37:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIetK-0000gZ-2K
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:37:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-6-marcandre.lureau@redhat.com>
	<878tlct0o3.fsf@dusky.pond.sub.org>
	<CAFEAcA8C2yfwJHyf63pWc5Sxbb+sbTeTpDJG6H4VYARwX=Yxcw@mail.gmail.com>
	<87fufct04g.fsf@dusky.pond.sub.org>
	<CAFEAcA_wVkwDUpJ4phLvz0TBbPG2UTjs6ua5i+YCnb0dWKUH+A@mail.gmail.com>
Date: Wed, 07 Jun 2017 19:37:05 +0200
In-Reply-To: <CAFEAcA_wVkwDUpJ4phLvz0TBbPG2UTjs6ua5i+YCnb0dWKUH+A@mail.gmail.com>
	(Peter Maydell's message of "Wed, 7 Jun 2017 14:44:50 +0100")
Message-ID: <87k24nog1q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 05/45] qdev: remove PropertyInfo.qtype
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 7 June 2017 at 14:09, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> So how should I obtain those semantics with this cleanup in place ?
>>
>> Two ways come to mind:
>>
>> * Define a PropertyInfo like qdev_prop_uint32 with a null
>>   set_default_value(), and use that.
>>
>> * Add a flag to Property that makes qdev_property_add_static() skip
>>   prop->info->set_default_value(), set it for your property.
>>
>>   Actually, I'd probably do it the other way: call ->set_default_value()
>>   only when the flag is set.  No need to check it's non-null then.
>>   Setting the flag when it's null is a programming error.
>>
>> Could one of these two work for you?
>
> The former would work but duplicates a pile of code from the
> qdev_prop_uint32 implementation. The latter would be cleaner
> but introduces a dependency on this series -- how close is it
> to hitting master?

v2 was close, v3 just hit the list, but I'll be on vacation next week.
Wrapping it up this week seems unrealistic.  Soon after I'm back is my
best estimate.
