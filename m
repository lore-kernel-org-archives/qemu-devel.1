Received: from eggs.gnu.org ([2001:4830:134:3::10]:49100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2zxi-00089E-P4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2zxf-0003Ef-Js
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:25:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2zxf-0003Cj-C1
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71AA1356D7
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:25:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09F27619A4
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:25:09 +0000 (UTC)
Date: Fri, 13 Oct 2017 14:25:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171013132507.GH20515@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] QEMU CII Best Practices record
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Many projects these days are recording progress wrt CII best practices
for FLOOS projects. I filled out a record for QEMU:

  https://bestpractices.coreinfrastructure.org/projects/1309

I only looked at the 'Passing' criteria, not considered the 'Silver' and
'Gold' criteria. So if anyone else wants to contribute, register an
account there and tell me the username whereupon I can add you as a
collaborator.

Two items I don't think QEMU achieves for the basic "Passing" criteria

 -  The release notes MUST identify every publicly known vulnerability
    that is fixed in each new release.

    I don't see a list of CVEs mentioned in our release Changelogs or
    indeed a historic list of CVEs anywhere even outside the release
    notes ?

 - It is SUGGESTED that if the software produced by the project includes
   software written using a memory-unsafe language (e.g., C or C++), then
   at least one dynamic tool (e.g., a fuzzer or web application scanner)
   be routinely used in combination with a mechanism to detect memory
   safety problems such as buffer overwrites.

   NB this is not 'coverity' which falls under the 'static anlaysis'
   group. I'm unclear if anyone in the community does regular fuzzing
   or analysis with ASAN & equiv ?

If i'm wrong just say....

There's many questions under Silver/Gold level we likely don't meet and
some of them start to get quiet opinionated about the way a project
should be run, so IMHO its not unreasonable to say we're not going to aim
for perfection in this respect.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
