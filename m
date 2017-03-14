Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1cnrx3-0002zT-IA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1cnrwz-0002j8-Kd
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1cnrwz-0002iI-Er
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:17:41 -0400
References: <1476275861-27613-1-git-send-email-ppandit@redhat.com>
	<33183CC9F5247A488A2544077AF19020B0429759@SZXEMA503-MBS.china.huawei.com>
	<9d8d6a84-1220-2e61-dbdc-b86d5e348bef@redhat.com>
	<292d3a97-4dc9-6678-6a4f-acb5856e91f7@reactos.org>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <c3cddc59-619f-90bd-5521-fd139c865680@redhat.com>
Date: Tue, 14 Mar 2017 15:17:38 -0400
MIME-Version: 1.0
In-Reply-To: <292d3a97-4dc9-6678-6a4f-acb5856e91f7@reactos.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dma: rc4030: limit interval timer reload
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Huawei PSIRT <PSIRT@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>

On 11/16/2016 12:50 AM, Herv=E9 Poussineau wrote:
> Hi,
>=20
> Le 10/11/2016 =E0 15:50, Paolo Bonzini a =E9crit :
>>
>>
>> On 10/11/2016 06:56, Gonglei (Arei) wrote:
>>> Any ideas about this fix?
>>
>> It seems sensible, but perhaps the field is even smaller.  Let's CC
>> Herv=E9 and Aurelien as I don't have a datasheet for this device.
>=20
> Sorry for the delay...
>=20
> I don't have any datasheet for this device either, so I tested with rea=
l
> programs.
> Those initialize itr field to either 0 or to 9, so your mask doesn't ch=
ange
> anything.
>=20
> Tested-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>=20

I'm coming to this thread from the Fedora bug for this CVE,
https://bugzilla.redhat.com/show_bug.cgi?id=3D1384876

I don't see this patch in qemu.git yet, can someone pick it up for a pull=
 request?

Thanks,
Cole
