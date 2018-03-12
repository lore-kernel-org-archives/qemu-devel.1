Received: from eggs.gnu.org ([2001:4830:134:3::10]:54146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVW8-0003Eu-5b
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVW7-0006l2-8P
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:02:04 -0400
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
	<a69e1300-dbb2-ee8e-8b47-386bb431907a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f72081b-899c-9423-cb1b-561afd8f5b2b@redhat.com>
Date: Mon, 12 Mar 2018 17:01:39 -0500
MIME-Version: 1.0
In-Reply-To: <a69e1300-dbb2-ee8e-8b47-386bb431907a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotest 033: add misaligned
 write-zeroes test via truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com, famz@redhat.com, berto@igalia.com

On 02/23/2018 07:34 AM, Max Reitz wrote:
> On 2018-02-12 14:14, Anton Nefedov wrote:
>> This new test case only makes sense for qcow2 while iotest 033 is generic;
>> however it matches the test purpose perfectly and also 033 contains those
>> do_test() tricks to pass the alignment, which won't look nice being
>> duplicated in other tests or moved to the common code.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---

> 
> There should be a _cleanup_test_img before this or this test will fail
> with nbd.

Thanks for spotting that; patch posted:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03688.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
