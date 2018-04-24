Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fAsw1-0005h3-Nq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fAsvz-0001d5-3d
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:04:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1fAsvy-0001cF-UL
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C6074270969
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:04:14 +0000 (UTC)
Date: Tue, 24 Apr 2018 10:04:04 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180424080404.GO3502@paraplu>
References: <20180420231246.23130-1-lersek@redhat.com>
	<20180420231246.23130-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420231246.23130-2-lersek@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC v3 1/3] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Sat, Apr 21, 2018 at 01:12:44AM +0200, Laszlo Ersek wrote:
> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".

[...]

> Notes:
>     RFCv3:
>     
>     - The patch is new in this version. [Dan, Markus]
>     
>     - The original idea was to call the new enum @Target; however, @Target
>       generates exactly the TARGET_AARCH64, TARGET_ALPHA, TARGET_ARM, ...
>       enumeration constants that conflict with the poisoned preprocessing
>       macros of the same names. Hence @SysEmuTarget -- it's more accurate
>       anyway, since we want it to stand for system emulation targets.
>     
>     - Also, we discussed defining the new type in either "common.json" or
>       "misc.json". "misc.json" turned out to be a problem: "firmware.json"
>       would then include "misc.json" for the new type's sake, but that
>       inclusion would become the first appearance of "misc.json" -- within
>       "firmware.json". That messed up the generated documentation. By adding
>       the new type to "common.json", "misc.json" (see the 2nd patch) and
>       "firmware.json" (see the 3rd patch) can both consume the new type
>       without problems.

The last two points are interesting enough (for me) to still to keep in
the commit message, but that's minor :-)

>  qapi/common.json | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

FWIW:

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
