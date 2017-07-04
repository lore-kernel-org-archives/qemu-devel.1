Received: from eggs.gnu.org ([2001:4830:134:3::10]:35116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSKGh-0003T9-DB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSKGd-0000aj-Ic
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSKGd-0000aZ-Bs
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:37:11 -0400
Date: Tue, 4 Jul 2017 10:37:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704093705.GF3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-5-git-send-email-pbonzini@redhat.com>
	<1cfd6e25-727e-2b11-b662-4a2b7dbaed05@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cfd6e25-727e-2b11-b662-4a2b7dbaed05@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 04/22] vl: convert -tb-size to qemu_strtoul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On Mon, Jul 03, 2017 at 12:46:06PM -0700, Richard Henderson wrote:
> On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> > -extern int tcg_tb_size;
> > +extern unsigned long tcg_tb_size;
> 
> size_t would be more natural.
> 
> I don't think we support any hosts for which sizeof(size_t) !=
> sizeof(unsigned long), but perhaps
> 
> 	unsigned lomg tmp;
> 	if (qemu_strtoul(optarg, NULL, 0, &tmp) < 0
>             || tmp != (size_t)tmp) {
> 	  error_report("Invalid argument to -tb-size");
> 	  exit(1);
> 	}
> 	tcg_tb_size = tmp;
> 
> where I'd expect the extra comparison to be optimized away.

If we wanted to use size_t, then I'd suggest we added a qemu_strtoXXX
variant that directly returned a size_t, and did suitabled bounds
checking

> But I'm not overly concerned either way, so

Agreed, doesn't need fixing now

> Reviewed-by: Richard Henderson <rth@twiddle.net>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
