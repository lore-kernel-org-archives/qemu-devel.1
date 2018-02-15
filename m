Received: from eggs.gnu.org ([2001:4830:134:3::10]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1emMlB-0008F8-MK
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1emMl9-0005uI-5I
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:51:49 -0500
Date: Thu, 15 Feb 2018 17:51:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180215175125.5e773857.cohuck@redhat.com>
In-Reply-To: <20180215103822.15179-1-david@redhat.com>
References: <20180215103822.15179-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/tcg: add various alignment checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Thu, 15 Feb 2018 11:38:22 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's add proper alignment checks for a handful of instructions that
> require a SPECIFICATION exception in case alignment is violated.
> 
> Introduce new wout/in functions. As we are right now only using them for
> privileged instructions, we have to add ugly ifdefs to silence
> compilers.
> 
> Convert STORE CPU ID right away to make use of the wout function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 16 ++++++++--------
>  target/s390x/mem_helper.c  | 25 +++++++++++++++++++++++++
>  target/s390x/translate.c   | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 75 insertions(+), 9 deletions(-)

Thanks, applied.
