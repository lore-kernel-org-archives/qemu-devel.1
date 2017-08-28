Received: from eggs.gnu.org ([2001:4830:134:3::10]:57256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmI5a-0005TB-J5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmI5X-0001Ee-EC
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmI5X-0001E6-8Q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:20:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-7-git-send-email-armbru@redhat.com>
	<CAJ+F1CKORHr77fZ8OrsJc44TQL++Eazu-t0mV2+uhpW31HQSYQ@mail.gmail.com>
Date: Mon, 28 Aug 2017 13:20:12 +0200
In-Reply-To: <CAJ+F1CKORHr77fZ8OrsJc44TQL++Eazu-t0mV2+uhpW31HQSYQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 25 Aug 2017
	11:11:45 +0000")
Message-ID: <874lss3pn7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/16] qapi-schema: Collect char device
 stuff in qapi/char.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Thu, Aug 24, 2017 at 9:24 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>> diff --git a/qapi/event.json b/qapi/event.json
>> index 9c6126d..b9aa6ed 100644
>> --- a/qapi/event.json
>> +++ b/qapi/event.json
>> @@ -397,27 +397,6 @@
>>              'sector-num': 'int', 'sectors-count': 'int' } }
>>
>>  ##
>> -# @VSERPORT_CHANGE:
>> -#
>> -# Emitted when the guest opens or closes a virtio-serial port.
>> -#
>> -# @id: device identifier of the virtio-serial port
>> -#
>> -# @open: true if the guest has opened the virtio-serial port
>> -#
>> -# Since: 2.1
>> -#
>> -# Example:
>> -#
>> -# <- { "event": "VSERPORT_CHANGE",
>> -#      "data": { "id": "channel0", "open": true },
>> -#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
>> -#
>> -##
>> -{ 'event': 'VSERPORT_CHANGE',
>> -  'data': { 'id': 'str', 'open': 'bool' } }
>>
>
> That one is a bit special (since it's for virtio-serial), but it is
> char-related stuff, ok.

It made me change title from "backend stuff" to "device stuff" :)

Thanks!

>> -##
>>  # @MEM_UNPLUG_ERROR:
>>  #
>>  # Emitted when memory hot unplug error occurs.
>> --
>> 2.7.5
