Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djkcp-000375-Co
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djkcl-0005En-AL
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:12:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1djkcl-0005Dn-4S
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:12:03 -0400
Date: Mon, 21 Aug 2017 13:11:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170821131159.532e9a8c@nial.brq.redhat.com>
In-Reply-To: <7a176771-d903-9b64-a503-c81c409bcda1@amsat.org>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-9-git-send-email-imammedo@redhat.com>
	<7a176771-d903-9b64-a503-c81c409bcda1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 08/27] sparc: replace
 cpu_sparc_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>

On Fri, 18 Aug 2017 16:57:20 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> I succeed booting a SPARC image once applying 1 to 8 (this commit),
> so not being able to boot the image previously is probably due to patch=20
> order, which mean current order is not bisect-able.

I repeated patch by patch (1-8) build/test steps and it works for me
(i.e. compiles and both sparc/sparc64 target machines start as expected)

Could you re-check with clean build and if failure still persist
pin-point exact cause?

=20
