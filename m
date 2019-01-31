Received: from eggs.gnu.org ([209.51.188.92]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpI4Q-0008UI-Pr
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpI2z-0008DV-MB
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:30:50 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-11-crosa@redhat.com>
	<9a116fb9-5e69-ab8e-1fb0-38f3e4c97186@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <a0653a3b-da8b-c2a3-c60f-b60e277f1ef7@redhat.com>
Date: Thu, 31 Jan 2019 14:29:52 -0500
MIME-Version: 1.0
In-Reply-To: <9a116fb9-5e69-ab8e-1fb0-38f3e4c97186@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/18] Boot Linux Console Test: refactor
 the console watcher into utility method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/31/19 12:46 PM, Wainer dos Santos Moschetta wrote:
> Hi Cleber,
>=20
> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
>> This introduces a utility method that monitors the console device and
>> looks for either a message that signals the test success or failure.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 tests/acceptance/boot_linux_console.py | 30 ++++++++++++++++++-=
-------
>> =C2=A0 1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py
>> b/tests/acceptance/boot_linux_console.py
>> index 35b31162d4..278bb2be3d 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -23,6 +23,25 @@ class BootLinuxConsole(Test):
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timeout =3D 60
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 def wait_for_console_pattern(self, success_=
message,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 failure_message=3D'Kerne=
l panic - not
>> syncing'):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Waits for messages to appe=
ar on the console, while logging
>> the content
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param success_message: if=
 this message appears, test succeeds
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param failure_message: if=
 this message appears, test fails
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>=20
> What's the docstring format used here? I am wondering if :type is optio=
nal.
>=20
> - Wainer
>=20

I've been using the same Sphinx-based docstring statements we've been
using in Avocado, for the sake of cross reference.  So yes, type is
optional, and go on the same line, or on a different one with ":type
<name of parame>".

But, there may be issues that we don't know as we're not building those
API docs.  IIRC Eduardo Habkost is going to propose a GSOC project
related to building API docs.

- Cleber.
