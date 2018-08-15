Received: from eggs.gnu.org ([2001:4830:134:3::10]:58350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq1Vg-0008Ml-Ms
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq1VZ-0004Ac-OA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:31:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fq1VZ-0004AX-JX
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:31:05 -0400
References: <20180810132800.38549-1-eblake@redhat.com>
	<904458f5-7eeb-649d-7aff-9d9ff6d75d64@redhat.com>
	<874lfyenvg.fsf@dusky.pond.sub.org>
	<cfded956-ccab-1070-ba1c-9a73bd61cc5d@redhat.com>
	<8736vfkb1l.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66dcfc08-46a5-499b-79cd-bc811a1fdb51@redhat.com>
Date: Wed, 15 Aug 2018 14:31:01 -0500
MIME-Version: 1.0
In-Reply-To: <8736vfkb1l.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, alex.bennee@linaro.org, rth@twiddle.net

On 08/15/2018 08:35 AM, Markus Armbruster wrote:

>>>>> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>>>>
>>>> Well, it would help if my commit message actually matched...

>>>>> +                const char *dump = WCOREDUMP(wstatus) ? " (dumped core)" : "";

>>>> ...the code.
>>>
>>> I got libqtest patches in my queue, and I could stick this patch in.
>>> Would you like me to touch up the commit message when I apply?  Or
>>> should I expect v5?
>>>
>>
>> If you don't mind doing the touchup (s/core dumped/dumped core/), then
>> I don't need to submit v5.
> 
> Since "core dumped" is how the shell traditionally reports this, I'd
> prefer to adjust the code to match the commit message.  Okay?

Yes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
