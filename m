Received: from eggs.gnu.org ([2001:4830:134:3::10]:36551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dVxF8-00079U-V2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dVxF4-0004i3-2s
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:50:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dVxF3-0004hW-Ja
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:50:33 -0400
Message-ID: <1500025824.28252.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 14 Jul 2017 11:50:24 +0200
In-Reply-To: <20170714015435-mutt-send-email-mst@kernel.org>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170713034755-mutt-send-email-mst@kernel.org>
	<20170713152010.GS6020@localhost.localdomain>
	<20170714015435-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

  Hi,

> Removing the former might kind of work just this once on the
> assumption
> that we did not have real users back then, but fundamentally users
> have
> no safe way to upgrade machine types right now. It's stored in the
> machine XML at install time and that's it, and reinstalling guests
> is very painful.

You can easily change it using "virsh edit $domain", and improving
virt-manager to offer some UI for that should be possible too.

cheers,
  Gerd
