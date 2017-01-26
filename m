Received: from eggs.gnu.org ([2001:4830:134:3::10]:50664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWjLL-00089b-9s
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWjLH-0007D5-9b
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:39:59 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:33720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWjLH-0007Cs-32
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:39:55 -0500
Received: by mail-wj0-x241.google.com with SMTP id un2so4561565wjb.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 04:39:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-15-git-send-email-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98393c37-378c-a359-6b57-c4d185ea288e@redhat.com>
Date: Thu, 26 Jan 2017 13:39:53 +0100
MIME-Version: 1.0
In-Reply-To: <1485207141-1941-15-git-send-email-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/17] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com



On 23/01/2017 22:32, Juan Quintela wrote:
>      bool started;
> +    multifd_pages_t pages;
> +    /* proteced by multifd mutex */
> +    bool done;
>  };
>  typedef struct MultiFDRecvParams MultiFDRecvParams;
> 
>  static MultiFDRecvParams *multifd_recv;
> 
> +QemuMutex multifd_recv_mutex;
> +QemuCond  multifd_recv_cond;
> +
>  static void *multifd_recv_thread(void *opaque)

Same here (and it should also be wrapped in an abstract data type).

Paolo
