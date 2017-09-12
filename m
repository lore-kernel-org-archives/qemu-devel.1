Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1drlxP-0000YJ-AZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1drlxJ-0004d9-Dv
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1drlxJ-0004ch-7B
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A7CE5AFC7
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 14:14:24 +0000 (UTC)
Message-ID: <1505223994.31639.20.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Sep 2017 15:46:34 +0200
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

  Hi,

> The keycodemapdb code is designed to be used as a git sub-module, it
> is
> not an external dependancy you need installed before use. In this
> version,
> however, the sub-module is not directly use. Instead all the
> generated
> files are checked into GIT. The downside to this is that we get an
> enourmous pile of errors from checkpatch.pl. The tool that generates
> the
> mapping files doesn't care about QEMU's coding style rules, because
> it is
> a general purpose tool intended for use by many different projects.
> 
> As such I'm not very happy about the idea of checking the generated
> files into
> GIT, and would prefer to go back to generating the files from the
> submodule
> on every build, as was done in v4.

The submodule approach has its share of issues too, just see how many
patch versions you've needed until patchew builds actually worked.  And
I guess lots of people have qemu build scripts which likewise need
adjustments.  Handling of release tarballs must be considered too.

I still think we should not require a checked out keycodemapdb
submodule.  But maybe it'll work better if we check in a copy of the
script and database instead of checking in the generated files.

cheers,
  Gerd
