Received: from eggs.gnu.org ([2001:4830:134:3::10]:38639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evRsg-0005ou-Ig
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evRsb-0000je-PZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:09:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evRsb-0000jF-Ki
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEAA5814F0D2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:49 +0000 (UTC)
References: <20180312124939.20562-1-berrange@redhat.com>
	<20180312124939.20562-4-berrange@redhat.com>
	<20180312174621.GA14096@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ed40a69-95a9-c259-d21e-eb239b950754@redhat.com>
Date: Mon, 12 Mar 2018 13:08:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180312174621.GA14096@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/9] sockets: pull code for testing IP
 availability out of specific test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 03/12/2018 12:46 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 12, 2018 at 12:49:33PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>
>> The test-io-channel-socket.c file has some useful helper functions for
>> checking if a specific IP protocol is available. Other tests need to
>> perform similar kinds of checks to avoid running tests that will fail
>> due to missing IP protocols.
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---

>> +    if (socket_can_bind("::1") < 0) {
>> +        if (errno !=3D EADDRNOTAVAIL) {
>> +            return -1;
>> +        }
>> +    } else {
>> +        *has_ipv6 =3D true;
>> +    }
>> +
>=20
> Sigh, I should have kept the new code identical to the old code,
> rather than trying to improve it, as this is in fact broken. The
> socket_can_bind() is mistakenly returning '0' when EADDRNOTAVAIL
> is set, so we always set the has_ipv4|6 vars to true.
>=20
> It needs this squashed in:

The squash makes sense; with that, you can keep the R-b I added on the=20
series (I guess that shows I only read the code, not tried to run the=20
testsuite with the code applied, or I might have found this too).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
