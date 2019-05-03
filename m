Received: from eggs.gnu.org ([209.51.188.92]:49997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hMT67-0006RS-Fa
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hMT66-0007hE-Bn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1hMT66-0007ei-6a
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C45C681E00
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 07:59:07 +0000 (UTC)
Date: Fri, 3 May 2019 08:59:04 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190503075904.GT3926@redhat.com>
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502180201.GA31376@paraplu>
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, nmav@redhat.com, lersek@redhat.com, armbru@redhat.com

On Thu, May 02, 2019 at 08:02:01PM +0200, Kashyap Chamarthy wrote:
> [Reviving this old thread as I don't think we came to a conclusion on
> this.]

I guess the best thing is to submit the obvious 1 line patch and see
what people think about it?  (I agree the default ought to be changed.)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
