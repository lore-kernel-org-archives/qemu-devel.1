Received: from eggs.gnu.org ([2001:4830:134:3::10]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euJD5-0002ik-6Q
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euJD2-0004dh-14
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:41:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1euJD1-0004dW-T5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:41:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7775276FBA
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 14:41:23 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5464ff65-85d4-4537-a603-fd20074d375f@redhat.com>
Date: Fri, 9 Mar 2018 15:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <1520576005-27647-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On 09/03/2018 07:13, Thomas Huth wrote:
> +
> +@item --nic none
> +Indicate that no network devices should be configured. It is used to o=
verride
> +the default configuration (default NIC with @option{--net user} backen=
d) which

the default @option{--nic user} configuration (default model and
user-mode networking backend), which...

> +is activated if no other networking options are provided.
> +

> -qemu-system-i386 -net user,hostfwd=3Dtcp::5555-:23 [...]
> +qemu-system-i386 --device e1000,netdev=3Dn1 --netdev user,id=3Dn1,host=
fwd=3Dtcp::5555-:23

I would use --nic here.  --device/--netdev is covered by
docs/qdev-device-use.txt, which should be updated separately (it even
has -usbdevice still).

> -qemu -net 'user,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 43=
21'
> +qemu-system-i386 --device e1000,netdev=3Dn1 \
> +  --netdev 'user,id=3Dn1,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10.=
10.1.1 4321'

Same here.

Single vs. double-dash options is a confusing one and I'm not sure how
to proceed.  On one hand single-dash is what everyone uses, on the other
double-dash is a bit more consistent with e.g. qemu-img.  But:

1) the command-line of qemu-img is anyway completely different from QEMU'=
s

2) mixing them is the worst of both worlds.

I honestly would use single-dashes, and add a note that double-dash
options are supported as well.

Paolo
