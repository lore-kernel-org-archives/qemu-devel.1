Received: from eggs.gnu.org ([2001:4830:134:3::10]:43321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYCSe-0001Vw-Rt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYCSb-0003Tv-Tz
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:34:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYCSb-0003Th-P6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54BD4401EF04
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 15:34:21 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-5-pbonzini@redhat.com>
	<64ad9493-8e84-51c0-f492-8424be8647df@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9260cec8-fd27-3ccb-a133-a2814b684e4d@redhat.com>
Date: Wed, 27 Jun 2018 17:34:18 +0200
MIME-Version: 1.0
In-Reply-To: <64ad9493-8e84-51c0-f492-8424be8647df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] pr-manager: add query-pr-managers QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

On 26/06/2018 22:51, Eric Blake wrote:
> On 06/26/2018 10:40 AM, Paolo Bonzini wrote:
>> This command lets you query the connection status of each
>> pr-manager-helper
>> object.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>=20
>> +++ b/qapi/block.json
>> @@ -77,6 +77,33 @@
>> =C2=A0 { 'struct': 'BlockdevSnapshotInternal',
>> =C2=A0=C2=A0=C2=A0 'data': { 'device': 'str', 'name': 'str' } }
>> =C2=A0 +##
>> +# @PRManagerInfo:
>> +#
>> +# Information about a persistent reservation manager
>> +#
>> +# @id: the identifier of the persistent reservation manager
>> +#
>> +# @is-connected: whether the persistent reservation manager is
>> connected to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 the underlying storage or helper
>> +#
>> +# Since: 3.0
>> +##
>> +{ 'struct': 'PRManagerInfo',
>> +=C2=A0 'data': {'id': 'str', 'is-connected': 'bool'} }
>=20
> Bike-shedding: I think 'connected' is a reasonable (and shorter) name
> for this member

Sounds good.

>> +
>> +##
>> +# @query-pr-managers:
>> +#
>> +# Returns a list of information about each persistent reservation
>> manager.
>> +#
>> +# Returns: a list of @PRManagerInfo for each persistent reservation
>> manager
>> +#
>> +# Since: 3.0
>> +##
>> +{ 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'] }
>> +
>=20
> As a query command, does it make sense to consider whether this command
> could be provided during preconfig?

Yes, definitely.

Paolo
