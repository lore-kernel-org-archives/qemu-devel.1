Received: from eggs.gnu.org ([2001:4830:134:3::10]:40052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1eAKCZ-00031F-CN
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1eAKCX-0006dd-SN
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:26:50 -0400
MIME-Version: 1.0
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
	<20171027093600.GA29513@kos.to>
	<CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
	<CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
	<2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
In-Reply-To: <2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
From: Zach Riggle <zachriggle@gmail.com>
Date: Thu, 02 Nov 2017 18:26:35 +0000
Message-ID: <CAMP9c5=3rpH_84w8sRNhdRufnu7sisiyu_U0Bz+cyqdpP=C2_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Ping. What changes do I need to make to land this?
On Sat, Oct 28, 2017 at 12:49 AM Eric Blake <eblake@redhat.com> wrote:

> On 10/27/2017 09:07 PM, Zach Riggle wrote:
> > Another case that may be more relevant for general QEMU use, is that the
> > current code fails if the software under test has poor path-handling
> code.
> > For example, any of
> >
> > - //proc/self/maps
> > - /proc//self/maps
> > - /proc/self//maps
> >
> > Will all return the non-emulated results.  Those examples are just path
> > canonicalization issues and could be resolved with e.g.
> > canonicalize_file_name, but I'm not sure if QEMU allows GNU extensions --
> > and realpath() is portable.
>
> By definition, in linux-user, we ARE using glibc; therefore, you are
> free to use all GNU extensions.
>
> And you'd be surprised at how many non-glibc implementations of
> realpath() are not POSIX-compliant, even though that is not relevant here.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
