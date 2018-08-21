Received: from eggs.gnu.org ([2001:4830:134:3::10]:54992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fruLx-0004yc-3D
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fruFz-00032d-BS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:10:47 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
Date: Mon, 20 Aug 2018 20:10:40 -0400
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>



On 08/17/2018 03:04 PM, John Snow wrote:
> +            error_setg_errno(&job->err, -job->ret, "job failed");

Kevin specifically asked for me to change this, and I lost it in the
shuffle. I'll send a v3 now, since there are enough nits to warrant it,
and I think I want to adjust a few things to set up the "part II"
portion of this changeset a little more nicely.

--js
