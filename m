Received: from eggs.gnu.org ([2001:4830:134:3::10]:42179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eFOSW-0008W8-6R
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eFOSP-0002yd-Vw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:00:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eFOSP-0002ua-NI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:00:09 -0500
Date: Thu, 16 Nov 2017 16:00:03 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171116180003.GO3111@localhost.localdomain>
References: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
	<aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] hax-interface: Add BSD license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: yu.ning@linux.intel.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yu Ning <yu.ning@intel.com>, Richard Henderson <rth@twiddle.net>, Vincent Palatin <vpalatin@chromium.org>

On Thu, Nov 16, 2017 at 07:47:44AM +0100, Stefan Weil wrote:
> Am 16.11.2017 um 07:50 schrieb yu.ning@linux.intel.com:
> > From: Yu Ning <yu.ning@intel.com>
> > 
> > hax-interface.h defines the interface between the HAXM kernel
> > module and the HAXM QEMU accelerator. The same code can be found in
> > the following files of the HAXM kernel module:
> > 
> >  include/hax_interface.h
> >  include/vcpu_state.h
> >  core/include/vm.h
> > 
> > These files are now open source under the 3-clause BSD license,
> > whereas hax-interface.h in QEMU uses GPLv2.

Why is this a problem?


> > 
> > Address this inconsistency by adding the BSD license to the QEMU
> > file, per Stefan Weil's comment on this HAXM pull request:
> > 
> >  https://github.com/intel/haxm/pull/2

The existing code on qemu.git don't match the code on the GitHub
repository above exactly, and its copyright history looks hard to
track[1].  If we really care about consistency between the two
projects, shouldn't we just delete the existing file and copy the
headers from github.com/intel/haxm directly?


[1] https://github.com/qemu/qemu/commit/47c1c8c12f6c8b3c6e0da7bbd93fd4e1724cf114
    https://android.googlesource.com/platform/external/qemu-android/+/2b3098ff27bab079caab9b46b58546b5036f5c0c/target-i386/hax-interface.h

Also, does it even make sense to keep the two licenses in the
file?


> > 
> > Signed-off-by: Yu Ning <yu.ning@intel.com>
> > ---
> >  target/i386/hax-interface.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
> > index d141308..9a36c9a 100644
> > --- a/target/i386/hax-interface.h
> > +++ b/target/i386/hax-interface.h
> > @@ -1,4 +1,33 @@
> >  /*
> > + * Copyright (c) 2011 Intel Corporation
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions are met:
> > + *
> > + *   1. Redistributions of source code must retain the above copyright notice,
> > + *      this list of conditions and the following disclaimer.
> > + *
> > + *   2. Redistributions in binary form must reproduce the above copyright
> > + *      notice, this list of conditions and the following disclaimer in the
> > + *      documentation and/or other materials provided with the distribution.
> > + *
> > + *   3. Neither the name of the copyright holder nor the names of its
> > + *      contributors may be used to endorse or promote products derived from
> > + *      this software without specific prior written permission.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> > + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> > + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> > + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
> > + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> > + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> > + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> > + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> > + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> > + * POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +/*
> >   * QEMU HAXM support
> >   *
> >   * Copyright (c) 2011 Intel Corporation
> > 
> 
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> 
> CC'ing Vincent who added the file to the QEMU code base.
> 
> Maybe the two licenses in the header could be re-arranged when merging
> that commit.

-- 
Eduardo
