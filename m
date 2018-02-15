Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emOF0-0007r4-2W
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emOEw-0000AX-VF
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:26:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emOEw-0000A3-R8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:26:38 -0500
References: <20180215172306.10389-1-f4bug@amsat.org>
	<20180215173429.GB24818@redhat.com>
	<df9e3a19-494d-a67b-4178-97f81229bf45@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c89deba6-a203-bea6-d196-8aad45136420@redhat.com>
Date: Thu, 15 Feb 2018 12:26:35 -0600
MIME-Version: 1.0
In-Reply-To: <df9e3a19-494d-a67b-4178-97f81229bf45@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: dump 'config.log' if ./configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 02/15/2018 11:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 02/15/2018 02:34 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Feb 15, 2018 at 02:23:06PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>   tests/docker/common.rc | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
>>> index 7951555e3f..dd011cdf1e 100755
>>> --- a/tests/docker/common.rc
>>> +++ b/tests/docker/common.rc
>>> @@ -30,7 +30,9 @@ build_qemu()
>>>                    $@"
>>>       echo "Configure options:"
>>>       echo $config_opts
>>> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
>>> +    $QEMU_SRC/configure $config_opts || \
>>> +        (cat config.log && prep_fail "Failed to run 'configure'")

Is a subshell necessary; or can you get by with the simpler
  { cat && prep_fail "..."; }

>>> +    make $MAKEFLAGS
>>>   }
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> Slightly nicer than my patch thanks to the prep_fail addition.
>=20
> Haha this was a funny experience of parallel programming :)
>=20
> However your patch has a slightly nicer description!


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
