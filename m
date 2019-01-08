Received: from eggs.gnu.org ([209.51.188.92]:39527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggsWg-00086W-28
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggsWe-0003RL-7p
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:38:41 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggsWd-0003KQ-0S
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:38:39 -0500
Received: by mail-wr1-f42.google.com with SMTP id q18so4264463wrx.9
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 06:38:37 -0800 (PST)
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-4-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ec8ca75-88a4-8061-be69-8a30bd0c2b80@redhat.com>
Date: Tue, 8 Jan 2019 15:38:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190107193020.21744-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] machine: Use shorter format for
 GlobalProperty arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On 1/7/19 8:30 PM, Eduardo Habkost wrote:
> Instead of verbose arrays with 4 lines for each entry, make each
> entry take only one line.  This makes long arrays that couldn't
> fit in the screen become short and readable.

And we'll thank you for the next git diff :)
