Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gZz-0005KN-Rv
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gZw-0002Bi-L6
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:31:59 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:50669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e6gZw-0002Ay-DR
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:31:56 -0400
Received: by mail-wr0-x243.google.com with SMTP id p96so4313284wrb.7
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 10:31:56 -0700 (PDT)
Date: Mon, 23 Oct 2017 19:31:52 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171023173152.GD15029@stefanha-x1.localdomain>
References: <20171013132507.GH20515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171013132507.GH20515@redhat.com>
Subject: Re: [Qemu-devel] QEMU CII Best Practices record
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Oct 13, 2017 at 02:25:07PM +0100, Daniel P. Berrange wrote:
> Many projects these days are recording progress wrt CII best practices
> for FLOOS projects. I filled out a record for QEMU:
> 
>   https://bestpractices.coreinfrastructure.org/projects/1309
> 
> I only looked at the 'Passing' criteria, not considered the 'Silver' and
> 'Gold' criteria. So if anyone else wants to contribute, register an
> account there and tell me the username whereupon I can add you as a
> collaborator.
> 
> Two items I don't think QEMU achieves for the basic "Passing" criteria
> 
>  -  The release notes MUST identify every publicly known vulnerability
>     that is fixed in each new release.
> 
>     I don't see a list of CVEs mentioned in our release Changelogs or
>     indeed a historic list of CVEs anywhere even outside the release
>     notes ?
> 
>  - It is SUGGESTED that if the software produced by the project includes
>    software written using a memory-unsafe language (e.g., C or C++), then
>    at least one dynamic tool (e.g., a fuzzer or web application scanner)
>    be routinely used in combination with a mechanism to detect memory
>    safety problems such as buffer overwrites.
> 
>    NB this is not 'coverity' which falls under the 'static anlaysis'
>    group. I'm unclear if anyone in the community does regular fuzzing
>    or analysis with ASAN & equiv ?

I'm not aware of automated ASAN or Valgrind runs although developers
tend to run them in ad-hoc fashion during development.

Stefan
