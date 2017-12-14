Received: from eggs.gnu.org ([2001:4830:134:3::10]:39445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePYpd-0008HP-6A
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePYpa-0005AQ-9L
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:06:09 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePYpa-00059Q-23
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:06:06 -0500
Received: by mail-ot0-x244.google.com with SMTP id p3so5814955oti.5
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 11:06:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2017 19:05:44 +0000
Message-ID: <CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/46] First batch of s390x patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 14 December 2017 at 17:09, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b6d:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' into staging (2017-12-14 15:32:32 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171214
>
> for you to fetch changes up to a9e3065c6579df8652ce38502276ac0a13180d6f:
>
>   s390-ccw-virtio: allow for systems larger that 7.999TB (2017-12-14 17:56:54 +0100)
>
> ----------------------------------------------------------------
> s390x changes for 2.12:
> - Lots of tcg improvements: ccw hotplug is now working and we can run
>   a Linux kernel built for z12 under tcg
> - zPCI improvements to get virtio-pci working
> - get rid of the cssid restrictions for virtual and non-virtual channel
>   devices
> - we now support 8TB+ systems
> - 2.12 compat machine
> - fixes and cleanups
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build on 32-bit:

In file included from
/usr/lib/arm-linux-gnueabihf/glib-2.0/include/glibconfig.h:9:0,
                 from /usr/include/glib-2.0/glib/gtypes.h:32,
                 from /usr/include/glib-2.0/glib/galloca.h:32,
                 from /usr/include/glib-2.0/glib.h:30,
                 from /home/peter.maydell/qemu/include/glib-compat.h:19,
                 from /home/peter.maydell/qemu/include/qemu/osdep.h:107,
                 from /home/peter.maydell/qemu/hw/s390x/s390-virtio-ccw.c:13:
/home/peter.maydell/qemu/hw/s390x/s390-virtio-ccw.c: In function
's390_memory_init':
/usr/include/glib-2.0/glib/gmacros.h:291:26: error: comparison is
always true due to limited range of data type [-Werror=type-limits]
 #define MIN(a, b)  (((a) < (b)) ? (a) : (b))
                          ^
/home/peter.maydell/qemu/hw/s390x/s390-virtio-ccw.c:177:17: note: in
expansion of macro 'MIN'
         chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
                 ^

(ram_addr_t can be a 32-bit type).

thanks
-- PMM
