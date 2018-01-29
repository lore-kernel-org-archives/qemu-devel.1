Received: from eggs.gnu.org ([2001:4830:134:3::10]:60995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eg3Bc-0000Au-IZ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eg3BZ-0008Ei-GR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:45:00 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:44385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eg3BZ-0008EO-9d
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:44:57 -0500
Received: by mail-io0-x244.google.com with SMTP id z6so6452890iob.11
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 22:44:56 -0800 (PST)
References: <20180115023501.37361-1-aik@ozlabs.ru>
	<7b942fc7-a061-789a-4223-030d234602ca@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4482df3b-8700-9b5f-43f4-08d5fe31d42a@ozlabs.ru>
Date: Mon, 29 Jan 2018 17:44:51 +1100
MIME-Version: 1.0
In-Reply-To: <7b942fc7-a061-789a-4223-030d234602ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Allow capstone=git only if
 git update is not disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 15/01/18 17:48, Thomas Huth wrote:
> On 15.01.2018 03:35, Alexey Kardashevskiy wrote:
>> Even with --disable-git-update, ./configure tries updating the capstone
>> submodule instead of marking it "no"; this disables capstone submodule
>> if git update is disabled.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 89bd662..92c21b3 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4502,7 +4502,7 @@ case "$capstone" in
>>    "" | yes)
>>      if $pkg_config capstone; then
>>        capstone=system
>> -    elif test -e "${source_path}/.git" ; then
>> +    elif test -e "${source_path}/.git" -a $git_update = 'yes' ; then
>>        capstone=git
>>      elif test -e "${source_path}/capstone/Makefile" ; then
>>        capstone=internal
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>


Thanks mate. What's next? :)


-- 
Alexey
