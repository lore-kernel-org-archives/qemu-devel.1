Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHbXV-0001N0-5O
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHbXQ-0007vG-DV
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:18:01 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHbXQ-0007iA-0I
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:17:56 -0500
Received: by mail-vk0-f46.google.com with SMTP id x186so77269940vkd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 11:17:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161215190355.GA16467@work-vm>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<20161215175533-mutt-send-email-mst@kernel.org>
	<20161215160740.GN2509@work-vm>
	<20161215205122-mutt-send-email-mst@kernel.org>
	<20161215190355.GA16467@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Dec 2016 19:16:12 +0000
Message-ID: <CAFEAcA8XtikQ54QN1dgCFjwntc==FxRnUH17Hh+NWdJc0aNWMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/3] Introduce a new --only-migratable
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 December 2016 at 19:03, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> One thing we'd have to do if we did that would be to
> add another flag to devices to declare that they might
> sometime in the future call the migrate_add_blocker.

...do you have a third-party library to suggest for
the "foretell the future" functionality necessary
for devices to implement this correctly? :-)

thanks
-- PMM
