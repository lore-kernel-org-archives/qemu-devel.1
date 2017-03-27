Received: from eggs.gnu.org ([2001:4830:134:3::10]:60674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csRcw-0002oM-1y
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csRcn-0007cB-4P
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csRcm-0007aW-RN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:11:44 -0400
Message-ID: <1490609499.31035.29.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 12:11:39 +0200
In-Reply-To: <20170326095349.8571-1-jcelaya@gmail.com>
References: <20170326095349.8571-1-jcelaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] Fix input-linux reading from device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Javier Celaya <jcelaya@gmail.com>
Cc: qemu-devel@nongnu.org

On So, 2017-03-26 at 11:53 +0200, Javier Celaya wrote:
> The evdev devices in input-linux.c are read in blocks of one whole
> event. If there are not enough bytes available, they are discarded,
> instead of being kept for the next read operation. This results in
> lost events, of even non-working devices.

Have you seen this happening in practice?

> +    struct input_event event;
> +    int         to_be_read;

I'd suggest to store offset (i.e. bytes already read) instead, should
make the whole logic a bit simpler and easier to read.

> +            } else if (rc > 0){

checkpatch.pl complains here:
ERROR: space required before the open brace '{'

cheers,
  Gerd
