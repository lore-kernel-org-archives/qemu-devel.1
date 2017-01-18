Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTttP-0006nE-5e
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTttK-0001Xl-5N
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:19:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTttJ-0001XL-Vx
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:19:22 -0500
Date: Wed, 18 Jan 2017 18:19:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118181918.783cb7bd@nial.brq.redhat.com>
In-Reply-To: <20170118175335-mutt-send-email-mst@kernel.org>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 18 Jan 2017 18:30:59 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 18, 2017 at 12:45:54PM +0100, Phil Dennis-Jordan wrote:
[...]

> > I suspect more might be involved in enabling ACPI 2.0, and it should probably be an option so as to avoid regressions. I don't know what the best approach would be for this, so comments welcome. Should adding the reset register to the FADT also be configurable?  
> 
> I would say an option to make FADT use rev 3 format would be a good
> idea.
> 
> I'd make it the default if XP survives.
if XP and legacy linux survive,
I'd skip adding option as probably there won't be any users,
in unlikely case such user surfaces we always can add option later
but we can't do it other way around (i.e. take it away).
