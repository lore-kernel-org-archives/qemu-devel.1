Received: from eggs.gnu.org ([2001:4830:134:3::10]:42064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eXwST-0003iB-QZ
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 16:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eXwSQ-0008BM-Lb
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 16:56:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1eXwSQ-00089w-F8
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 16:56:50 -0500
References: <458bba0e0865443a3d4e0f8e0dbb5bc712e098b9.1513636434.git.crobinso@redhat.com>
	<8760927te0.fsf@dusky.pond.sub.org>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <2af817d4-074d-e7eb-f9dc-3fdfc2571ba9@redhat.com>
Date: Sat, 6 Jan 2018 16:56:48 -0500
MIME-Version: 1.0
In-Reply-To: <8760927te0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: More .git removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 12/19/2017 08:13 AM, Markus Armbruster wrote:
> Cole Robinson <crobinso@redhat.com> writes:
> 
>> As was last done in 379e21c25, we want to remove .git files for
>> submodules here, which we aren't presently doing for capstone and
>> keycodemapdb.
>>
>> Rather than a whitelist use 'find' to future proof this
>>
>> Signed-off-by: Cole Robinson <crobinso@redhat.com>
>> ---
>>  scripts/make-release | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/make-release b/scripts/make-release
>> index 3917df7142..7c7bec577f 100755
>> --- a/scripts/make-release
>> +++ b/scripts/make-release
>> @@ -19,7 +19,7 @@ pushd ${destination}
>>  git checkout "v${version}"
>>  git submodule update --init
>>  (cd roms/seabios && git describe --tags --long --dirty > .version)
>> -rm -rf .git roms/*/.git dtc/.git pixman/.git
>> +find . -depth -name .git -exec rm -rf '{}' \;
>>  # FIXME: The following line is a workaround for avoiding filename collisions
>>  # when unpacking u-boot sources on case-insensitive filesystems. Once we
>>  # update to something with u-boot commit 610eec7f0 we can drop this line.
> 
> Less scary: run tar with --exclude=.git.
> 

Good idea, I sent a v2 using that instead

Thanks,
Cole
