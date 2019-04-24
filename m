Received: from eggs.gnu.org ([209.51.188.92]:54434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJCmE-0007Vz-BF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJCmC-0000Ou-VC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:57:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJCmA-0000Mj-N1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:57:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FCA187637
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:57:03 +0000 (UTC)
References: <20190423212246.3542-1-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
Date: Wed, 24 Apr 2019 09:56:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 23/04/2019 23.22, Eduardo Habkost wrote:
> This series adds machine type deprecation information to the
> output of the `query-machines` QMP command.  With this, libvirt
> and management software will be able to show this information to
> users and/or suggest changes to VM configuration to avoid
> deprecated machine types.
>=20
> Eduardo Habkost (3):
>   qapi: SupportStatusInfo struct
>   machine: Use SupportStatusInfo for deprecation info
>   qmp: Add deprecation information to query-machines
>=20
>  qapi/common.json                   | 24 ++++++++++++++++++++++++
>  qapi/misc.json                     |  5 ++++-
>  include/hw/boards.h                |  7 ++++---
>  hw/i386/pc_piix.c                  |  4 +++-
>  hw/ppc/prep.c                      |  4 +++-
>  vl.c                               | 19 +++++++++++++++----
>  tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
>  7 files changed, 80 insertions(+), 10 deletions(-)
>  create mode 100644 tests/acceptance/query_machines.py

Good idea, but some questions come to my mind:

- What about devices? IIRC Gerd wrote a patch series last year that does
  something similar for devices... It would be good to synchronize the
  work, so that we do not have two completely interfaces between devices
  and machines here in the end...

- Is deprecation as a status enough, or do we want to carry more
  information here? E.g. is the machine maintained or orphan? Is it
  stable or rather experimental? And didn't Gerd have also some
  patches for this last year? ... yes, I think it was this series here:
  http://lists.gnu.org/archive/html/qemu-ppc/2018-11/msg00039.html
  ... actually, I like that idea with QemuSupportState... maybe you
  could base your work on that series instead?

 Thomas
