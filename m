Received: from eggs.gnu.org ([2001:4830:134:3::10]:43365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSiVS-0006XM-CQ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSiVM-0005Do-Mz
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:34:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSiVM-0005DQ-HU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:34:32 -0400
Received: by mail-qt0-x244.google.com with SMTP id x34-v6so23446381qtk.5
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 05:34:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180612082823.25507-1-berrange@redhat.com>
	<c076cfe0-47ac-1c54-a157-f3797bab807d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09663059-601d-8859-4454-e05db816ac29@amsat.org>
Date: Tue, 12 Jun 2018 09:34:27 -0300
MIME-Version: 1.0
In-Reply-To: <c076cfe0-47ac-1c54-a157-f3797bab807d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] travis: display config.log when configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/12/2018 09:15 AM, Eric Blake wrote:
> On 06/12/2018 03:28 AM, Daniel P. Berrangé wrote:
>> When configure fails in CI systems we must be able to see the contents
>> of the config.log file to diagnose the root cause.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   .travis.yml | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 814be151f4..fc9a1fe8a8 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -69,7 +69,7 @@ before_install:
>>     - wget -O -
>> http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz |
>> tar -xvJ
>>     - git submodule update --init --recursive
>>   before_script:
>> -  - ./configure ${CONFIG}
>> +  - ./configure ${CONFIG} || (cat config.log && exit 1)
> 
> If you want one less fork, you can spell this as:
> 
> - ./configure ${CONFIG} || { cat config.log && exit 1; }

I was just digging for your previous mail explaining that to use as
reference ;)

> 
> Either way, the patch makes sense, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

preferably using {:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
