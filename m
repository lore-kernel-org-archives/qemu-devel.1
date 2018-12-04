Received: from eggs.gnu.org ([2001:4830:134:3::10]:37471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUGVj-0000Sl-7x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUGO1-0001AB-Qn
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:29:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUGO1-00017b-EN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:29:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id x23so15330874oix.3
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 11:29:37 -0800 (PST)
MIME-Version: 1.0
References: <154394083644.28192.8501647946108201466.stgit@gimli.home>
	<154394987445.795.4102526920089904508.stgit@gimli.home>
	<6bc68937-ec9e-d28f-9468-5ee9ba08ef52@de.ibm.com>
	<20181204122647.3a560066@x1.home>
In-Reply-To: <20181204122647.3a560066@x1.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 19:29:25 +0000
Message-ID: <CAFEAcA_5tDfoPZaPcheMGUyq_ibbvT+GE8WKgXnHf8SnxioPvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3.1 8/9] q35/440fx/arm/spapr/ccw:
 Add QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 4 Dec 2018 at 19:26, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> On Tue, 4 Dec 2018 20:16:44 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
> > I think Conny has already added the s390/ccw part to her next tree.
> > From a quick glimpse both patches look identical.
>
> If so then we can just use the original v3 version of this patch that
> touches all but ccw and let them come together in mainline.  My
> assumption is that Peter is only trying to make sure all versioned
> machines are updated early in this release, not necessarily that
> they need to be updated together.

Yes, that's the idea. I also think it's a suboptimal idea
to include the version-number-bump patch in a series that's
adding some feature, because then if the feature itself
has to go through several rounds of patch review the
version-number-bump patch is stuck unapplied (we saw that
at the end of the 3.1 cycle), or it gets bumped by some
other unrelated series and then there's a merge conflict.
But that's more of a things-for-next time remark, no need
to rearrange this now.

thanks
-- PMM
