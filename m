Received: from eggs.gnu.org ([2001:4830:134:3::10]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqaEf-0000Vm-Fr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqaEc-00021i-Cd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:03:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eqaEc-00021Z-8T
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:03:38 -0500
References: <1519290253-23854-1-git-send-email-thuth@redhat.com>
	<10bec09b-eead-8a2a-aff3-f42e914da451@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dbdaa341-3255-ba70-ac96-6c5320786d78@redhat.com>
Date: Tue, 27 Feb 2018 09:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <10bec09b-eead-8a2a-aff3-f42e914da451@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Move the toeplitz functions from
 checksum.h to net_rx_pkt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>

On 27.02.2018 08:55, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B402=E6=9C=8822=E6=97=A5 17:04, Thomas Huth wrote:
>> The functions are only used in this single .c file, so there is
>> no need to put all this code in a header that is included from
>> multiple places.
>>
>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>> ---
>> =C2=A0 hw/net/net_rx_pkt.c=C2=A0=C2=A0=C2=A0 | 44
>> ++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 include/net/checksum.h | 44
>> --------------------------------------------
>> =C2=A0 2 files changed, 44 insertions(+), 44 deletions(-)
>=20
> Hi Thomas,
>=20
> We have plan to implement RSS for virtio-net, so it looks like we'd
> better keep it in the header.

Oh, ok, I didn't know that, so never mind. Then please simply ignore
this patch :-)

 Thomas
