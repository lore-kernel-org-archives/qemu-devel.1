Received: from eggs.gnu.org ([2001:4830:134:3::10]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eg3Q1-0005AA-NJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eg3Pw-0006l3-Um
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:59:53 -0500
References: <20180115023501.37361-1-aik@ozlabs.ru>
	<7b942fc7-a061-789a-4223-030d234602ca@redhat.com>
	<4482df3b-8700-9b5f-43f4-08d5fe31d42a@ozlabs.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3b7ec8e0-451b-eed6-f9d6-592902752dc6@redhat.com>
Date: Mon, 29 Jan 2018 07:59:41 +0100
MIME-Version: 1.0
In-Reply-To: <4482df3b-8700-9b5f-43f4-08d5fe31d42a@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

On 29.01.2018 07:44, Alexey Kardashevskiy wrote:
> On 15/01/18 17:48, Thomas Huth wrote:
>> On 15.01.2018 03:35, Alexey Kardashevskiy wrote:
>>> Even with --disable-git-update, ./configure tries updating the capstone
>>> submodule instead of marking it "no"; this disables capstone submodule
>>> if git update is disabled.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  configure | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 89bd662..92c21b3 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -4502,7 +4502,7 @@ case "$capstone" in
>>>    "" | yes)
>>>      if $pkg_config capstone; then
>>>        capstone=system
>>> -    elif test -e "${source_path}/.git" ; then
>>> +    elif test -e "${source_path}/.git" -a $git_update = 'yes' ; then
>>>        capstone=git
>>>      elif test -e "${source_path}/capstone/Makefile" ; then
>>>        capstone=internal
>>>
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Thanks mate. What's next? :)

Put Paolo on CC in the hope that he can take it through the misc tree?
Or wait for the next trivial PULL request...

 Thomas
