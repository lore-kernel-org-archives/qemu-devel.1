Received: from eggs.gnu.org ([2001:4830:134:3::10]:60120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYdnC-0007Mi-RJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYdn9-0002qz-I9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:13:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYdn9-0002qV-Ai
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:13:07 -0500
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd2b3ea4-4d7a-6b8d-23ef-b46a57cc2c24@redhat.com>
Date: Mon, 8 Jan 2018 21:13:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] slirp: remove QEMU_PACKED from
 structures with don't require it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 08.01.2018 18:28, Philippe Mathieu-Daud=C3=A9 wrote:
> theses structures are not serialized and often store host pointers.

Patch looks fine at a quick glance... did you check that migration still
works (while there is network traffic going on in the guest)?

 Thomas
