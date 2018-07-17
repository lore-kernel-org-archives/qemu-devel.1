Received: from eggs.gnu.org ([2001:4830:134:3::10]:39681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffVza-0001Av-27
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffVzV-0000HO-5o
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffVzU-0000FK-V6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:50:33 -0400
Date: Tue, 17 Jul 2018 16:50:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180717195028.GA6691@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

I have been looking at patches that touch typedefs.h and
wondering: why do we make typedefs.h necessary at all?  Why do we
always add typedefs for every struct and union type in QEMU?

Why do we prefer to write this:

----- qemu/typedefs.h:
typedef struct SomeType SomeType;
----------------------

----- qemu/somecode.h:
#include <qemu/typedefs.h>

int some_function(SomeType *a);
----------------------


...instead of simply writing this:?

----- qemu/somecode.h:
struct SomeType;
int some_function(struct SomeType *a);
----------------------

Is the maintenance burden of typedefs.h worth it?

-- 
Eduardo
