Received: from eggs.gnu.org ([209.51.188.92]:50701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw8OS-000541-HY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw8OR-00043F-Ve
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:37:16 -0500
References: <20190219161321.15012-1-berrange@redhat.com>
	<20190219161321.15012-3-berrange@redhat.com>
	<d50a19fd-b869-e7f4-cfc7-80191b01ecbf@redhat.com>
	<20190219162114.GQ7154@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7382859-c57f-4de9-e0d1-b69ccc19f71d@redhat.com>
Date: Tue, 19 Feb 2019 10:37:05 -0600
MIME-Version: 1.0
In-Reply-To: <20190219162114.GQ7154@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: avoid broken pipe with
 certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/19/19 10:21 AM, Daniel P. Berrang=C3=A9 wrote:

>>> +tls_certtool()
>>> +{
>>> +    certtool "$@" 1>certtool.log 2>&1
>>> +    if test "$?" =3D 0; then
>>> +      head -1 certtool.log
>>> +    else
>>> +      cat certtool.log
>>> +    fi
>>> +    rm -f certtool.log
>>> +}
>>
>> I assume this is running in a unique directory so that there can not b=
e
>> a clash with a test running in parallel? Otherwise I'd recommend an
>> mktemp file name here...
>=20
> Hmm, could be a problem.  Whatever happened to the plan to make every
> iotests run in a private directory ? Did that ever get done ?

Nope, still not done :(

Jeff left Red Hat, and so far no one else has revived his series.
Volunteers?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
