Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7eOI-0005EM-QM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7eOF-0007l3-P2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:51:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d7eOF-0007kw-J6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:51:35 -0400
Date: Mon, 8 May 2017 09:51:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170508085130.GD2446@work-vm>
References: <CAGKXQyfu6_wHmXiJZ2_19BpCkGJ60twdHQ74MV9=up7v-co1Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGKXQyfu6_wHmXiJZ2_19BpCkGJ60twdHQ74MV9=up7v-co1Jg@mail.gmail.com>
Subject: Re: [Qemu-devel] vmstate_save_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org

* ali saeedi (ali.saeedi56@gmail.com) wrote:
> what does "vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0=
)"
> function call do in "qemu_savevm_state_header" function in savevm.c at li=
ne
> 968 ?
> why has "savevm_state" been passed to this function?
> thanks a lot

vmstate_save_state serialises a data structure to the migration stream
using a description.  In this case it's saving some of the data in
'savevm_state' using 'vmstate_configuration'.  If you follow
the two you can see that 'savevm_state' is of type 'SaveState'.
If you look at 'vmstate_configuration' it defines that two fields
=66rom that strcture are saved 'len' and 'name' and also the
target_page_bits fields.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
