Received: from eggs.gnu.org ([2001:4830:134:3::10]:35602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cH7pw-0000B4-SU
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cH7pt-0003qp-RW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:35:04 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cH7pt-0003qI-Ku
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 06:35:01 -0500
Received: by mail-vk0-f44.google.com with SMTP id 137so23492522vkl.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 03:35:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgviiwn0.fsf@dusky.pond.sub.org>
References: <1481706465-5636-1-git-send-email-thuth@redhat.com>
	<87lgviiwn0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 11:33:40 +0000
Message-ID: <CAFEAcA9dOJPnwVy41ZMf4boPQ=VDz6R7P=jWa0ki6-anGedMdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Jia Liu <proljc@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Anthony Green <green@moxielogic.com>, Marcelo Tosatti <mtosatti@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 14 December 2016 at 11:21, Markus Armbruster <armbru@redhat.com> wrote:
> Thomas Huth <thuth@redhat.com> writes:
>
>> We've currently got 18 architectures in QEMU, and thus 18 target-xxx
>> folders in the root folder of the QEMU source tree. More architectures
>> (e.g. RISC-V, AVR) are likely to be included soon, too, so the main
>> folder of the QEMU sources slowly gets quite overcrowded with the
>> target-xxx folders.
>> To disburden the main folder a little bit, let's move the target-xxx
>> folders into a dedicated target/ folder, so that target-xxx/ simply
>> becomes target/xxx/ instead.
>
> The root directory is crowded, but hardly because of its 18 target-*
> entries:
>
>     $ git-ls-tree --name-only v2.8.0-rc3 | wc -l
>     167
>
> Getting the 18 target-* out of the way would help a little, but I hate
> making the directory tree deeper.
>
> We have 110 files in the root directory.  Moving some of them to
> subdirectories looks more promising to me.

True, but Thomas has done the work here already, so I don't think
we lose anything by merging it rather than throwing it away.

(My gut feeling here is "meh", but that was also how I felt about
Paolo's rearrangement of everything into subdirectories of hw/,
and in hindsight that was clearly the right thing. So I'm assuming
my gut is wrong here too.)

thanks
-- PMM
