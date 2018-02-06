Received: from eggs.gnu.org ([2001:4830:134:3::10]:52333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7V8-0002pF-Jd
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7V7-0001Mz-Nh
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:57:50 -0500
References: <20180206171642.19826-1-vsementsov@virtuozzo.com>
	<20180206172907.GL20001@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b4ddc41e-0c96-7f91-96c6-957271baf6a4@virtuozzo.com>
Date: Tue, 6 Feb 2018 20:57:38 +0300
MIME-Version: 1.0
In-Reply-To: <20180206172907.GL20001@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com

06.02.2018 20:29, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 06, 2018 at 08:16:42PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Support default luks options in VM.add_drive and in new library
>> function qemu_img_create. Use it in 205 iotests.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> instead of
>>    [PATCH] iotests: 205: support only raw format
>>
>> let's just support luks. This patch also makes it simple to support
>> luks in any other python iotest.
>>
>>   tests/qemu-iotests/205        |  4 ++--
>>   tests/qemu-iotests/iotests.py | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.=
py
>> index 5a10b2d534..4b9a4445cd 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -58,6 +58,13 @@ qemu_default_machine =3D os.environ.get('QEMU_DEFAULT=
_MACHINE')
>>   socket_scm_helper =3D os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_=
helper')
>>   debug =3D False
>>  =20
>> +luks_default_secret_id =3D 'luks_secret_default_iotests_id'
> Can we just call this  "keysec0", so we matchh convention used by
> the shell script based tests.

Here I'm trying to avoid intersection with some user-defined id.

>
>> +luks_default_secret_data =3D '12345'
> The 'check' script exports an environment variable IMGKEYSECRET
> that is intended to be used as the default password for LUKS.

agree, missed this.

>
>> +luks_default_secret_object =3D 'secret,id=3D' + luks_default_secret_id =
+ \
>> +                             ',data=3D' + luks_default_secret_data
>> +luks_default_key_secret_opt =3D 'key-secret=3D' + luks_default_secret_i=
d
>
> Regards,
> Daniel


--=20
Best regards,
Vladimir
