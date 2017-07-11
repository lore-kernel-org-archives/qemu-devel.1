Received: from eggs.gnu.org ([2001:4830:134:3::10]:38876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV1jY-00037P-HN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV1jV-0000Yv-ER
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dV1jV-0000Yd-8Z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10791C04B31C
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:26:08 +0000 (UTC)
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f668daab-6e6a-9ea0-b2ee-e4c36388f185@redhat.com>
Date: Tue, 11 Jul 2017 22:26:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170711103011.32631-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com

On 07/11/17 12:30, Marc-Andr=C3=A9 Lureau wrote:

> v3: from Laszlo review
> - change vmcoreinfo offset to 36
> - reset err to null after report
> - use PRIu32
> - change name_size and desc_size against MAX_VMCOREINFO_SIZE
> - python code simplification
> - check boundaries of blocks in phys_memory_read()
> - fix some vmgi vs vmci names
> - add more comments in code
> - fix comment indentation
> - add r-b tags

I compared patches #1, #2, #5, #7 too, against v2 -- there have been
some justified changes (wherever appropriate); my earlier R-b / A-b tags
stand.

Thanks
Laszlo
