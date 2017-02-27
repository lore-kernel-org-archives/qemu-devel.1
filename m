Received: from eggs.gnu.org ([2001:4830:134:3::10]:52359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciPfv-0002aw-7q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciPfs-00025v-4n
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciPfr-00024p-Vh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170222192647.19690-1-ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 19:05:24 +0100
In-Reply-To: <20170222192647.19690-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 22 Feb 2017 16:26:47 -0300")
Message-ID: <87y3wr8q6z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RESEND] qdev: Make "hotplugged" property
 read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The "hotplugged" property is user visible, but it was never meant
> to be set by the user. There are probably multiple ways to break
> or crash device code by overriding the property. For example, we
> recently fixed a crash in rtc_set_memory() related to the
> property (commit 26ef65beab852caf2b1ef4976e3473f2d525164d).
>
> There has been some discussion about making management software
> use "hotplugged=on" on migration, to indicate devices that were
> hotplugged in the migration source. There were other suggestions
> to address this, like including the "hotplugged" field in the
> migration stream instead of requiring it to be set propertly.
>
> Whatever solution we choose in the future, this patch disables
> setting "hotplugged" explicitly in the command-line by now,
> because the ability to set the property is unused, untested, and
> undocumented.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

I figure this is the safe thing to do for 2.9.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
