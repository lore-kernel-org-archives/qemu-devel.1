Received: from eggs.gnu.org ([2001:4830:134:3::10]:52070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQzI0-0000Ek-Bw
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQzHx-00045a-8u
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQzHx-00045K-34
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:28:45 -0500
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170109234446-mutt-send-email-mst@kernel.org>
	<87bmvftejz.fsf@dusky.pond.sub.org>
	<20170110162151-mutt-send-email-mst@kernel.org>
	<87pojuc2h0.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97975bbd-2883-974a-7b18-91e347ec3436@redhat.com>
Date: Tue, 10 Jan 2017 17:28:40 +0100
MIME-Version: 1.0
In-Reply-To: <87pojuc2h0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 10/01/2017 17:19, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> Generally this patchset is at v7.  It brings a very limited benefit to
>> the project.  It better be perfect otherwise I don't see why bother.
>=20
> We obviously disagree on the benefit.  Before this series, error
> reporting is *broken* for QMP.  Fixing that is definitely not "why
> bother" material.
>=20
> I certainly don't object to tightening our testing habits.  I was merel=
y
> pointing out that you're doing that.
>=20
> Testing patches that modernize interfaces often isn't easy for the
> person doing the work.  Fortunately, megasas has a maintainer: Hannes.
> Who gave his R-by.  For me, that would suffice, but you may see things
> differently.  Would a Tested-by from him satisfy you?  If not, what
> would satisfy you?

As a co-maintainer (via hw/scsi/" of megasas) I think that the only
satisfactory testing, for merging hw/scsi patches *through a tree other
than mine*, is "this installs Linux for a distro of the submitter's
choice", and "the commit message explains the differences clearly with
sample invocations of QEMU".

Installing Linux seems like a higher bar than usual, but it only takes a
few minutes to start such an install.  I'll even accept "it formats the
disk fine".

Sure, I don't even apply it to all of my patches.  But I'm the sole
responsible for my screwups and the community knows that I'll be there
to fix them so they accept it.  A random patch submitter is going to
waste time of multiple maintainers if they don't do proper testing, and
I think it's fair given that some previous submitted versions didn't
even compile.

Paolo
