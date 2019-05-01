Received: from eggs.gnu.org ([209.51.188.92]:37826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLp3T-00081s-SV
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLp3Q-0004AO-QO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 09:13:47 -0400
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
	<877eba77ps.fsf@zen.linaroharston>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3911e5a6-fe1c-9b4b-d6f8-2da54a47742c@redhat.com>
Date: Wed, 1 May 2019 15:13:26 +0200
MIME-Version: 1.0
In-Reply-To: <877eba77ps.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 01/05/2019 13.08, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> "check -raw 005" fails when running on ext4 filesystems - these do not
>> support such large sparse files. Use the same check as in test 220 to
>> skip the test in this case.
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/005 | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
>> index 2fef63af88..6136ced5c8 100755
>> --- a/tests/qemu-iotests/005
>> +++ b/tests/qemu-iotests/005
>> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>>      _notrun "image protocol $IMGPROTO does not support large image si=
zes"
>>  fi
>>
>> +# Sanity check: For raw, we require a file system that permits the cr=
eation
>> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
>=20
> Is this comment correct? Running on my ext4 home partition this test
> seems to be running fine and not skipping.
Maybe it depends on the kernel version (I'm still using a 3.10-based
kernel here) or the way how the file system was created? It fails at
least for me on my ext4 partition.
But I can adjust a little bit for sure.

 Thomas
