Received: from eggs.gnu.org ([2001:4830:134:3::10]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS4f9-0000Ov-Ry
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS4f6-0003yH-NR
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:29:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS4f6-0003xm-Hi
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:29:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1A89C0587E7
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 17:29:39 +0000 (UTC)
References: <20171221170716.10709-1-maxime.coquelin@redhat.com>
	<20171221170716.10709-5-maxime.coquelin@redhat.com>
	<1943438857.2269649.1513876697276.JavaMail.zimbra@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <bf6e63aa-efeb-8b1f-c6ca-85dcd86e6161@redhat.com>
Date: Thu, 21 Dec 2017 18:29:27 +0100
MIME-Version: 1.0
In-Reply-To: <1943438857.2269649.1513876697276.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] vhost-user-test: fix features mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com



On 12/21/2017 06:18 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>> VIRTIO_NET_F_MAC is a bit position, not a bit mask.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>=20
> Fixing this before patch 3 would make sense.

Yes, you're right.
I'll make it patch #1 in v2.

Thanks,
Maxime
