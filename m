Received: from eggs.gnu.org ([2001:4830:134:3::10]:46170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlVX-0000pL-1K
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlVT-0003zP-Tm
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:46:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwlVT-0003zF-NW
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:46:19 -0400
Received: by mail-wr0-x241.google.com with SMTP id u48so1890505wrf.4
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 01:46:19 -0700 (PDT)
Date: Tue, 26 Sep 2017 09:46:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170926084616.GC16834@stefanha-x1.localdomain>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
	<1506401532-25274-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506401532-25274-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Tue, Sep 26, 2017 at 12:52:09PM +0800, Peter Xu wrote:
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f3e5cff..f567052 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
>  Object *object_get_objects_root(void);
>  
>  /**
> + * object_get_internal_root:
> + *
> + * Get the container object that holds internally used object
> + * instances. This is the object at path "/internal-objects"

When you update the comment, please mention that this root is for
objects that must not be user-visible.  This root is not exposed in the
qom tree.

I think mentioning this will help others understand the purpose of the
internal root.
