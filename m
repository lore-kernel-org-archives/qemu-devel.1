Received: from eggs.gnu.org ([2001:4830:134:3::10]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNXA-0004Dk-Jq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNX5-0003Ak-O0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:41:24 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNX5-0003Ae-IX
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:41:19 -0500
Received: by mail-qt0-x241.google.com with SMTP id c19so605647qtm.7
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:41:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215172306.10389-1-f4bug@amsat.org>
	<20180215173429.GB24818@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df9e3a19-494d-a67b-4178-97f81229bf45@amsat.org>
Date: Thu, 15 Feb 2018 14:41:15 -0300
MIME-Version: 1.0
In-Reply-To: <20180215173429.GB24818@redhat.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 02/15/2018 02:34 PM, Daniel P. Berrangé wrote:
> On Thu, Feb 15, 2018 at 02:23:06PM -0300, Philippe Mathieu-Daudé wrote:
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/common.rc | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
>> index 7951555e3f..dd011cdf1e 100755
>> --- a/tests/docker/common.rc
>> +++ b/tests/docker/common.rc
>> @@ -30,7 +30,9 @@ build_qemu()
>>                   $@"
>>      echo "Configure options:"
>>      echo $config_opts
>> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
>> +    $QEMU_SRC/configure $config_opts || \
>> +        (cat config.log && prep_fail "Failed to run 'configure'")
>> +    make $MAKEFLAGS
>>  }
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Slightly nicer than my patch thanks to the prep_fail addition.

Haha this was a funny experience of parallel programming :)

However your patch has a slightly nicer description!

> 
> 
> Regards,
> Daniel
> 
