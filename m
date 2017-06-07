Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaWE-0005LF-D3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaWA-0006yY-Hf
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:57:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIaWA-0006yP-CP
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:56:58 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496828798-27548-8-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Wed, 07 Jun 2017 12:46:34 +0300")
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094729eucas1p15097f154039365d5e135f92b72aad1bf@eucas1p1.samsung.com>
	<1496828798-27548-8-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 14:56:55 +0200
Message-ID: <87lgp4ez1k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 07/11] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:

> +static unsigned long get_copiedmap_size(RAMBlock *rb)
> +{
> +    unsigned long pages;
> +    pages = rb->max_length >> find_first_bit((unsigned long *)&rb->page_size,
> +                                             sizeof(rb->page_size));
> +    return pages;

Are you sure that you want this and not:

pages = rb->max_length >> TARGET_PAGE_BITS?

Otherwise, in some architectures/configurations you can end with a
bitmap size that is different of the migration bitmap size.
