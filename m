Received: from eggs.gnu.org ([2001:4830:134:3::10]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN29V-0004oA-Mx
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN29R-0005Oa-N7
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:48:13 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN29R-0005Nn-IH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:48:09 -0500
Received: by mail-ot0-x231.google.com with SMTP id p3so7372206oti.5
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 11:48:09 -0800 (PST)
Reply-To: minyard@acm.org
References: <20171124153656.30199-1-rkagan@virtuozzo.com>
	<20171124153656.30199-2-rkagan@virtuozzo.com>
	<1f37e2f7-e83e-8605-4e86-b296abcc826d@gmail.com>
	<20171127100655.GA21361@rkaganb.sw.ru>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <7022bc21-20da-469f-84f6-4354f12ff998@gmail.com>
Date: Thu, 7 Dec 2017 13:48:06 -0600
MIME-Version: 1.0
In-Reply-To: <20171127100655.GA21361@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev-properties: add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, minyard@acm.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 11/27/2017 04:06 AM, Roman Kagan wrote:
> On Fri, Nov 24, 2017 at 08:36:53PM -0600, Corey Minyard wrote:
>> On 11/24/2017 09:36 AM, Roman Kagan wrote:
snip
>>> +
>>> +const PropertyInfo qdev_prop_uuid = {
>>> +    .name  = "str",
>>> +    .description = "UUID (aka GUID) or \"auto\" for random value",
>>> +    .get   = get_uuid,
>>> +    .set   = set_uuid,
>> There is a UUID value you can use as a default in  vl.c, named qemu_uuid.
>> Just in case you want to set a default value here.
> I'm not sure what a common non-null default for all uuid properties
> would mean...

It depends on what the uuid is for.  If you are trying to uniquely 
identify devices to
QEMU or the OS, then it make no sense.  If you are trying to identify 
qemu or what
is running in it to outside entities, then it might make sense.  I 
didn't know the
purpose of this uuid, so I thought I would suggest.

-corey

> IMO most of the time it makes sense to default to "auto".  I'll have a
> look if I can do it within this patch.
>
> Thanks,
> Roman.
>
