Received: from eggs.gnu.org ([2001:4830:134:3::10]:59983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLQY-0005Lv-ME
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLQX-00031W-QT
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:04:02 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQLQX-00030q-H3
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:04:01 -0500
Date: Fri, 23 Nov 2018 19:03:59 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181124000359.GC17229@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-22-cota@braap.org>
	<87o9afhgir.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9afhgir.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 21/48] *-user: plugin syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Fri, Nov 23, 2018 at 17:04:28 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  bsd-user/syscall.c   | 9 +++++++++
> >  linux-user/syscall.c | 3 +++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> > index b7818af450..4993f81b2b 100644
> > --- a/bsd-user/syscall.c
> > +++ b/bsd-user/syscall.c
> > @@ -323,6 +323,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
> >      gemu_log("freebsd syscall %d\n", num);
> >  #endif
> >      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
> > +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
> > +                             arg8);
> 
> I think we discussed this on my series about avoiding this sort of
> duplication by providing a wrapper for trace points that are also plugin
> hooks. So something like:
> 
>        trace_and_plugin_guest_user_syscall(...)
> 
> Although it's probably worth keeping the trace names grep-able so maybe:
> 
>        plug_trace_guest_user_syscall(...)
> 
> ?

Yes, I remember that discussion and agree that a common function here
would be best.

		Emilio
