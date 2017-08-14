Received: from eggs.gnu.org ([2001:4830:134:3::10]:48873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhAOi-0001mG-1H
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhAOe-0004R5-Td
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dhAOe-0004Ql-NV
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:06:48 -0400
Date: Mon, 14 Aug 2017 09:56:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170814095657.549d0bc8@nial.brq.redhat.com>
In-Reply-To: <1500040339-119465-5-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/28] sparc: convert cpu models to SPARC
 cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 14 Jul 2017 15:51:55 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> QOMfy cpu models handling introducing propper cpu types
> for each cpu model.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> with this and conversion of features to properties,
> it would be possible to replace cpu_sparc_init() with
> cpu_generic_init() and reuse common -cpu handling
> infrastructure.
> 
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>

ping,

Mark, Artoym,

As SPARC maintainers, cloud you please review/test patches 4-10/28.

[...]
