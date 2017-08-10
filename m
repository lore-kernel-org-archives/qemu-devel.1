Received: from eggs.gnu.org ([2001:4830:134:3::10]:41779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dfj3U-00006K-G9
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dfj3T-0007iD-8H
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dfj3T-0007hf-2G
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 04:42:59 -0400
Date: Thu, 10 Aug 2017 16:42:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170810084255.GA7003@lemon.lan>
References: <16148252-7ec9-bc6f-023f-d0c12efc2444@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16148252-7ec9-bc6f-023f-d0c12efc2444@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] make check-help not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

On Fri, 07/28 20:56, Philippe Mathieu-Daud=E9 wrote:
> I'm a bit lost with this error:
>=20
> (master)$ make check-help V=3D1
> cc -nostdlib  -o check-help.mo
> cc: fatal error: no input files
> compilation terminated.
> rules.mak:115: recipe for target 'check-help.mo' failed
> make: *** [check-help.mo] Error 1

I think this is because in Makefile:

ifneq ($(wildcard config-host.mak),)
include $(SRC_PATH)/tests/Makefile.include
endif

which basically means only include that file, which contains the "check-h=
elp"
rule, after configure.

We can move that ifned/endif pair down to tests/Makefile.include and move
check-help out of it.

I'll send a patch for it.

Fam
