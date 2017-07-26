Received: from eggs.gnu.org ([2001:4830:134:3::10]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daUOP-0006fJ-Pl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daUOM-0002dw-Jb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:02:57 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daUOM-0002di-FM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:02:54 -0400
Received: by mail-qt0-x244.google.com with SMTP id d10so7092327qtb.4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:02:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170726214010.420-1-f4bug@amsat.org>
	<20170726214010.420-2-f4bug@amsat.org>
	<6f8a9fad-0c14-54ad-4529-2c07d29804ed@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6df783a5-bcd8-b491-9a19-0675a055f2cf@amsat.org>
Date: Wed, 26 Jul 2017 19:02:49 -0300
MIME-Version: 1.0
In-Reply-To: <6f8a9fad-0c14-54ad-4529-2c07d29804ed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: remember the user to run
 'git submodule' command in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, Juan Quintela <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On 07/26/2017 06:51 PM, Eric Blake wrote:
> On 07/26/2017 04:40 PM, Philippe Mathieu-Daudé wrote:
> 
> In the subject: s/remember/remind/
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   configure | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure b/configure
>> index f8b1d014d7..063de32773 100755
>> --- a/configure
>> +++ b/configure
>> @@ -502,6 +502,7 @@ if test -f "./configure"; then
>>       pwd_is_source_path="y"
>>   else
>>       pwd_is_source_path="n"
>> +    git_submodule_path_info="(in ${source_path})"
>>   fi
>>   
>>   check_define() {
>> @@ -3313,7 +3314,7 @@ else
>>       error_exit "pixman >= 0.21.8 not present. Your options:" \
>>           "  (1) Preferred: Install the pixman devel package (any recent" \
>>           "      distro should have packages as Xorg needs pixman too)." \
>> -        "  (2) Fetch the pixman submodule, using:" \
>> +        "  (2) Fetch the pixman submodule, using: $git_submodule_path_info" \
>>           "      git submodule update --init pixman"
> 
> Pre-patch (or in-tree build), we're merely giving the user something
> they can directly paste into their terminal.  But "(in /path/to/xyz)" is
> not directly useful.  Can we spell it:
> 
> (2) Fetch the pixman submodule, using:
>      ( cd $source_path &&
>        git submodule update --init pixman
>      )
> 
> for even easier copy-and-paste on the user's part?

Ok will update and resend for rc1
