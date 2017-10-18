Received: from eggs.gnu.org ([2001:4830:134:3::10]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4hDS-0002uR-9S
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4hDP-0001mB-7j
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4hDP-0001lc-29
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:48:27 -0400
Message-ID: <1508305702.10073.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 18 Oct 2017 07:48:22 +0200
In-Reply-To: <20171017153742.10026-10-richard.henderson@linaro.org>
References: <20171017153742.10026-1-richard.henderson@linaro.org>
	<20171017153742.10026-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

  Hi,

> +if [ "$capstone_internal" =3D "yes" ]; then
> +=C2=A0=C2=A0echo "config-host.h: subdir-capstone" >> $config_host_mak
> +fi

I think this isn't going to work correctly.  In case both capstone and
dtc are used we need a single line with the dependencies, i.e.

  config-host.h: subdir-dtc subdir-capstone

cheers,
  Gerd
