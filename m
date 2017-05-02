Received: from eggs.gnu.org ([2001:4830:134:3::10]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d5ZNU-00083P-Nt
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d5ZNR-0007La-8Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:06:12 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d5ZNR-0007Kk-2l
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:06:09 -0400
Received: by mail-pg0-x244.google.com with SMTP id v1so22860448pgv.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 08:06:08 -0700 (PDT)
Date: Wed, 3 May 2017 00:05:59 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170502150559.GG2724@lianli.shorne-pla.net>
References: <cover.1493593744.git.shorne@gmail.com>
	<20170502142017.GI22502@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502142017.GI22502@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PULL 00/11] Fixes and features for OpenRISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: peter.maydell@linaro.org, QEMU Development <qemu-devel@nongnu.org>

On Tue, May 02, 2017 at 03:20:17PM +0100, Stefan Hajnoczi wrote:
> On Mon, May 01, 2017 at 08:14:14AM +0900, Stafford Horne wrote:
> > This are the openrisc patches I have been circulating on the mailing list
> > of the last few months.  We have had help from a few new people and added
> > the following:
> >  * Fixes for gdb memory debugging
> >  * Added support for Shadow Registers, EVBAR, EPH
> >  * Added support for idle state, no more 100% pegged cpu's
> >  * Fixed VM state persisting
> > 
> > Please consider for pull.
> 
> Hi Stafford,
> I'm handling qemu.git pull requests while Peter Maydell is away in May.
> 
> Please take a look at the checkpatch.pl errors that the patchew
> continuous integration system found (there is an email reply to this
> thread).  Thanks!

Hello Stefan,

Is there one that you think is particulary important?  I had a look through
them before submitting these patches but I thought these were ok.

Example errors:
  - include/migration/vmstate.h
   * line over 90 characters
   * space required around '|'

If you look at the file these are consistent with the rest of the file.
Which I thought is more important usually.

-Stafford
