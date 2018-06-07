Received: from eggs.gnu.org ([2001:4830:134:3::10]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvLk-0000qX-Lc
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvLj-00050b-W7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:53:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<20180529174821.19964-4-f4bug@amsat.org>
Date: Thu, 07 Jun 2018 15:53:05 +0200
In-Reply-To: <20180529174821.19964-4-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	29 May 2018 14:48:20 -0300")
Message-ID: <87d0x2vh32.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/arm/sysbus-fdt: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Use error_report() + exit() instead of error_setg(&error_fatal),
> as suggested by the "qapi/error.h" documentation:
>
>    Please don't error_setg(&error_fatal, ...), use error_report() and
>    exit(), because that's more obvious.
>
> This fixes CID 1352173:
>     "Passing null pointer dt_name to qemu_fdt_node_path, which dereferenc=
es it."
>
> And this also fixes:
>
>     hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'node=
_path') results in a null pointer dereference
>         if (node_path[1]) {
>             ^~~~~~~~~~~~
>
> Fixes: Coverity CID 1352173 (Dereference after null check)
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Same code smell as in PATCH 4/4.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
