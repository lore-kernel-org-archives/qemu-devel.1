Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLCdD-00013l-VJ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLCdA-0001VY-MJ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:39:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gLCdA-0001U6-Fs
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:39:48 -0500
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-4-crosa@redhat.com>
	<14684b4b-7e09-141a-ce00-b8da8830a07e@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <4e07c0a3-f435-7e52-a1b0-8ee237f90894@redhat.com>
Date: Fri, 9 Nov 2018 14:39:31 -0500
MIME-Version: 1.0
In-Reply-To: <14684b4b-7e09-141a-ce00-b8da8830a07e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python
 versions usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>



On 11/9/18 2:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/11/18 16:07, Cleber Rosa wrote:
>> For the two Python jobs, which seem to have the goal of making sure
>> QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
>> the specified version is only applicable if a Python virtual
>> environment is used.=C2=A0 To do that, it's necessary to define the
>> (primary?) language of the job to be Python.
>>
>> Also, Travis doesn't have a 3.0 Python installation available for the
>> chosen distro, 3.2 being the lower version available.
>>
>> Reference:
>> https://docs.travis-ci.com/user/languages/python/#specifying-python-ve=
rsions
>>
>=20
> On this link the lower version available is 3.3, isnt' it?

I found out that this list is not comprehensive.  It looks like it's
just an example.

- Cleber.

>=20
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 .travis.yml | 4 +++-
>> =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index aa49c7b114..5c18d3e268 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -112,9 +112,11 @@ matrix:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compiler: clang
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Python builds
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env: CONFIG=3D"--target-list=3Dx86_64=
-softmmu"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 language: python
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "3.0"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "3.2"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env: CONFIG=3D"--target-list=3Dx86_64=
-softmmu"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 language: python
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "3.6"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Acceptance (Functional) tests
>>
