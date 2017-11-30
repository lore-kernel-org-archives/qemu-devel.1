Received: from eggs.gnu.org ([2001:4830:134:3::10]:47966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQyc-0004RJ-Ac
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQyb-0000G6-5Y
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:42:14 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-7-mreitz@redhat.com>
	<20171130031646.GK16237@lemon>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e80f97a-625d-86ae-db94-6f2f1d804a93@redhat.com>
Date: Thu, 30 Nov 2017 09:42:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171130031646.GK16237@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/17] iotests: Drop format-specific in
 _filter_img_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 11/29/2017 09:16 PM, Fam Zheng wrote:
> On Thu, 11/23 03:08, Max Reitz wrote:
>> _filter_img_info should remove format-specific information, too.  We
>> already have such a filter in _img_info, and it is very useful for
>> query-block-named-block-nodes (etc.), too.
>>
>> However, in 198 we need that information (but we still want the rest of
>> the filter), so make that filtering optional.  Note that "the rest of
>> the filter" includes filtering of the test directory, so we can drop the
>> _filter_testdir from 198 at the same time.
>>

>> +        if [[ $discard == 0 ]]; then
>> +            echo "$line"
>> +        elif [[ $discard == 1 && ! $line ]]; then
> 
> s/\$line/"\$line"/ ?
> 

Not necessary; [[ ]] is a bashism, which is part of the shell grammar so 
it doesn't need quoting.  In fact, there are some expressions in [[ ]] 
where comparing to "$foo" is actively different than comparing to $foo 
(mostly in regex, as the quotes change whether \ inside $foo are special 
to the regex or literally matched).

So this part is fine.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
