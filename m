Received: from eggs.gnu.org ([2001:4830:134:3::10]:49913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJf8m-00062B-BD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJf1p-0002d0-Ie
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gJf1p-0002cU-Cw
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:34:53 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181101101715.9443-3-fli@suse.com> (Fei Li's message of "Thu, 1
	Nov 2018 18:17:08 +0800")
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-3-fli@suse.com>
Reply-To: quintela@redhat.com
Date: Mon, 05 Nov 2018 14:34:46 +0100
Message-ID: <87d0rjvea1.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v7 2/9] qemu_init_vcpu: add a new Error
 parameter to propagate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, peterx@redhat.com

Fei Li <fli@suse.com> wrote:
> This patch is to pave the way for a later patch as it is too long:
> "qemu_thread_create: propagate the error to callers to handle."
>
> The callers of qemu_init_vcpu() already passed the **errp to handle
> errors. In view of this, add a new Error parameter to all the
> functions called by qemu_init_vcpu() to propagate the error and let
> the further callers check it.
>
> Besides, make qemu_init_vcpu() return a Boolean value to let its
> callers know whether it succeeds.
>
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
