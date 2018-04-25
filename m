Received: from eggs.gnu.org ([2001:4830:134:3::10]:60997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBGSC-0008Kk-2W
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBGS2-0002y8-CT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:11:08 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBGS2-0002xj-5Q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:10:58 -0400
Received: by mail-wr0-x242.google.com with SMTP id o15-v6so52549293wro.11
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 02:10:58 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
	<dd4e664e-87ed-9c69-f554-9c6496ec9343@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <dd4e664e-87ed-9c69-f554-9c6496ec9343@linaro.org>
Date: Wed, 25 Apr 2018 10:10:56 +0100
Message-ID: <87efj3lkgv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/46] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/24/2018 05:23 AM, Alex Benn=C3=A9e wrote:
>> @@ -675,10 +687,12 @@ case "$cpu" in
>>    i386|i486|i586|i686|i86pc|BePC)
>>      cpu=3D"i386"
>>      supported_cpu=3D"yes"
>> +    cross_cc_i386=3Dgcc
>>    ;;
>>    x86_64|amd64)
>>      cpu=3D"x86_64"
>>      supported_cpu=3D"yes"
>> +    cross_cc_x86_64=3Dgcc
>>    ;;
>>    armv*b|armv*l|arm)
>>      cpu=3D"arm"
>
> Isn't this hunk taken care of in the next patch, where you set these to $=
cc?
> And if not, surely bare "gcc" isn't correct...

Woops, I'll fix that.

>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
