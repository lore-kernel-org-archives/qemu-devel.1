Received: from eggs.gnu.org ([209.51.188.92]:48037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hM7CP-0004aM-RA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hM7CK-0003qy-SA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hM7CG-0003in-JY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:36:05 -0400
Date: Thu, 2 May 2019 09:35:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190502083550.GA2853@work-vm>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
	<155677104475.10667.17544832182226944733@c2072b67cc0c>
	<20190502053207.ix637eb6v7umujas@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502053207.ix637eb6v7umujas@master>
Subject: Re: [Qemu-devel] [PATCH 0/3] Cleanup migration/ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, fam@euphon.net, quintela@redhat.com, pbonzini@redhat.com

* Wei Yang (richard.weiyang@gmail.com) wrote:
> On Wed, May 01, 2019 at 09:24:06PM -0700, no-reply@patchew.org wrote:
> >Patchew URL: https://patchew.org/QEMU/20190430034412.12935-1-richardw.yang@linux.intel.com/
> >
> >
> >
> >Hi,
> >
> >This series failed the asan build test. Please find the testing commands and
> >their output below. If you have Docker installed, you can probably reproduce it
> >locally.
> >
> >=== TEST SCRIPT BEGIN ===
> >#!/bin/bash
> >time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> >=== TEST SCRIPT END ===
> >
> >  COPY    RUNNER
> >    RUN test-debug in qemu:fedora 
> >container_linux.go:247: starting container process caused "process_linux.go:258: applying cgroup configuration for process caused \"The maximum number of active connections for UID 0 has been reached\""
> >/usr/bin/docker-current: Error response from daemon: oci runtime error: The maximum number of active connections for UID 0 has been reached.
> >Traceback (most recent call last):
> >  File "./tests/docker/docker.py", line 615, in <module>
> >    sys.exit(main())
> >
> 
> May I ask how I can reproduce this?

To me this just looks like patchew having a problem, I don't think it's
a real qemu bug.

Dave

> >
> >The full log is available at
> >http://patchew.org/logs/20190430034412.12935-1-richardw.yang@linux.intel.com/testing.asan/?type=message.
> >---
> >Email generated automatically by Patchew [https://patchew.org/].
> >Please send your feedback to patchew-devel@redhat.com
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
