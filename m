Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emOTS-0002CP-Ri
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emOTN-0001W8-R2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:41:38 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emOTN-0001Vs-Mg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:41:33 -0500
Received: by mail-qt0-x242.google.com with SMTP id f18so824908qth.11
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:41:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215172306.10389-1-f4bug@amsat.org>
	<20180215173429.GB24818@redhat.com>
	<df9e3a19-494d-a67b-4178-97f81229bf45@amsat.org>
	<c89deba6-a203-bea6-d196-8aad45136420@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <890fe7eb-fe23-6df0-b759-c06999337a26@amsat.org>
Date: Thu, 15 Feb 2018 15:41:29 -0300
MIME-Version: 1.0
In-Reply-To: <c89deba6-a203-bea6-d196-8aad45136420@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 02/15/2018 03:26 PM, Eric Blake wrote:
> On 02/15/2018 11:41 AM, Philippe Mathieu-Daudé wrote:
>> On 02/15/2018 02:34 PM, Daniel P. Berrangé wrote:
>>> On Thu, Feb 15, 2018 at 02:23:06PM -0300, Philippe Mathieu-Daudé wrote:
>>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>   tests/docker/common.rc | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
>>>> index 7951555e3f..dd011cdf1e 100755
>>>> --- a/tests/docker/common.rc
>>>> +++ b/tests/docker/common.rc
>>>> @@ -30,7 +30,9 @@ build_qemu()
>>>>                    $@"
>>>>       echo "Configure options:"
>>>>       echo $config_opts
>>>> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
>>>> +    $QEMU_SRC/configure $config_opts || \
>>>> +        (cat config.log && prep_fail "Failed to run 'configure'")
> 
> Is a subshell necessary; or can you get by with the simpler
>  { cat && prep_fail "..."; }

You are right, since the subshell is not necessary, better to use { ;}

TIL :)

> 
>>>> +    make $MAKEFLAGS
>>>>   }
>>>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> Slightly nicer than my patch thanks to the prep_fail addition.
>>
>> Haha this was a funny experience of parallel programming :)
>>
>> However your patch has a slightly nicer description!
> 
> 
