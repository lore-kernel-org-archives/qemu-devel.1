Received: from eggs.gnu.org ([2001:4830:134:3::10]:52097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZDuj-0002bz-QT
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZDug-0001X7-J8
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:47:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZDug-0001WS-Cq
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:47:18 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180110100929.15986.71777.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Wed, 10 Jan 2018 13:09:30 +0300")
References: <20180110100929.15986.71777.stgit@pasha-VirtualBox>
Reply-To: quintela@redhat.com
Date: Wed, 10 Jan 2018 11:47:13 +0100
Message-ID: <874lnuyor2.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> wrote:
> HPET saves its state by calculating the current time and recovers timer
> offset using this calculated value. But these calculations include
> divisions and multiplications. Therefore the timer state cannot be recovered
> precise enough.
> This patch introduces saving of the original value of the offset to
> preserve the determinism of the timer.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> --
> v3: Added compat property for correct migration.

Yeap, Much better.

> @@ -762,6 +787,7 @@ static Property hpet_device_properties[] = {
>      DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
>      DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
>      DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
> +    DEFINE_PROP_BOOL("hpet-offset-saved", HPETState, hpet_offset_saved, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };

I am thinking about the name, but I can't suggest anything else that is
short and descriptive, so ....

Later, Juan.
