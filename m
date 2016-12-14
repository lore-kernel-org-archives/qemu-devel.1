Received: from eggs.gnu.org ([2001:4830:134:3::10]:60965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cH7d8-0002Hs-3v
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cH7d3-0008Bl-82
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:21:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cH7d3-0008BQ-1e
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:21:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481706465-5636-1-git-send-email-thuth@redhat.com>
Date: Wed, 14 Dec 2016 12:21:39 +0100
In-Reply-To: <1481706465-5636-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 14 Dec 2016 10:07:45 +0100")
Message-ID: <87lgviiwn0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] Move target-* CPU file into a
 target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Jia Liu <proljc@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Anthony Green <green@moxielogic.com>, Marcelo Tosatti <mtosatti@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Thomas Huth <thuth@redhat.com> writes:

> We've currently got 18 architectures in QEMU, and thus 18 target-xxx
> folders in the root folder of the QEMU source tree. More architectures
> (e.g. RISC-V, AVR) are likely to be included soon, too, so the main
> folder of the QEMU sources slowly gets quite overcrowded with the
> target-xxx folders.
> To disburden the main folder a little bit, let's move the target-xxx
> folders into a dedicated target/ folder, so that target-xxx/ simply
> becomes target/xxx/ instead.

The root directory is crowded, but hardly because of its 18 target-*
entries:

    $ git-ls-tree --name-only v2.8.0-rc3 | wc -l
    167

Getting the 18 target-* out of the way would help a little, but I hate
making the directory tree deeper.

We have 110 files in the root directory.  Moving some of them to
subdirectories looks more promising to me.
