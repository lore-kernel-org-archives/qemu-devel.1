Received: from eggs.gnu.org ([2001:4830:134:3::10]:54217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNQc4-0002WB-0e
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNQc2-0006ot-RG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:59:51 -0500
References: <20181115225052.1322639-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2b24e02-3a9c-5408-71ab-8c3b252851ff@redhat.com>
Date: Thu, 15 Nov 2018 23:59:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181115225052.1322639-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, xiezhide@huawei.com, qemu-trivial@nongnu.org

On 15/11/2018 23:50, Eric Blake wrote:
> Adding a new qapi module requires some rather tedious repetition to
> wire it into Makefile and Makefile.objs. Add some indirection by
> taking advantage of GNU Make string processing to expand a list
> of module names into all the required artifacts, so that future
> additions of a new module need only touch the list of module names.
>=20
> The list has to live in Makefile.objs, due to the way that
> unnest-vars slirps in that file without remembering any definition
> of $(QAPI_MODULES) from Makefile.

I don't see offhand why that would happen; Makefile.objs is simply
included from Makefile.  Anyway, if this works it's okay as well.

Feel free to send me the non-working patch offlist.

Paolo
