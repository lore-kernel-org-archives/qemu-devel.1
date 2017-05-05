Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6YmJ-0004wv-Uv
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6YmE-0005bW-Vt
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6YmE-0005aN-Pr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:39:50 -0400
Message-ID: <1493973586.371.65.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 05 May 2017 10:39:46 +0200
In-Reply-To: <20170505075918.4033-1-philippevoinov@gmail.com>
References: <20170505075918.4033-1-philippevoinov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ui: input-linux: Add absolute event support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe Voinov <philippevoinov@gmail.com>
Cc: qemu-devel@nongnu.org

  Hi,

> This patch allows, for example, uinput to be used to create virtual
> absolute input devices. This lets you build external systems which share
> physical input devices between guests.

Ah, interesting.

> +static bool input_linux_abs_range_is_valid(int min, int max)
> +{
> +  int64_t difference =3D ((int64_t) max) - ((int64_t) min);
> +  return difference > 0 && difference <=3D INT_MAX;
> +}

Does this happen in practice?
If so we might consider improving ui/input.c instead.

cheers,
  Gerd
