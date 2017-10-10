Received: from eggs.gnu.org ([2001:4830:134:3::10]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1tu1-0001Ah-BW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1tty-0007K5-P8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e1tty-0007Jl-Ig
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:44:50 -0400
Date: Tue, 10 Oct 2017 14:44:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171010144447.5cadff7f@nial.brq.redhat.com>
In-Reply-To: <CADak6y7ZKX5oJv+oqFG1Kz2_mVArsnM18mw3uqAd3ei-s3JYVw@mail.gmail.com>
References: <CADak6y7ZKX5oJv+oqFG1Kz2_mVArsnM18mw3uqAd3ei-s3JYVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] hot plug cpu report error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>
Cc: qemu-devel@nongnu.org

On Mon, 9 Oct 2017 20:21:12 +0800
Paul Schlacter <wlfightup@gmail.com> wrote:

> report error:
> 
> intel_rapl: no valid rapl domains found in package 0
> 
> intel_rapl: no valid rapl domains found in package 0
> 
> 
> and then will shutdown after in a moment of time
> 
> 
> qemu log :
> 
> qemu: qemu_mutex_lock: Invalid argument
> 2017-10-09 09:27:34.781+0000: shutting down, reason=crashed
> 
> 
> Find a solution
that's not enough information to even guess,
please provide exact steps to reproduce issue including
used versions (qemu, kernel(host|guest)), qemu command line,
console logs
