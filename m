Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcnTt-0004Mc-81
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcnTp-0001Xj-VI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:54:41 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcnTp-0001Xd-Mw
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:54:37 -0400
Received: by mail-wm0-x242.google.com with SMTP id v3-v6so19654698wmh.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:54:37 -0700 (PDT)
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-2-alex.bennee@linaro.org>
	<20180710065716.GK17581@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180710065716.GK17581@lemon.usersys.redhat.com>
Date: Tue, 10 Jul 2018 08:54:35 +0100
Message-ID: <87601nedac.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 01/10] tests/.gitignore: don't
 ignore docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 07/09 16:21, Alex Benn=C3=A9e wrote:
>> This was being a little over enthusiastic hiding files.
>
> What is "this" that hides test-* and calls for this patch?

I thought that was implicit from the first line, this is the .gitignore.

>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/.gitignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/.gitignore b/tests/.gitignore
>> index 08e2df1ce1..72c18aaab0 100644
>> --- a/tests/.gitignore
>> +++ b/tests/.gitignore
>> @@ -9,6 +9,7 @@ qht-bench
>>  rcutorture
>>  test-*
>>  !test-*.c
>> +!docker/test-*
>>  test-qapi-commands.[ch]
>>  test-qapi-events.[ch]
>>  test-qapi-types.[ch]
>> --
>> 2.17.1
>>


--
Alex Benn=C3=A9e
