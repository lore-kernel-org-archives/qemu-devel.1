Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8aP-0004pe-7U
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8aL-0006wF-8g
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:30:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb8aK-0006vP-R1
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:30:13 -0500
Date: Mon, 15 Jan 2018 17:30:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115173001.GW8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-11-berrange@redhat.com>
	<88039710-1259-3868-0d67-febff24d36db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88039710-1259-3868-0d67-febff24d36db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/13] input: add missing JIS keys to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Miika S <miika9764@gmail.com>

On Mon, Jan 15, 2018 at 11:17:15AM -0600, Eric Blake wrote:
> On 01/15/2018 11:02 AM, Daniel P. Berrange wrote:
> > From: Miika S <miika9764@gmail.com>
> > 
> > keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana
> > 
> > Signed-off-by: Miika S <miika9764@gmail.com>
> > ---
> >  hw/input/virtio-input-hid.c | 7 +++++++
> >  qapi/ui.json                | 5 ++++-
> >  ui/keycodemapdb             | 2 +-
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> Why are you bumping the submodule here and again in 11/13? Can those two
> patches be squashed together?

This patch is just temporarily pulled from another patch series, which
I expect to get merged before this one does.

> > +++ b/ui/keycodemapdb
> > @@ -1 +1 @@
> > -Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
> > +Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
