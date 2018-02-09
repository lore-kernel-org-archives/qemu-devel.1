Received: from eggs.gnu.org ([2001:4830:134:3::10]:37359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ekHs8-0006IA-EG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 18:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ekHs7-0002lO-Kj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 18:14:24 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-12-jsnow@redhat.com>
	<98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e1fb385a-de76-8634-6f0d-16aea7118e48@redhat.com>
Date: Fri, 9 Feb 2018 18:13:59 -0500
MIME-Version: 1.0
In-Reply-To: <98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/13] block/mirror: remove
 block_job_sleep_ns calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com



On 02/07/2018 05:46 PM, Max Reitz wrote:
> Errr.  Are you sure about that?
> 
> Now every mirror job in the qeny process will share this single
> variable.  Was that your intention?
> 

Duh, no.

Thanks for the review, also. I'm currently sidetracked on something
else, so I'll get back to this soon.
