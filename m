Received: from eggs.gnu.org ([2001:4830:134:3::10]:59340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyg8h-0002XR-1U
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyg8d-00040X-3a
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:58:59 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyg8c-000402-TM
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:58:55 -0400
Received: by mail-wr0-f176.google.com with SMTP id z73so5722461wrb.0
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:58:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6228d029-e799-8aa4-e5f5-68d58fa3268a@redhat.com>
Date: Wed, 21 Mar 2018 16:58:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PSA] changelog and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alex Williamson <alex.williamson@redhat.com>, Daniel Berrange <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Corey Minyard <minyard@acm.org>, Jeff Cody <jcody@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, "Jason Wang (jasowang@redhat.com)" <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@gnu.org>, Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

Hi all!

If you are receiving this email, you have sent a pull request for QEMU
2.12!  That's awesome, and some of you have also updated the ChangeLog
for the upcoming release, which is doubly awesome!  I'm sure Santa will
put you on the nice list and you can stop reading this email. :)

Even if you haven't updated the ChangeLog, don't worry, I have done it
for you.  Please double check because QEMU is too big for one person to
understand all the changes that were made.

Some of you have spent time throughout the release to write nice
messages for the pull requests.  That's very good too, and hopefully
that has helped me and the ChangeLog entries for your subsystems are
already acceptable.

Whoever remains, you have tagged your updates with messages like "xxx
pull request".  Please don't do this, and please do double check the
2.12 page on the wiki because chances are that I have missed or
misunderstood something (no maintainer with poor tag messages has
updated the ChangeLog[1]).

Please, please think of the poor person who has spent about one hour
collecting all your changes, and use 2 minutes after typing "git tag",
while compiling the code one last time, to put together a short
description of what is happening (especially features and user-visible
hanges) in your pull request.

To put it clearly: all that should be needed in order to write the 2.13
ChangeLog should be "git log --merges --reverse v2.12.0..", and that's
exactly what I'll do three months from now: if you don't write good
messages for your tags, you'll have to write the ChangeLog for your
subsystems yourself.

Thanks,

Paolo

[1] If you did update the ChangeLog, you were supposed to stop reading,
weren't you?
