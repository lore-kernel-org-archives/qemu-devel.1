Received: from eggs.gnu.org ([2001:4830:134:3::10]:57891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81Z5-0005OY-IS
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81Z1-0005gb-CL
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:40:51 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81Z1-0005gR-7z
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:40:47 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so14682844qti.4
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 03:40:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180415230522.24404-1-f4bug@amsat.org>
	<20180415230522.24404-3-f4bug@amsat.org>
	<5adfa8ce-b400-b017-5495-a0690decd183@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ce6ca491-febc-169b-ede7-9a6eccdcc9f4@amsat.org>
Date: Mon, 16 Apr 2018 07:40:42 -0300
MIME-Version: 1.0
In-Reply-To: <5adfa8ce-b400-b017-5495-a0690decd183@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: Display if libfdt is from
 system or git
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, YunQiang Su <syq@debian.org>, David Gibson <david@gibson.dropbear.id.au>

Hi Thomas,

On 04/16/2018 02:16 AM, Thomas Huth wrote:
> On 16.04.2018 01:05, Philippe Mathieu-Daudé wrote:
>> The configure script outputs "yes" regardless which libfdt is used:
>>
>>   ./configure
>>   [...]
>>   fdt support       yes
>>
>> Sometimes you can have both system and local git version available,
>> change the configure script to display which library got selected:
>>
>>   debian8$ dpkg-query --showformat='${Version}\n' --show libfdt-dev
>>   1.4.0+dfsg-1
>>
>>   debian8$ ./configure
>>   [...]
>>   fdt support       git
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  configure | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 162e804b49..056b391f22 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3758,15 +3758,14 @@ int main(void) { fdt_first_subnode(0, 0); return 0; }
>>  EOF
>>    if compile_prog "" "$fdt_libs" ; then
>>      # system DTC is good - use it
>> -    fdt=yes
>> +    fdt=system
>>    else
>>        # have GIT checkout, so activate dtc submodule
>>        if test -e "${source_path}/.git" ; then
>>            git_submodules="${git_submodules} dtc"
>>        fi
>>        if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
>> -          fdt=yes
>> -          dtc_internal="yes"
>> +          fdt=git
> 
> That's ok for git checkout, but what about release tarballs? I'd strange
> to see "git" here. So maybe better use "internal" instead of "git" here?
> 
> OTOH, capstone is also using the term "git" here, so this is just
> consistent here...

Having both use "internal" sounds a good cleanup.
