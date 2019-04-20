Received: from eggs.gnu.org ([209.51.188.92]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHnQU-0003gJ-46
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHnQT-000562-6F
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hHnQS-00055X-Un
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:40:53 -0400
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
Date: Sat, 20 Apr 2019 12:40:48 +0200
MIME-Version: 1.0
In-Reply-To: <4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 19/04/2019 15.44, G 3 wrote:
>=20
> On Apr 19, 2019, at 3:10 AM, Thomas Huth wrote:
>=20
>> On 19/04/2019 00.47, John Arbuckle wrote:
>>> Capstone is not necessary in order to use QEMU. Disable it by default=
.
>>> This will save the user the pain of having to figure why QEMU isn't
>>> building when this library is missing.
>>>
>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>> ---
>>> =C2=A0configure | 2 +-
>>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 1c563a7027..77d7967f92 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -433,7 +433,7 @@ opengl_dmabuf=3D"no"
>>> =C2=A0cpuid_h=3D"no"
>>> =C2=A0avx2_opt=3D""
>>> =C2=A0zlib=3D"yes"
>>> -capstone=3D""
>>> +capstone=3D"no"
>>> =C2=A0lzo=3D""
>>> =C2=A0snappy=3D""
>>> =C2=A0bzip2=3D""
>>
>> AFAIK we ship capstone as a submodule, so how can this be missing? Als=
o,
>> our philosophy is to keep everything enabled by default if possible, s=
o
>> that the code paths don't bitrot. Thus I don't think that disabling th=
is
>> by default is a good idea. ... so if you've got a problem here, there
>> must be another solution (e.g. is the system capstone detection not
>> working right on your system?).
>>
>> =C2=A0Thomas
>=20
> Thank you for replying. Capstone comes with QEMU? Every time I try to
> compile QEMU I see an error relating to Capstone not being on my system=
.
> Why do you feel that disabling Capstone by default is not a good idea?
>=20
> Here is the error message I see when compiling QEMU:
>=20
> CHK version_gen.h
> make[1]: *** No rule to make target
> `/Users/John/qemu-git/capstone/libcapstone.a'.=C2=A0 Stop.
> make: *** [subdir-capstone] Error 2

I assume you're using a git checkout here, right? For git checkouts, the
Makefile should take care of calling the scripts/git-submodule.sh script
which should initialize the submodule in the capstone directory.

What's the content of your .git-submodule-status file? What does
"configure" say about capstone support on your system?

 Thomas
