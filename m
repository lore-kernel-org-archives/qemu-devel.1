Received: from eggs.gnu.org ([2001:4830:134:3::10]:43241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8T1s-00034T-IR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8T1n-0006Wc-Sq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:32:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g8T1n-0006US-Mv
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:32:35 -0400
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-7-crosa@redhat.com>
	<d81c7840-efd9-336c-9538-b032d6c54bdb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0abf928c-2bca-1303-118d-e53be021168f@redhat.com>
Date: Fri, 5 Oct 2018 11:32:24 -0500
MIME-Version: 1.0
In-Reply-To: <d81c7840-efd9-336c-9538-b032d6c54bdb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/5/18 11:24 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 04/10/2018 17:14, Cleber Rosa wrote:
>> One of the Avocado features relevant to virtualization testing is the
>> ability to reuse tests in different scenarios, known as variants.
>> This adds a JSON based variants file, that can be used to run most
>> tests in a number of different architectures.  It can be run with:
>>
>>     $ avocado run \
>>       --json-variants-load=3Dtests/acceptance/variants/arch.json \
>>       --filter-by-tags=3D'-x86_64' -- tests/acceptance/

>> +++ b/tests/acceptance/variants/arch.json
>> @@ -0,0 +1 @@
>> +[{"paths":["/run/*"],"variant":[["/run/aarch64",[["/run/aarch64", "ar=
ch", "aarch64"]]]],"variant_id": "aarch64"},{"paths":["/run/*"],"variant"=
:[["/run/ppc",[["/run/ppc", "arch", "ppc"]]]],"variant_id": "ppc"},{"path=
s":["/run/*"],"variant":[["/run/ppc64",[["/run/ppc64", "arch", "ppc64"]]]=
],"variant_id": "ppc64"},{"paths":["/run/*"],"variant":[["/run/s390x",[["=
/run/s390x", "arch", "s390x"]]]],"variant_id": "s390x"},{"paths":["/run/*=
"],"variant":[["/run/x86_64",[["/run/x86_64", "arch", "x86_64"]]]],"varia=
nt_id": "x86_64"}]
>>
>=20
> Is this generated? (thinking about the other archs supported).
>=20
> You should use some linter ;)

Also, that's a long line, which will probably get longer as more support=20
is added. Beyond 990 bytes, it starts risking problems with corruption=20
over email. It's also hard to view what changes incrementally if the=20
single line changes. Is there a way to pretty-print things across=20
multiple lines, for shorter lines and easier reading of future diffs?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
