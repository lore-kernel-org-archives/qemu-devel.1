Received: from eggs.gnu.org ([2001:4830:134:3::10]:45164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbNIL-0004oe-UG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbNIF-0003q0-QP
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:08:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cbNIF-0003pB-LL
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:07:59 -0500
References: <20170207155956.21573-1-pbonzini@redhat.com>
	<148651459898.3978.14777421131469511630@loki>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0233aedd-33f0-7ec7-6d20-4b2999b6af63@redhat.com>
Date: Wed, 8 Feb 2017 09:07:56 +0100
MIME-Version: 1.0
In-Reply-To: <148651459898.3978.14777421131469511630@loki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 08/02/2017 01:43, Michael Roth wrote:
>>  _includes/releases.html | 4 ++--
> 
> Somewhat related: I think _data/releases.yml needs to be updated as it's
> still referencing 2.7.0 instead of 2.7.1. Would one just start updating
> that file with each new release, or is there some other process?

Yes, that's enough.  When you update that file and "git push", all
references are fixed (there are two, in the homepage and the download
page).  Likewise for _data/screenshots.yml.

Paolo
