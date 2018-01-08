Received: from eggs.gnu.org ([2001:4830:134:3::10]:47521)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eYZoa-0006Ex-PT
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eYZoV-0000nV-RK
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:58:20 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54574 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eYZoV-0000lS-IK
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:58:15 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Mon, 8 Jan 2018 16:58:08 +0100
References: <1515425247-21730-1-git-send-email-pl@kamp.de>
	<7813468a-6fc1-12f2-9234-32783e0d9cbc@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <7185e395-aded-e616-9d5e-5ce0b3f6e1a0@kamp.de>
Date: Mon, 8 Jan 2018 16:58:09 +0100
MIME-Version: 1.0
In-Reply-To: <7813468a-6fc1-12f2-9234-32783e0d9cbc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: fix initialization of iTask
 in iscsi_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, famz@redhat.com, qemu-stable@nongnu.org

Am 08.01.2018 um 16:55 schrieb Eric Blake:
> On 01/08/2018 09:27 AM, Peter Lieven wrote:
>> in case of unaligned requests or on a target that does not support
>> block provisioning we leave iTask uninitialized and check iTask.task
>> for NULL later.
>>
>> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
>> Cc: qemu-stable@nongnu.org
> qemu-stable isn't necessary right now, since e38bc23 is not part of 2.11
> (backporting this patch is necessary only if that commit is first
> backported to 2.11.1 or similar).

You are right. I thought it was....

Peter
