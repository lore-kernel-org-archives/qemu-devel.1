Received: from eggs.gnu.org ([2001:4830:134:3::10]:52637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdenber@gmx.com>) id 1fpIHd-0001Hz-Jl
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdenber@gmx.com>) id 1fpIHZ-0006Sy-Je
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:13:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:58997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdenber@gmx.com>) id 1fpIHZ-0006Sq-8d
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:13:37 -0400
References: <5B7054D9.9000209@gmx.com> <20180813083408.GG22904@redhat.com>
From: Michele Denber <mdenber@gmx.com>
Message-ID: <5B71D858.2080907@gmx.com>
Date: Mon, 13 Aug 2018 15:13:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180813083408.GG22904@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] QEMU on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 08-13-2018 4:34 AM, Daniel P. Berrangé wrote:
> Copying Peter, as he would need access to a Solaris host to do GIT pre-merge
> build testing.
>
> Then there's the question of what ordinary developers would use for their own
> testing if they needed to work on some portability issue. We've got support
> in tree for running builds against VM images for the various *BSDs, and have
> mingw cross build toolchain for Windows. Is it possible to provide free-to-use
> VM disk images for Solaris build testing, or are software licensing requirements
> going to get in the way of developers using them ?
Correct me if I'm wrong but I assume you're referring to the use of the 
Solaris OS itself.  Solaris 10 and 11 are both available for free 
download from Oracle.  I read the license agreement 
(http://www.oracle.com/technetwork/licenses/solaris-cluster-express-license-167852.html) 
and while I'm not a lawyer and do not even play one on the Internet, the 
relevant part seems to be:

*"LICENSE RIGHTS *
Except for any included software package or file that is licensed to you 
by Oracle under different license terms, we grant you a perpetual 
(unless terminated as provided in this agreement), nonexclusive, 
nontransferable, limited License to use the Programs only for the 
purpose of developing, testing, prototyping and demonstrating your 
applications, and not for any other purpose. If You are an educational 
institution vested with the power to confer official high school, 
associate, bachelor, master and/or doctorate degrees, or local 
equivalent, (“Degree(s)”), You may also use the Programs as part of Your 
educational curriculum for students enrolled in Your Degree program(s) 
solely as required for the conferral of such Degree (collectively 
“Educational Use”)."

I /think /that means it's OK to use it.  ???
>
> There is OpenIndiana that forked off OpenSolaris, but I'm unclear how far
> OpenIndiana and commercial Solaris have diverged since then ?
One problem with OpenIndiana is that it's not available for SPARC. 
However, they refer to Dilos, OpenSXCE and Tribblix, though I know 
nothing of any of those.

             - Michele
