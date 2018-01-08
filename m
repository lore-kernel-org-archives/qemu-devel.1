Received: from eggs.gnu.org ([2001:4830:134:3::10]:54244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYbtF-0003Qu-13
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYbtB-0005ha-1N
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:11:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYbtA-0005gw-RY
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:11:12 -0500
References: <20180108180231.21122-1-f4bug@amsat.org>
	<20180108180231.21122-7-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78a9d2fc-d027-9857-ce4e-b7c186960609@redhat.com>
Date: Mon, 8 Jan 2018 19:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180108180231.21122-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 6/7] net/eepro100: reduce alignment to
 DWORD (32bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 08/01/2018 19:02, Philippe Mathieu-Daud=C3=A9 wrote:
>      /* Data in mem is always in the byte order of the controller (le).
>       * It must be dword aligned to allow direct access to 32 bit value=
s. */
> -    uint8_t mem[PCI_MEM_SIZE] QEMU_ALIGNED(8);
> +    uint8_t mem[PCI_MEM_SIZE] QEMU_ALIGNED(4);

It's actually not needed at all, since accesses go through ld*_le_p and
st*_le_p (commit 4d9be25, "hw/net/eepro100.c: Don't use cpu_to_*w() and
*_to_cpup()", 2016-06-16).

Paolo
