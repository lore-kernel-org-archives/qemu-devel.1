Received: from eggs.gnu.org ([209.51.188.92]:51888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMoME-0003ef-JL
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMoMD-0001Bq-Hd
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:41:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMoMB-0001Ap-KK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:41:12 -0400
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
	<b6e70863-4ec9-0209-46b0-b74eb1453fcf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf07eade-4377-0016-ac80-f7fbb5f05515@redhat.com>
Date: Sat, 4 May 2019 08:41:03 +0200
MIME-Version: 1.0
In-Reply-To: <b6e70863-4ec9-0209-46b0-b74eb1453fcf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/19] configure: automatically pick python3
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 03/05/2019 19.04, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/3/19 6:41 PM, Thomas Huth wrote:
>> On 03/05/2019 02.41, Eduardo Habkost wrote:
>>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>
>>> Unless overridden via an env var or configure arg, QEMU will only loo=
k
>>> for the 'python' binary in $PATH. This is unhelpful on distros which
>>> are only shipping Python 3.x (eg Fedora) in their default install as,
>>> if they comply with PEP 394, the bare 'python' binary won't exist.
>>>
>>> This changes configure so that by default it will search for all thre=
e
>>> common python binaries, preferring to find Python 3.x versions.
>>>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Message-Id: <20190327170701.23798-1-berrange@redhat.com>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  configure | 18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> I haven't bisected it, but I think this patch here broke the gitlab-ci=
 tests:
>>
>>  https://gitlab.com/huth/qemu/-/jobs/206806257
>=20
> What's the easier way to notice that automatically?

Maybe Peter could tweak one of his acceptance test environments to use a
non-UTF-8 locale?

 Thomas
