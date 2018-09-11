Received: from eggs.gnu.org ([2001:4830:134:3::10]:47193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzq94-0006hI-49
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzpwt-0006xU-M6
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:11:56 -0400
References: <cover.1536698311.git.jcody@redhat.com>
	<8a9847c2ad53a74ac49d2512a5df73fcd5ff6868.1536698311.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3686de5-a384-8209-1abd-e5f281f70308@redhat.com>
Date: Tue, 11 Sep 2018 16:11:28 -0500
MIME-Version: 1.0
In-Reply-To: <8a9847c2ad53a74ac49d2512a5df73fcd5ff6868.1536698311.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block/rbd: add iotest for rbd
 legacy keyvalue filename parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com

On 9/11/18 3:43 PM, Jeff Cody wrote:
> This is a small test that will check for the ability to parse
> both legacy and modern options for rbd.
> 
> The way the test is set up is for failure to occur, but without
> having to wait to timeout on a non-existent rbd server.  The error
> messages in the success path show that the arguments were parsed.
> 
> The failure behavior prior to the patch series that has this test, is
> qemu-img complaining about mandatory options (e.g. 'pool') not being
> provided.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>   tests/qemu-iotests/231     | 62 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/231.out |  9 ++++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 72 insertions(+)
>   create mode 100755 tests/qemu-iotests/231
>   create mode 100644 tests/qemu-iotests/231.out

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
