Received: from eggs.gnu.org ([209.51.188.92]:53803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hArqV-0003ef-Ve
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hArqV-00023i-0Z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hArqT-00020G-By
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:59:05 -0400
References: <87h8c82woh.fsf@dusky.pond.sub.org>
	<20190318115407.GD26287@redhat.com> <87sgvke48n.fsf@dusky.pond.sub.org>
	<195ae49b-e167-137f-430b-a4616d3a45c0@redhat.com>
	<87r2apczz4.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <234ca694-53c2-282c-eb57-de05724ebc77@redhat.com>
Date: Mon, 1 Apr 2019 09:58:55 +0200
MIME-Version: 1.0
In-Reply-To: <87r2apczz4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Issues around TYPE_INTERFACE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 29/03/19 19:11, Markus Armbruster wrote:
>>>>> Yet they're used for less than half of the interface names:
>>>>>
>>>>>     TYPE_ISADMA
>>>>>     TYPE_MEMORY_DEVICE
>>>>>     TYPE_NMI

Could be renamed to TYPE_NMI_MONITOR_HANDLER.

>>>>>     TYPE_NVRAM
>>>>>     TYPE_PPC_VIRTUAL_HYPERVISOR
>>>>>     TYPE_STREAM_SLAVE
>>>>>     TYPE_USER_CREATABLE
>>>>>     TYPE_XICS_FABRIC
>>>>>     TYPE_XIVE_NOTIFIER
>>>>>
>>>>> Can we agree on one naming convention, and enforce it?
>>
>> I tend to like interface names that express an ability ("foo-er",
>> "foo-able").  Anything else should use a *_IF or *_IFACE suffix.
>=20
> I like the _IFACE suffix.
>=20
> Does eliding the _IFACE suffix for names ending with ER or ABLE improve
> readability?
>=20
> "foo-er" interface types:
>=20
>     INTERFACE_RDMA_PROVIDER
>     TYPE_FW_PATH_PROVIDER
>     TYPE_HOTPLUG_HANDLER
>     TYPE_INTERRUPT_STATS_PROVIDER
>     TYPE_XIVE_NOTIFIER
>=20
> "foo-er" non-interface types:

Leaving out those where grammar threw a curve ball, or things that
aren't QOM types, only the following remain (some of which could be
debated further):

>     TYPE_EXYNOS4210_COMBINER
>     TYPE_FILTER_REWRITER
>     TYPE_GENERIC_LOADER
>     TYPE_PC_SPEAKER
>     TYPE_PR_MANAGER
>     TYPE_PR_MANAGER_HELPER
>     TYPE_QIO_DNS_RESOLVER
>     TYPE_QIO_NET_LISTENER
>     TYPE_XIVE_ROUTER
>=20
> "foo-able" interface types:
>=20
>     TYPE_USER_CREATABLE
>=20
> "foo-able" non-interface types:
>=20
>     TYPE_SPAPR_TCE_TABLE

Same here, doesn't really count.

Paolo
