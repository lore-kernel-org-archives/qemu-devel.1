Received: from eggs.gnu.org ([2001:4830:134:3::10]:54793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqkVD-0004LJ-MB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqkVC-0001ll-Ok
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:01:27 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-7-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eadf6258-4db3-d7a1-7dfa-8b4063a243b2@redhat.com>
Date: Tue, 27 Feb 2018 13:01:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 06/21] iotests: add pause_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Split out the pause command into the actual pause and the wait.
> Not every usage presently needs to resubmit a pause request.
> 
> The intent with the next commit will be to explicitly disallow
> redundant or meaningless pause/resume requests, so the tests
> need to become more judicious to reflect that.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/030        |  6 ++----
>   tests/qemu-iotests/055        | 17 ++++++-----------
>   tests/qemu-iotests/iotests.py | 12 ++++++++----
>   3 files changed, 16 insertions(+), 19 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
