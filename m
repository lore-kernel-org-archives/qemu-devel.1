Received: from eggs.gnu.org ([2001:4830:134:3::10]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dHg9F-0001fz-Ig
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dHg9B-00040c-25
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:45:33 -0400
Received: from [59.151.112.132] (port=20919 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dHg9A-0003yD-Lh
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:45:28 -0400
References: <20170602040838.29995-1-quwenruo@cn.fujitsu.com>
	<936f8428-8ee1-17a3-a94d-1a9237ad5dc7@redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <e9d6cf2c-38e1-5f62-c619-95ad10445c9c@cn.fujitsu.com>
Date: Mon, 5 Jun 2017 08:45:15 +0800
MIME-Version: 1.0
In-Reply-To: <936f8428-8ee1-17a3-a94d-1a9237ad5dc7@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gitignore: Ignore vim per-project config
 and clang complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



At 06/02/2017 10:57 PM, Eric Blake wrote:
> On 06/01/2017 11:08 PM, Qu Wenruo wrote:
>> Since we have already ignored ctags, ignoring .clangcomplete for
>> vim-clang_completion is quite reasonable for me.
>> (Not to mention vim-clang_completion provides better and more accurate
>> completion and definition search)
>>
>> Also, qemu coding style is using 4 space as indent other than 8-space
>> tab, it also makes sense to ignore per-project vim config file.
> 
> We already have a per-project emacs config file (.dir-locals.el); I
> think it would be a better idea if you were to propose adding an
> appropriate .vim* file for inclusion in the project that makes vim work
> out-of-the-box with correct settings, rather than masking the file as
> unaddable and requiring all vim-using contributors to recreate the same
> settings.  (But as I am not personally a vim user, I can neither provide
> such a sample file myself, nor review one if you post it).

The problem is there is no out-of-box per-project vimrc behavior for 
vanilla vim.

There are several ways to do it, like using exrc, which will search for 
".vimrc" or ".exrc" in current directory.
Although this method will cause annoying prompt every time vim is 
started up.
If this method is preferred, I can change it to .vimrc other than using 
.vim*.

Or manually call "silent so .vimrc", which is also my preferred method.
In case of using "so" method, users can specify the filename as they 
like. So I use ".vim*".

Although, we have the 3rd method, to match current working path and then 
apply the per-project settings.
This method don't need any modification to qemu, but if one is working 
on several projects, this could be quite messy.

Thanks,
Qu
> 
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>   .gitignore | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 55a001e3b8..c7c6eec0b6 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -113,6 +113,8 @@
>>   cscope.*
>>   tags
>>   TAGS
>> +.vim*
>> +.clang_complete
> 
> The idea of adding .clang_complete to the exclusions makes sense to me.
> 
