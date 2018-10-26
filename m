Received: from eggs.gnu.org ([2001:4830:134:3::10]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1gFxnj-00067X-9H
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1gFxng-0008E3-Ip
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:49:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1gFxne-000862-Pv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D16030BB35B
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:48:44 +0000 (UTC)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <b833e608-007a-c77f-9e35-41175203b634@redhat.com>
Date: Fri, 26 Oct 2018 09:48:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181025203758.GA29995@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt]  [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Prasad J Pandit <ppandit@redhat.com>

On 10/25/2018 09:37 PM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
>> While being at it deprecate cirrus too.
>>
>> Reason (short version): use stdvga instead.
>> Verbose version:
>>      https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-=
harmful
>=20
> Every single one of my guests is using cirrus. This wasn't an explicit
> choice on my part, so I believe it is being used as the default in
> virt-install.
>=20

virt-manager/virt-install 2.0.0 will never explicitly set cirrus, but=20
that release is quite new. The previous release's default for x86 was=20
roughly:

if using spice graphics:
     use qxl
elif guest os is windows:
     use vga
else:
     use cirrus

It was definitely sub optimal. Maybe your virt-install commands were=20
explicitly setting --graphics vnc which would trigger cirrus in that case=
.

> I don't debate the points in the blog post above that stdvga is a
> better choice, but I don't think that's enough to justify deprecating
> cirrus at this point in time, because when it then gets deleted it
> will break way too many existing deployments.
>=20
> We need to socialize info in that blog post above more widely and
> especially ensure that apps are not using that by default. I don't
> see it being viable to formally deprecate it in QEMU any time soon
> though given existing usage.
