Received: from eggs.gnu.org ([2001:4830:134:3::10]:51027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYczO-0001BG-PH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYczL-000794-J9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:17:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cYczL-00078o-DO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:17:07 -0500
Date: Tue, 31 Jan 2017 20:17:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170131201333-mutt-send-email-mst@kernel.org>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Jan 31, 2017 at 05:28:57PM +0100, Laszlo Ersek wrote:
> The ACPI 6.1 spec says,
> 
> - DSDT: [...] If the X_DSDT field contains a non-zero value then this
>   field must be zero.
> - X_DSDT: [...] If the DSDT field contains a non-zero value then this
>   field must be zero.

But that's only 6.1. 6.0 and earlier did not say this.
The errata they wanted to address was:
1393 In FADT: if X_DSDT field is non-zero, DSDT
field should be ignored or deprecated

I would class this as a spec bug.

-- 
MST
