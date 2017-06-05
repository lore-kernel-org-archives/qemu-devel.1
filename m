Received: from eggs.gnu.org ([2001:4830:134:3::10]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsFc-0000Ma-TG
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsFc-0000XB-5d
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:40:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHsFb-0000W3-Un
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:40:56 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E800380F96
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 13:40:54 +0000 (UTC)
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
	<20170602141229.15326-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cd543c8-fdfa-1ab5-4433-06b3b890eee8@redhat.com>
Date: Mon, 5 Jun 2017 15:40:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170602141229.15326-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/9] ivshmem: use ram_from_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

On 02/06/2017 16:12, Marc-Andr=C3=A9 Lureau wrote:
> Instead of having its own mmap handling code, reuse the code from
> exec.c.
>=20
> Note: memory_region_init_ram_from_fd() adds some restrictions
> (check for xen, kvm sync-mmu, etc) and changes (such as size
> alignment). This may actually be more correct.

I agree.  I'm queuing patches 1-6 for now.

Paolo
