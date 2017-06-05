Received: from eggs.gnu.org ([2001:4830:134:3::10]:42660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHvvJ-0005zv-19
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHvvF-0001HD-UN
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:36:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHvvF-0001H2-Nv
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:36:09 -0400
Date: Mon, 5 Jun 2017 14:36:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170605173605.GO4294@thinpad.lan.raisama.net>
References: <20170605155655.19315-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605155655.19315-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: Use "min-[x]level" on compat_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

On Mon, Jun 05, 2017 at 12:56:55PM -0300, Eduardo Habkost wrote:
> Since the automatic cpuid-level code was introduced in commit
> c39c0edf9bb3b968ba95484465a50c7b19f4aa3a, the CPU model tables just
> define the default CPUID level code (set using "min-level").  Setting
> "[x]level" forces CPUID level to a specific value and disable the
> automatic-level logic.
> 
> But the PC compat code was not updated and the existing "[x]level"
> compat properties broke compatibility for people using features that
> triggered the auto-level code.  To keep previous behavior, we should set
> "min-[x]level" instead of "[x]level" on compat_props.
> 
> This was not a problem for most cases, because old machine-types don't
> have full-cpuid-auto-level enabled.  The only common use case it broke
> was the CPUID[7] auto-level code, that was already enabled since the
> first CPUID[7] feature was introduced (in QEMU 1.4.0).
> 
> This causes the regression reported at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1454641
> 
> Change the PC compat code to use "min-[x]level" instead of "[x]level" on
> compat_props, and add new test cases to ensure we don't break this
> again.
> 
> Reported-by: "Guo, Zhiyi" <zhguo@redhat.com>
> Signd-off-by: Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
