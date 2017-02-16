Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ceObh-0005Fx-TT
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ceObd-0004Se-RC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:08:33 -0500
Received: from mail-db5eur01on0108.outbound.protection.outlook.com
	([104.47.2.108]:19149
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1ceObd-0004Rp-6s
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:08:29 -0500
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-22-git-send-email-pbonzini@redhat.com>
	<5712fbf2-1a9e-42c9-a22f-554a6e8bc14d@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <aefcd4e5-8d7e-b50e-e080-981e18013967@openvz.org>
Date: Thu, 16 Feb 2017 19:08:22 +0300
MIME-Version: 1.0
In-Reply-To: <5712fbf2-1a9e-42c9-a22f-554a6e8bc14d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/23] report guest crash information in
 GUEST_PANICKED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

On 02/16/2017 07:07 PM, Eric Blake wrote:
> On 02/16/2017 08:31 AM, Paolo Bonzini wrote:
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>
>> it's not very convenient to use the crash-information property interfa=
ce,
>> so provide a CPU class callback to get the guest crash information, an=
d pass
>> that information in the event
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Message-Id: <1487053524-18674-3-git-send-email-den@openvz.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> +++ b/qapi/event.json
>> @@ -488,7 +488,9 @@
>>  #
>>  # @action: action that has been taken, currently always "pause"
>>  #
>> -# Since: 1.5
>> +# @info: optional information about a panic
>> +#
>> +# Since: 1.5 (@info since 2.9)
> I had a (late) comment on this being unusual formatting, but it can be
> fixed in a followup patch if there is no other reason to respin the pul=
l
> request.
>
OK, we will send the follow up.

Anton, pls.

Den
