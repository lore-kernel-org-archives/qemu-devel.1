Received: from eggs.gnu.org ([2001:4830:134:3::10]:52631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSRlY-0004pR-T4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSRlU-0000dn-Ms
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:14:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
Date: Thu, 29 Nov 2018 20:14:12 +0100
In-Reply-To: <20181106102335.20027-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Tue, 6 Nov 2018 11:23:29 +0100")
Message-ID: <87muprr917.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Introducing QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>

This series is a step from treating deprecation completely ad hoc to a
more structured approach.  I like it.  I guess we'll have to extend it.
For instance, we deprecate not only objects, but also members and even
values of members.  Members should be straightforward, values probably
not.  But that's not an argument against this series.
