Received: from eggs.gnu.org ([2001:4830:134:3::10]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjt7A-0003Xx-QI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjt77-0000Yt-Po
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:43:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjt77-0000Xq-KJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:43:41 -0500
Date: Fri, 3 Mar 2017 16:43:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170303194338.GD11509@thinpad.lan.raisama.net>
References: <20170222192647.19690-1-ehabkost@redhat.com>
	<87y3wr8q6z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3wr8q6z.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Feb 27, 2017 at 07:05:24PM +0100, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > The "hotplugged" property is user visible, but it was never meant
> > to be set by the user. There are probably multiple ways to break
> > or crash device code by overriding the property. For example, we
> > recently fixed a crash in rtc_set_memory() related to the
> > property (commit 26ef65beab852caf2b1ef4976e3473f2d525164d).
> >
> > There has been some discussion about making management software
> > use "hotplugged=on" on migration, to indicate devices that were
> > hotplugged in the migration source. There were other suggestions
> > to address this, like including the "hotplugged" field in the
> > migration stream instead of requiring it to be set propertly.
> >
> > Whatever solution we choose in the future, this patch disables
> > setting "hotplugged" explicitly in the command-line by now,
> > because the ability to set the property is unused, untested, and
> > undocumented.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> I figure this is the safe thing to do for 2.9.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks. I have merged it to my "machine" branch, and I plan to
include it in a pull request next week.

-- 
Eduardo
