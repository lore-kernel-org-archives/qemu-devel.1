Received: from eggs.gnu.org ([2001:4830:134:3::10]:50500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlIqM-0003cg-9h
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlIqI-0006YP-DS
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dlIqI-0006Y6-6s
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 13:56:26 -0400
Date: Fri, 25 Aug 2017 14:56:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170825175622.GM15315@localhost.localdomain>
References: <1503592308-93913-7-git-send-email-imammedo@redhat.com>
	<1503672460-109436-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1503672460-109436-1-git-send-email-imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 v4 06/25] sparc: make cpu feature
 parsing property based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Aug 25, 2017 at 04:47:40PM +0200, Igor Mammedov wrote:
> with features converted to properties we can use the same
> approach as x86 for features parsing and drop legacy
> approach that manipulated CPU instance directly.
> New sparc_cpu_parse_features() will allow only +-feat
> and explicitly disable feat=3Don|off syntax for now.
>=20
> With that in place and sparc_cpu_parse_features() providing
> generic CPUClass::parse_features callback, the cpu_sparc_init()
> will do the same job as cpu_generic_init() so replace content
> of cpu_sparc_init() with it.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
