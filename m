Received: from eggs.gnu.org ([209.51.188.92]:35993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxDAN-0000EB-V9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxDAN-0000lI-8K
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:55:11 -0500
References: <20190220145819.30969-1-berrange@redhat.com>
	<20190220145819.30969-2-berrange@redhat.com>
	<1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
	<20190222151655.GD25234@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
Date: Fri, 22 Feb 2019 09:54:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190222151655.GD25234@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotests: ensure we print nbd server
 log on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 2/22/19 9:16 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Feb 22, 2019 at 04:06:32PM +0100, Max Reitz wrote:
>> On 20.02.19 15:58, Daniel P. Berrang=C3=A9 wrote:
>>> If we abort the iotest early the server.log file might contain useful
>>> information for diagnosing the problem. Ensure its contents are
>>> displayed in this case.
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>>> @@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$=
TEST_IMG" | _filter_qemu_io
>>>  echo
>>>  echo "=3D=3D final server log =3D=3D"
>>>  cat "$TEST_DIR/server.log"
>>> +rm -f $TEST_DIR/server.log
>>
>> I'm not sure how well the iotests currently cope with spaced dir names
>> anyway, but it looks weird to not use quotes here right after a line
>> that does.
>=20
> Yes, that is a mistake since we tried quoting throughout the file

Can fix that while staging through my NBD queue. I'll probably send a PR
on Monday.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
