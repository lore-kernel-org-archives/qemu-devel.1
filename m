Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gADun-00009o-Jm
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gADui-0006Hg-Gr
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gADui-0006HK-Az
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:48:32 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-7-crosa@redhat.com>
	<30d6b2fa-c529-6eb1-f9a0-476c390c5156@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <c322d1fc-eb5e-3596-4120-f98449303713@redhat.com>
Date: Wed, 10 Oct 2018 08:48:17 -0400
MIME-Version: 1.0
In-Reply-To: <30d6b2fa-c529-6eb1-f9a0-476c390c5156@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 10/10/18 6:59 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/10/2018 01:26, Cleber Rosa wrote:
>> One of the Avocado features relevant to virtualization testing is the
>> ability to reuse tests in different scenarios, known as variants.
>> This adds a JSON based variants file, that can be used to run most
>> tests in a number of different architectures.  It can be run with:
>>
>>    $ avocado run \
>>      --json-variants-load=3Dtests/acceptance/variants/arch.json \
>>      --filter-by-tags=3D'-x86_64' -- tests/acceptance/
>>
>> Currently this covers 5 architectures, resulting in the execution
>> of 25 different combinations.
>=20
> IMHO we should add this file with all supported archs, and CANCEL a job
> if there is no preferred machine in Qemu::MACHINE_TYPES.
>=20

While your proposal works, I see two issues:

 1) It defines a policy, which will affect all tests, existing and new -
even for tests that don't launch a VM and don't care about the arch.

 2) CANCEL is mostly silent, and the amount of noise in test results
would be quite large.

So, the real problem is that there are other issues when making basic
use of QEMUMachine with other archs.  The idea is to incrementally test
other archs, make the modifications necessary to scripts/qemu.py, and
end up with all architectures covered.

What do you think?

- Cleber.

>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/variants/arch.json | 92 ++++++++++++++++++++++++++++=
+
>>  1 file changed, 92 insertions(+)
>>  create mode 100644 tests/acceptance/variants/arch.json
