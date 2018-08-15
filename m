Received: from eggs.gnu.org ([2001:4830:134:3::10]:56154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fpm8v-000521-CU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fpm8s-0005Jk-04
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:06:41 -0400
References: <1534161104-8253-1-git-send-email-thuth@redhat.com>
	<87y3da5txn.fsf@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a06a8e46-2710-82ba-90cc-5d48fc182e5c@redhat.com>
Date: Wed, 15 Aug 2018 11:06:30 +0800
MIME-Version: 1.0
In-Reply-To: <87y3da5txn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Fix bad "macaddr" property
 in the documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Harald Hoyer <harald@redhat.com>



On 2018=E5=B9=B408=E6=9C=8813=E6=97=A5 20:31, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>
>> When using the "-device" option, the property is called "mac".
>> "macaddr" is only used for the legacy "-net nic" option.
> Indeed:
>
>      #define DEFINE_NIC_PROPERTIES(_state, _conf)                      =
      \
> --->    DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),           =
     \
>          DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
>
>> Reported-by: Harald Hoyer <harald@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   qemu-options.hx | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index b1bf0f4..3495531 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2345,7 +2345,7 @@ qemu-system-i386 linux.img \
>>                    -netdev socket,id=3Dn2,mcast=3D230.0.0.1:1234
>>   # launch yet another QEMU instance on same "bus"
>>   qemu-system-i386 linux.img \
>> -                 -device e1000,netdev=3Dn3,macaddr=3D52:54:00:12:34:5=
8 \
>> +                 -device e1000,netdev=3Dn3,mac=3D52:54:00:12:34:58 \
>>                    -netdev socket,id=3Dn3,mcast=3D230.0.0.1:1234
>>   @end example
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Applied.

Thanks
