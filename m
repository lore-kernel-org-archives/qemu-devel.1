Received: from eggs.gnu.org ([2001:4830:134:3::10]:52421)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eP9t9-0004ZL-OX
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eP9t8-0003Rj-Qh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:28:07 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:56572 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eP9t8-0003Qm-7S
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:28:06 -0500
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
	<1512733868-9009-3-git-send-email-pl@kamp.de>
	<dd61b219-a965-3794-5155-1483227d5e62@redhat.com>
	<4b0586ee-45cb-cfb1-288c-bcccf81c5212@kamp.de>
	<295e577a-72e2-f397-ec44-ecdee248ff51@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <4375dd0c-42aa-56f4-f2f8-d644adba00aa@kamp.de>
Date: Wed, 13 Dec 2017 17:28:03 +0100
MIME-Version: 1.0
In-Reply-To: <295e577a-72e2-f397-ec44-ecdee248ff51@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] block/iscsi: only report an iSCSI
 Failure if we don't handle it gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, ronniesahlberg@gmail.com, mreitz@redhat.com

Am 08.12.2017 um 18:03 schrieb Eric Blake:
> On 12/08/2017 10:14 AM, Peter Lieven wrote:
>> Am 08.12.2017 um 16:11 schrieb Eric Blake:
>>> On 12/08/2017 05:51 AM, Peter Lieven wrote:
>>>> we currently report an "iSCSI Failure" in iscsi_co_generic_cb if the task
>>>> hasn't completed with SCSI_STATUS_GOOD. However, we expect a failure in
>>>> some cases and handle it gracefully. This is the case for misaligned UNMAPs
>>> Is the block layer still capable of producing a misaligned UNMAP?  If
>>> so, that's probably a bug in the block layer for not honoring the block
>>> limit geometries.
>> In theory there should be none. I think we can drop this code.
> Or, better yet, replace the check with an assert.

I would not add an assert if the device returns a CHECK CONDITION because
there might be other reasons for it. But I think its safe to remove the extra handling.
If for any reason there is a request that the target does not like it will pop up on
stderr.

Peter
