Received: from eggs.gnu.org ([2001:4830:134:3::10]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnylk-0003iF-3r
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnylj-0000RS-9j
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:34:32 -0400
MIME-Version: 1.0
In-Reply-To: <12d49a77-0a1d-6488-5652-2c09643a7b05@redhat.com>
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
	<420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
	<12d49a77-0a1d-6488-5652-2c09643a7b05@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 15 Mar 2017 10:34:28 +0800
Message-ID: <CAOGPPbe=SGfQRTHCyLGfuXFJaon=JXgpgk4pbO8Ui5R6Q1aiEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] migration/block: Avoid involve into
 blk_drain too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, Mar 14, 2017 at 11:15 PM, Eric Blake <eblake@redhat.com> wrote:
>
> On 03/14/2017 10:12 AM, Eric Blake wrote:
> > On 03/14/2017 02:57 AM, jemmy858585@gmail.com wrote:
> >> From: Lidong Chen <jemmy858585@gmail.com>
> >>
> >> Increase bmds->cur_dirty after submit io, so reduce the frequency involve into blk_drain, and improve the performance obviously when block migration.
> >
> > Long line; please wrap your commit messages, preferably around 70 bytes
> > since 'git log' displays them indented, and it is still nice to read
> > them in an 80-column window.
>
> Also, in the subject:
>
> s/involve into/invoking/

thanks for you suggestion.
this is the first time i commit a patch for qemu, i will send a new version.

>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
