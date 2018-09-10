Received: from eggs.gnu.org ([2001:4830:134:3::10]:50108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzOhN-0003uI-MD
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzOXj-0007fe-EH
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:56:09 -0400
References: <20180910092924.23403-1-berto@igalia.com>
	<20180910095748.GD4901@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d9487b1-53d6-547b-8c28-f9a1fad4991b@redhat.com>
Date: Mon, 10 Sep 2018 10:55:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180910095748.GD4901@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Test snapshot=on with
 nonexistent TMPDIR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 9/10/18 4:57 AM, Kevin Wolf wrote:
> Am 10.09.2018 um 11:29 hat Alberto Garcia geschrieben:
>> We just fixed a bug that was causing a use-after-free when QEMU was
>> unable to create a temporary snapshot. This is a test case for this
>> scenario.
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
> 
> Hm, it actually doesn't crash for me even without the fix. Anyway, I
> don't have a good idea to make it more likely to crash and it's
> certainly better than nothing.

Does running the test under valgrind reliably see the use-after-free?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
