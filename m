Received: from eggs.gnu.org ([209.51.188.92]:45250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJZ7F-0005lv-CX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJZ7E-0001u2-Ay
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:21 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
	<167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
	<20190424152352.GL31388@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f87e78a-843b-fe64-12c6-d7bbdecf853e@redhat.com>
Date: Thu, 25 Apr 2019 09:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190424152352.GL31388@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

On 24/04/2019 17.23, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 24, 2019 at 09:14:29AM -0500, Eric Blake wrote:
>> On 4/24/19 5:37 AM, Thomas Huth wrote:
>>> bash is installed in a different directory on non-Linux systems like
>>> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
>>> there, too.
>>
>> These tests were obviously copy-and-pasted from a fork point prior to
>> commit 11a82d14.
>=20
> Is this a candidate for a checkpatch addition to reject any use
> of /bin/bash in scripts ?

Not sure whether we should really reject it with an error (there might
be scripts that are only used on Linux anyway), but checkpatch.pl should
at least print a warning, I think.

 Thomas
