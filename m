Received: from eggs.gnu.org ([2001:4830:134:3::10]:54316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3GgY-0001qB-UU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3GgU-0000qu-0t
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3GgT-0000qY-O2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:44:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
	<alpine.DEB.2.10.1704241423030.16723@sstabellini-ThinkPad-X260>
	<CAFEAcA8CWYCxVauuWSsmuQw4YG1O0DO+rYASm2aVhirp3Z3mZA@mail.gmail.com>
	<alpine.DEB.2.10.1704241640160.16723@sstabellini-ThinkPad-X260>
	<871sshaqp8.fsf@dusky.pond.sub.org>
	<alpine.DEB.2.10.1704251014320.2875@sstabellini-ThinkPad-X260>
Date: Wed, 26 Apr 2017 08:44:11 +0200
In-Reply-To: <alpine.DEB.2.10.1704251014320.2875@sstabellini-ThinkPad-X260>
	(Stefano Stabellini's message of "Tue, 25 Apr 2017 10:18:24 -0700
	(PDT)")
Message-ID: <87inlr4qis.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-tag for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Stefano Stabellini <sstabellini@kernel.org> writes:

> On Tue, 25 Apr 2017, Markus Armbruster wrote:
>> Stefano Stabellini <sstabellini@kernel.org> writes:
[...]
>> > diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
>> > new file mode 100644
>> > index 0000000..6e33d77
>> > --- /dev/null
>> > +++ b/hw/9pfs/xen-9pfs.h
>> > @@ -0,0 +1,21 @@
>> > +/*
>> > + * Xen 9p backend
>> > + *
>> > + * Copyright Aporeto 2017
>> > + *
>> > + * Authors:
>> > + *  Stefano Stabellini <stefano@aporeto.com>
>> > + *
>> > + * This work is licensed under the terms of the GNU GPL version 2.
>> 
>> Any particular reason for "version 2" instead of "version 2 or later"?
>
> Habit: both Linux and Xen are v2 only. I didn't realize that QEMU is "or
> later". Also, personally I don't like the "or later" clause for a number
> of reasons that is best not to discuss in this thread :-)
>
> But I'll go with whatever is easier for the project. I'll add "or later"
> and merge this change into patch #12.

Yes, please.  Quoting LICENSE:

    The following points clarify the QEMU license:

    1) QEMU as a whole is released under the GNU General Public License,
    version 2.

    2) Parts of QEMU have specific licenses which are compatible with the
    GNU General Public License, version 2. Hence each source file contains
    its own licensing information.  Source files with no licensing information
    are released under the GNU General Public License, version 2 or (at your
    option) any later version.

--> As of July 2013, contributions under version 2 of the GNU General Public
--> License (and no later version) are only accepted for the following files
--> or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.

    3) The Tiny Code Generator (TCG) is released under the BSD license
       (see license headers in files).

    4) QEMU is a trademark of Fabrice Bellard.

    Fabrice Bellard and the QEMU team
