Received: from eggs.gnu.org ([2001:4830:134:3::10]:56116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfPw-0005VV-4h
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfPs-0006eo-9G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:59:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gJfPs-0006KD-0u
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:59:44 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181101101715.9443-8-fli@suse.com> (Fei Li's message of "Thu, 1
	Nov 2018 18:17:13 +0800")
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-8-fli@suse.com>
Reply-To: quintela@redhat.com
Date: Mon, 05 Nov 2018 14:59:01 +0100
Message-ID: <8736sfvd5m.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v7 7/9] migration: remove unused
 &local_err parameter in migrate_set_error
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
> Always call migrate_set_error() to set the error state without relying
> on whether multifd_save_cleanup() succeeds. As the passed &local_err
> is never used in multifd_save_cleanup(), remove it.

Error is not used, you are right.

But then just change the prototype to:

void multifd_save_cleanup(void);

??

With that change,

Reviewed-by: Juan Quintela <quintela@redhat.com>
