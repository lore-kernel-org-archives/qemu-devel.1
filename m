Received: from eggs.gnu.org ([209.51.188.92]:40265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hEvJ8-0006P8-SI
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hEvJ8-0005dc-0j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hEvJ7-0005ct-Oe
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E04DA3DFCD
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 12:29:23 +0000 (UTC)
References: <20190411175345.19414-1-thuth@redhat.com>
	<20190411180314.GI3641@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <f735d36a-4e78-2656-93d6-bba2e9006cdb@redhat.com>
Date: Fri, 12 Apr 2019 14:29:14 +0200
MIME-Version: 1.0
In-Reply-To: <20190411180314.GI3641@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-QEMU-4.1] Declare -realtime
 as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 4/11/19 8:03 PM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 11, 2019 at 07:53:45PM +0200, Thomas Huth wrote:
>> The old -realtime mlock=3Don|off parameter does exactly the same as th=
e
>> new -overcommit mem-lock=3Don|off parameter. Additionally, "-realtime"
>> does not activate any additional "realtime" capabilities as the name
>> might indicate. We should avoid to confuse the users this way, so
>> let's deprecate the old -realtime option.
>=20
> FYI libvirt currently uses  -realtime mlock=3Don so will need adapting
> to cope with this change.

Done:

e8c2c8bd07 qemu_command: Prefer '-overcommit mem-lock' over -realtime mlo=
ck'
be51feff69 qemu_capabilities: Introduce QEMU_CAPS_OVERCOMMIT
a08c4b3741 qemu: Always assume QEMU_CAPS_REALTIME_MLOCK

Therefore, from libvirt's POV this patch is okay to go in.

Michal
