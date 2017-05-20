Received: from eggs.gnu.org ([2001:4830:134:3::10]:55617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCEFG-00026c-Ti
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCEFD-0001lL-SJ
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:57:14 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:35359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCEFD-0001lH-NZ
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:57:11 -0400
Received: by mail-oi0-x230.google.com with SMTP id l18so127459277oig.2
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 16:57:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<87k25f36c8.fsf@linaro.org>
Message-ID: <c8f4cffd-218c-d506-9a00-720bb9e4738f@amsat.org>
Date: Sat, 20 May 2017 20:57:08 -0300
MIME-Version: 1.0
In-Reply-To: <87k25f36c8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/21] docker/shippable: cross-build
 mipsel and powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Alex,

On 05/17/2017 11:28 AM, Alex Bennée wrote:
>> v2:
>> - Addressed review feedback from Alex, added his R-B
>> - Fixed the "Problem with the SSL CA cert" problem while cloning from github.com
>>   installing the ca-certificates package.
>> - Squashed/split some commits
>> - use 'apt-get clean' instead of brutal 'rm -rf'
>> - checked how many cores are available on Shippable and use them fully
>>   (reduced total time from 44min to 38min)
>> - build armeb-linux-user target
>
> Ping - is there a v3 coming with Fam's comments addressed?

I did address Fam's comment, I'm not sure about how Fam wanted to 
document "where" extra files are copied to in the container's filesystem 
but tried to improve what was here.

There is an issue when you add files with the ADD directive, if any file 
is changed the script generates the same SHA1 hash and avoid to rebuild 
the image, I added some lines to also consider per-file checksum, but 
not for the shlibs case (I let a FIXME entry for that).

I then got stuck trying to improve `--include-executable`, I think the 
correct way would be to use ldd to get linked libraries from the host, 
then try to install them in the guest from the distrib packages, and 
finally copy what can't be find in the guest.
But better let it for another serie.

Regards,

Phil.
