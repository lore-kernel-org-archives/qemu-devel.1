Received: from eggs.gnu.org ([2001:4830:134:3::10]:53136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSTXX-0007fK-Ev
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSTXW-0006s9-N9
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:08:03 -0500
References: <faeb4b80-e191-d670-d057-28eb4ac11d11@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79b674dd-d5b5-ff7c-7497-6fce2cb31b8a@redhat.com>
Date: Thu, 29 Nov 2018 15:07:54 -0600
MIME-Version: 1.0
In-Reply-To: <faeb4b80-e191-d670-d057-28eb4ac11d11@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-iotests 232 fails when running the test as
 root user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On 11/29/18 3:03 PM, Farhan Ali wrote:
> Hi,
> 
> I am seeing a failure of the qemu-iotest number 232 when running the 
> test as a root user. Is this the expected behavior?
> 
> Here is the output of the failure:
> 

> -QEMU_PROG: -drive 
> driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: 
> Could not open 'TEST_DIR/t.IMGFMT': Permission denied
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> -
> -QEMU_PROG: -drive 
> driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not 
> open 'TEST_DIR/t.IMGFMT': Permission denied
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
> +NODE_NAME: TEST_DIR/t.IMGFMT (file)

Not entirely unexpected (since root can read what are otherwise 
read-only files), but obviously unexpected by the test. The test should 
probably refuse to run as root.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
