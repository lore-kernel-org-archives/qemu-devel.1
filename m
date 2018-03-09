Received: from eggs.gnu.org ([2001:4830:134:3::10]:42352)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1euO8n-0005Iq-FO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1euO8i-0002R0-7W
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:57:21 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:46616 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1euO8h-0002Oy-Ul
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:57:16 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Fri, 9 Mar 2018 20:57:10 +0100
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-4-git-send-email-pl@kamp.de>
	<20180309145847.GB13990@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <80991e15-3e8a-bc2f-7fd1-9548772fa916@kamp.de>
Date: Fri, 9 Mar 2018 20:57:11 +0100
MIME-Version: 1.0
In-Reply-To: <20180309145847.GB13990@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/5] migration/block: rename
 MAX_INFLIGHT_IO to MAX_IO_BUFFERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com

Am 09.03.2018 um 15:58 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> this actually limits (as the original commit mesage suggests) the
>> number of I/O buffers that can be allocated and not the number
>> of parallel (inflight) I/O requests.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
> I've queued 1-3 (which have Juan's R-b).

Thank you. It would be good if we find a proper solution for the rest as this is also important.

Peter
