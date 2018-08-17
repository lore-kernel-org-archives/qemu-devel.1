Received: from eggs.gnu.org ([2001:4830:134:3::10]:43320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqcHk-0004cl-Ng
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqcHg-0000Aw-4E
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:47:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqcHf-0000AV-Vo
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:47:12 -0400
Date: Fri, 17 Aug 2018 11:47:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817104706.GH11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
Subject: Re: [Qemu-devel] vm-tests images disks filling up?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On Fri, Aug 17, 2018 at 11:26:39AM +0100, Peter Maydell wrote:
> I just ran into a build failure using the tests/vm/ BSD build tests,
> because the NetBSD build image's disk filled up.
> 
> Looking more closely there seemed to be 9 stale build trees in
> the VM's /var/tmp/qemu-test.* , which is why the disk was full
> (they'd used up about 18GB between them).
> 
> The other VMs (freebsd, openbsd) also had the same problem of
> /var/tmp gradually filling with stale trees, they just hadn't
> quite run out of space yet...
> 
> What's the process for managing the disk space on these images?
> How are stale or completed build trees deleted ?

I'd prefer to see the test process honouring the build directory instead
of putting stuff in /var/tmp, so that a developer's normal approach to
cleaning up build artifacts works.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
