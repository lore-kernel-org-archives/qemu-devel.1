Received: from eggs.gnu.org ([2001:4830:134:3::10]:60368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHHDG-0001uY-Ka
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHHDD-0006W0-I0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:35:46 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:48046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHHDD-0006UY-7W
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:35:43 -0500
Date: Wed, 14 Dec 2016 16:34:55 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1444801967.4064897.1481751295720.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161214175546.GO3808@thinpad.lan.raisama.net>
References: <1481706465-5636-1-git-send-email-thuth@redhat.com>
	<87lgviiwn0.fsf@dusky.pond.sub.org>
	<CAFEAcA9dOJPnwVy41ZMf4boPQ=VDz6R7P=jWa0ki6-anGedMdA@mail.gmail.com>
	<50196ce3-9320-da14-07d2-867e09ffdcfc@redhat.com>
	<87shpqcwyz.fsf@dusky.pond.sub.org>
	<8ca18f15-e2f6-965e-6eaa-7b935c83d9c4@redhat.com>
	<20161214175546.GO3808@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jia Liu <proljc@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>


> I was considering moving xen-* and kvm-* to xen/ and kvm/
> directories, but an accel/ directory would be even better. I plan
> to send a patch to do this:
> 
> tcg/    => accel/tcg/
> kvm-*   => accel/kvm/*  (except for stubs)
> xen-*   => accel/xen/*  (except for stubs)
> qtest.c => accel/qtest/qtest.c

I'm not sure if tcg/ should move to accel/tcg.  I was thinking of QEMU
runtime files like cpu-exec*, translate*, user-exec.c and cputlb.c.
IMO there's value in leaving the code generator separated from the
QEMU-specific stuff.  I'm also not too enthusiastic about making
accel/kvm and accel/xen for respectively one and three files. :)
So maybe accel/ with accel/tcg/ inside would be enough.

(Also, tcg-runtime.c and tci.c should move to tcg/).

BTW, you can certainly move stubs to subdirectories.  These are
all per-target files, so you can just leave

    obj-y += accel/

in Makefile.target and move the obj-$(...) assignments to the
accel/Makefile.objs file.

Paolo
