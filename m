Received: from eggs.gnu.org ([2001:4830:134:3::10]:39608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX3ET-0007QC-TI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX3EG-0005Gi-BI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX3EG-0005GO-5X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:26:16 -0400
Date: Mon, 17 Jul 2017 11:26:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717102607.GI3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
	<CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
	<20170717093944.GA18516@lemon>
	<CAFEAcA-hzAq=fP6Pndre3b4truxJFV3go0C91d702pMsLGZRrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-hzAq=fP6Pndre3b4truxJFV3go0C91d702pMsLGZRrg@mail.gmail.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:06:12AM +0100, Peter Maydell wrote:
> On 17 July 2017 at 10:39, Fam Zheng <famz@redhat.com> wrote:
> > On Mon, 07/17 10:28, Peter Maydell wrote:
> >> Ideally we'd streamline our make process to not produce so much
> >> irrelevant output :-)
> >
> > Does that mean to make "quite-command" absolutely quiet if V=1 is not specified?
> 
> The current 'quiet' mode is not quite aimed at the same purpose:
> it's good for interactive use where you don't want the long detail
> of command lines but you do want some periodic indication of
> progress through the compile. For entirely noninteractive
> setups like travis and patchew there's no need to produce
> what is in effect a rather verbose progress bar...

For unattended automated systems though, I think running with V=1 is
preferrable to quiet mode. When you don't have direct access to the
test system to reproduce systems, every bit of information that you
can get from the logs is potentially useful, including full compiler
args. The flipside is that in other cases the verbose output can
obscure the error messages you are after - depends what your're trying
to debug - code problems vs build system problems.

Perhaps it would be best to extract stderr separately. ie run with V=1
and have a full log that contains stdout+stderr as normal, but have a
second log which only contains stderr contents to make it easier to
see the error / warning messages in isolation from the "noise".


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
