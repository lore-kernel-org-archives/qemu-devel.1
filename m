Received: from eggs.gnu.org ([2001:4830:134:3::10]:51680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnJB5-0006Ai-HC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnJB2-0005y2-FT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnJB2-0005xc-8k
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:42:08 -0400
Date: Thu, 31 Aug 2017 08:42:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831084200.359bd5c7.cohuck@redhat.com>
In-Reply-To: <8a7e8d96-0d32-97cd-0e5a-335aff4d9d39@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-9-david@redhat.com>
	<8a7e8d96-0d32-97cd-0e5a-335aff4d9d39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/11] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On Wed, 30 Aug 2017 21:06:55 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 30.08.2017 19:05, David Hildenbrand wrote:
> > Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
> > guest tries to bring these CPUs up but fails), because we don't support
> > multiple CPUs on s390x under TCG.
> > 
> > Let's bail out if more than 1 are specified, so we don't raise people's
> > hope.  
> 
> Aurelien recently posted a patch to add that basic SIGP support:
> 
>  https://patchwork.kernel.org/patch/9717489/
> 
> I think it would make more sense to get that included instead.

I'd look at it if it were reposted :)
