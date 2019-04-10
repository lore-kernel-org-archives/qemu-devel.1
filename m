Received: from eggs.gnu.org ([209.51.188.92]:58041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hEHAD-0001pH-UW
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hEHAC-00020F-Ok
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:37:33 -0400
References: <20190409210655.777-1-jsnow@redhat.com>
	<87y34i2zbt.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
Date: Wed, 10 Apr 2019 13:37:27 -0400
MIME-Version: 1.0
In-Reply-To: <87y34i2zbt.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>



On 4/10/19 1:39 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> It turns out that having options listed in three places continues to be
>> a bad idea. I'm still toying with the idea of an improved infrastructure
>> here, but in the meantime, another bandaid.
>>
>> There are three locations:
>> (1) .hx file, formatted as texi
>> (2) .hx file, formatted as human readable.
>> (3) .texi file, as section headers, formatted as texi.
>>
>> You can compare the two summaries within the .hx file like so:
>>
>> Human-readable command summaries:
>> `./qemu-img --help | grep 'Command syntax' -A14`
>> Detokenized texi command summaries:
>> `grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`
>>
>> You can compare the two separate texi summaries like so:
>>
>> Texi command summaries:
>> `grep "@item" qemu-img-cmds.hx"`
>> Texi command headers:
>> grep -E "@item.*@var" qemu-img.texi | tail -14
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> Extra points for explaining how you found the issues in detail
> sufficient for reproducing.
> 
> Nice to have in 4.0.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

If it can go in for 4.0, who stages it? Kevin?

--js
