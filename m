Received: from eggs.gnu.org ([2001:4830:134:3::10]:56236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ewYWt-000514-Po
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ewYWq-0001pA-M8
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:27:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ewYWq-0001oA-HY
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:27:08 -0400
References: <152103749688.51.951110294839758890@71c20359a636>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <52342f07-325c-d252-1845-97c55ea87b8f@redhat.com>
Date: Thu, 15 Mar 2018 20:26:54 +0100
MIME-Version: 1.0
In-Reply-To: <152103749688.51.951110294839758890@71c20359a636>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory: more descriptive
 lookup_type failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: drjones@redhat.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, frankja@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 03/14/18 15:24, no-reply@patchew.org wrote:

> Checking PATCH 1/1: dump-guest-memory: more descriptive lookup_type fai=
lure...
> WARNING: line over 80 characters
> #34: FILE: scripts/dump-guest-memory.py:22:
> +    raise gdb.GdbError("Symbols must be loaded prior to sourcing dump-=
guest-memory.\n"
>=20
> ERROR: line over 90 characters
> #35: FILE: scripts/dump-guest-memory.py:23:
> +                       "Symbols may be loaded by first 'attach'ing a Q=
EMU process id or by 'load'ing a QEMU binary.")
>=20
> total: 1 errors, 1 warnings, 12 lines checked

The current "width" of the script is currently:

$ wc -L scripts/dump-guest-memory.py
81 scripts/dump-guest-memory.py

I think it would be good to stick with 80 chars in this patch. (While
adhering to whatever Python idioms are considered necessary -- I think
Janosch and Marc-Andr=C3=A9 can help with that.)

Once that's fixed, please add my:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(And, I agree, this error message has been reported several times to me
as well.)

Thanks!
Laszlo
