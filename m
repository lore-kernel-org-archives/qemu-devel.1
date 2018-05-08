Received: from eggs.gnu.org ([2001:4830:134:3::10]:41780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dunlapg@gmail.com>) id 1fG4qE-0006sL-Qf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dunlapg@gmail.com>) id 1fG4qE-000114-1d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:47:50 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:40650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dunlapg@gmail.com>) id 1fG4qD-00010q-QR
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:47:49 -0400
Received: by mail-qt0-x230.google.com with SMTP id h2-v6so41632931qtp.7
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:47:49 -0700 (PDT)
MIME-Version: 1.0
Sender: dunlapg@gmail.com
In-Reply-To: <20180508151026.GA5967@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504210001.GB30250@redhat.com>
	<CAFLBxZYO7Yeje8HROjJY9P=9bEQ8RCBhA9fqbGTXN_87U5sowA@mail.gmail.com>
	<20180508151026.GA5967@redhat.com>
From: George Dunlap <dunlapg@umich.edu>
Date: Tue, 8 May 2018 16:47:48 +0100
Message-ID: <CAFLBxZbsSPW1E7GAVPmQ8AnmQCqs16qx4r3Cq2q+sFsn48NYLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 0/3] Document intent for
 supported build platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel <xen-devel@lists.xenproject.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>, Anthony Perard <anthony.perard@citrix.com>

On Tue, May 8, 2018 at 4:10 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>> With my Xen maintainer hat on: I wouldn't feel justified, personally,
>> in asking another project to continue supporting older versions.  If
>> we didn't want to bump our own glib version, we would have to disable
>> "upstream" QEMU (as opposed to Xen's old qemu fork) for older versions
>> of glib.
>
> Or could you say that people need to use a stable version of QEMU ?
> eg users wanting Xen on RHEL-6, can use "upstream" QEMU, but they'll
> need to stick with the 2.12 stable branch version - not use git master
> or future releases. I guess it depends whether you can expect 2.12
> QEMU to carry on working correctly with ongoing Xen changes.

Yes, that's a good point.  In theory older versions of QEMU should in
theory continue working with newer versions of Xen.

Two points about that solution:

1. Our release tarball currently ships with a snapshotted version of a
specific version of QEMU, and if you check out a release tag in our
git repo it will by default clone a specific version of qemu for you.
Users / downstreams would have to disable that and clone their own
version.

2. While in theory all versions should continue to work, in practice
our testing system and the majority of our downstreams use the version
specified by the release, even when they build QEMU separately.  (I
think Debian may be an exception to this rule but I'm not sure.)
Using an older version of QEMU does mean going "off the beaten track"
a bit, increasing slightly the chance of random bugs.

Anyway, from what I can tell, your decision sounds entirely
reasonable, and users and downstreams who don't want to / can't update
glib have a number of options, so I personally don't see any grounds
for objecting or complaining.  Thanks again for the heads-up.

 -George
