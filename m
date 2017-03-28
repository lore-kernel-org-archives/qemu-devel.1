Received: from eggs.gnu.org ([2001:4830:134:3::10]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1csqW3-0001IT-G6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1csqVz-0008Ce-BE
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1csqVz-0008CJ-50
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:46:23 -0400
Date: Tue, 28 Mar 2017 14:46:19 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20170328124619.GI2455793@orkuz.home>
References: <20170327144815.8043-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327144815.8043-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 0/2] i386: Don't override -cpu
 options on -cpu host/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Collin L . Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On Mon, Mar 27, 2017 at 11:48:13 -0300, Eduardo Habkost wrote:
> The existing code for "host" and "max" CPU models overrides every
> single feature in the CPU object at realize time, even the ones
> that were explicitly enabled or disabled by the user using
> "feat=on" or "feat=off", while features set using +feat/-feat are
> kept.
> 
> This means "-cpu host,+invtsc" works as expected, while
> "-cpu host,invtsc=on" doesn't.
> 
> This was a known bug, already documented in a comment inside
> x86_cpu_expand_features(). What makes this bug worse now is that
> libvirt 3.0.0 and newer now use "feat=on|off" instead of
> +feat/-feat when it detects a QEMU version that supports it (see
> libvirt commit d47db7b16dd5422c7e487c8c8ee5b181a2f9cd66).
> 
> This series fixes the bug.

Thanks.

Tested-by: Jiri Denemark <jdenemar@redhat.com>

Jirka
