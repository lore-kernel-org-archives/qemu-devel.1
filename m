Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSovj-0008E1-Fg
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSove-0002jY-Af
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSovd-0002QD-OG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:58:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 173B73084032
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 19:58:12 +0000 (UTC)
References: <20181130111222.25386-1-kraxel@redhat.com>
	<20181130111222.25386-3-kraxel@redhat.com>
	<75c973a5-f571-e69e-e2fd-72d3b3b118b2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bfce1b7d-6b41-0296-605e-e63ed359d249@redhat.com>
Date: Fri, 30 Nov 2018 13:58:06 -0600
MIME-Version: 1.0
In-Reply-To: <75c973a5-f571-e69e-e2fd-72d3b3b118b2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] usb-mtp: outlaw slashes in
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 11/30/18 1:08 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/11/18 12:12, Gerd Hoffmann wrote:
>> Slash is unix directory separator, so they are not allowed in filename=
s.
>> Note this also stops the classic escape via "../".
>>
>> Fixes: CVE-2018-16867
>> Reported-by: Michael Hanselmann (hansmi.ch)
>=20
> It's common for scripts to match '<email>', can you write this one as
> Michael Hanselmann <hansmi.ch>?

That's not an email address, though. Do we have an email for Michael, or=20
just a username?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
