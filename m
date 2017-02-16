Received: from eggs.gnu.org ([2001:4830:134:3::10]:41058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePcl-0006jI-5r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePch-0006vk-JD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:13:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cePch-0006v6-Cx
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:13:39 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
	<e6d8ee835048d5dcae9375e568615eb5a20c2cc2.1487224954.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3221aceb-1400-d37d-bbda-923f464bc405@redhat.com>
Date: Thu, 16 Feb 2017 18:13:36 +0100
MIME-Version: 1.0
In-Reply-To: <e6d8ee835048d5dcae9375e568615eb5a20c2cc2.1487224954.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 5/8] qmp/hmp: add query-vm-generation-id
 and 'info vm-generation-id' commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com

On 02/16/17 07:18, ben@skyportsystems.com wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> Add commands to query Virtual Machine Generation ID counter.
> 
> QMP command example:
>     { "execute": "query-vm-generation-id" }
> 
> HMP command example:
>     info vm-generation-id
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hmp-commands-info.hx | 14 ++++++++++++++
>  hmp.c                |  9 +++++++++
>  hmp.h                |  1 +
>  hw/acpi/vmgenid.c    | 16 ++++++++++++++++
>  qapi-schema.json     | 20 ++++++++++++++++++++
>  stubs/Makefile.objs  |  1 +
>  stubs/vmgenid.c      |  9 +++++++++
>  7 files changed, 70 insertions(+)
>  create mode 100644 stubs/vmgenid.c

I tested the "info vm-generation-id" command via HMP.

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo
