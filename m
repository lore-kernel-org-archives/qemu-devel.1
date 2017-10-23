Received: from eggs.gnu.org ([2001:4830:134:3::10]:38537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6gxL-0002s1-Mi
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6gxK-00059t-PO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:56:07 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:52616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6gxK-00059D-H7
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:56:06 -0400
Received: by mail-wr0-x236.google.com with SMTP id k62so18247243wrc.9
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 10:56:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013132507.GH20515@redhat.com>
References: <20171013132507.GH20515@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2017 18:55:44 +0100
Message-ID: <CAFEAcA9qtKi+hPTOBfZqZ97p=J+_3hmq-aNT8m-9ypKN-=+-AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 October 2017 at 14:25, Daniel P. Berrange <berrange@redhat.com> wrote:
> Many projects these days are recording progress wrt CII best practices
> for FLOOS projects. I filled out a record for QEMU:
>
>   https://bestpractices.coreinfrastructure.org/projects/1309
>
> I only looked at the 'Passing' criteria, not considered the 'Silver' and
> 'Gold' criteria. So if anyone else wants to contribute, register an
> account there and tell me the username whereupon I can add you as a
> collaborator.

For the questions about "50% of bug reports must be acknowledged"
and ditto enhancement requests, did you mine the launchpad data
or are you just guessing? :-) Similarly for vulnerability report
response time.

I think you're fudging the test-policy questions in our favour a bit.

>  -  The release notes MUST identify every publicly known vulnerability
>     that is fixed in each new release.
>
>     I don't see a list of CVEs mentioned in our release Changelogs or
>     indeed a historic list of CVEs anywhere even outside the release
>     notes ?

Indeed I don't think we do this. I would say that as a project we
essentially push the job of rolling new releases for CVEs, informing
users about CVE fixes, etc, to our downstream distributors.

I suspect we only pass the "no vulns unpatched for more than 60 days"
if you allow "patched in bleeding edge master and in distros
but not in any upstream release" to count.

thanks
-- PMM
