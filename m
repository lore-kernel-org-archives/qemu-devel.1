Received: from eggs.gnu.org ([2001:4830:134:3::10]:60573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1du7xz-0002wx-Er
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1du7xy-0003ZF-HH
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:08:51 -0400
Date: Tue, 19 Sep 2017 10:08:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170919020837.GA11534@lemon.lan>
References: <20170918221124.17159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170918221124.17159-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] msf2: drop cpu_model to directly use cpu
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On Mon, 09/18 19:11, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> after Igor comment:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04709.html
>=20
> Fam: I'm trying your patchew "apply over series" feature on these 2 ser=
ies,
>      hoping they get both applied before my patch:
>=20
> Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com
> Based-on: 1505762601-27143-6-git-send-email-sundeep.lkml@gmail.com

Only one based-on will be picked up, so this doesn't work. Patchew basica=
lly
applies the series on top of something, where something is the result of =
a
previous applying. So it can be thought of a chain.

To support multiple patches, a different approach needs to be implemented=
.

Fam
