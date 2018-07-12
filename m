Received: from eggs.gnu.org ([2001:4830:134:3::10]:46902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fdWAr-0006OE-5f
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fdWAm-00010E-8B
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:38:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jul 2018 09:37:50 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <6f4a875e-a85f-1926-88af-91a260e334a7@redhat.com>
References: <20180705064348.3162-1-kraxel@redhat.com>
	<20180705064348.3162-3-kraxel@redhat.com>
	<20180705163501.GN7451@localhost.localdomain>
	<20180706065342.pggd2qgd4nyv35ys@sirius.home.kraxel.org>
	<20180709210833.GC7451@localhost.localdomain>
	<20180709212319.GB22336@localhost.localdomain>
	<11c6f7d4364062c42df990364bf2c2de@sebastianbauer.info>
	<20180711154850.GT7451@localhost.localdomain>
	<2b7f5bdfd86278524b4540f512eecbc7@sebastianbauer.info>
	<20180711184311.GX7451@localhost.localdomain>
	<6f4a875e-a85f-1926-88af-91a260e334a7@redhat.com>
Message-ID: <b09f43cb2147d6aafdc2b17a15b980f1@sebastianbauer.info>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/2] vga: don't pick cirrus
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

Hi,

Am 2018-07-12 06:57, schrieb Thomas Huth:
>> This is doable too, if we have a clear consensus on what would be
>> a reasonable default on TYPE_MACHINE.  Personally I prefer the
>> default on TYPE_MACHINE to be "none".
> Yes, please, no magic default hardware for all machines. That will only
> cause confusion and problems in the future. People who add new boards
> will keep forgetting to set a value in their new boards and then you
> later wonder whether that was on purpose or by accident ==> If there is
> no default display set, this should simply mean "no display".

Sounds reasonable. Let me know if I should do it or if Gerd like to 
continue as he did the initial patch.

Bye
Sebastian
