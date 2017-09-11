Received: from eggs.gnu.org ([2001:4830:134:3::10]:55225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drQm0-0000fS-4A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drQlw-0004M7-7w
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drQlw-0004Ld-2H
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:37:16 -0400
References: <20170904142608.4897-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79e30c8c-9c0b-cd17-5f19-1736124c42d5@redhat.com>
Date: Mon, 11 Sep 2017 17:37:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170904142608.4897-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH web 0/2] Secure the download links and more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 04/09/2017 16:26, Daniel P. Berrange wrote:
> Peter pointed out a bit of a crazy setup:
> 
> The front page link to the 2.10.0 tarball is
> 
>   http://download.qemu-project.org/qemu-2.10.0.tar.xz
> 
> which gets you a 301 redirect to
> 
>   http://download.qemu.org/qemu-2.10.0.tar.xz
> 
> which gets you a 301 redirect to
> 
>   https://download.qemu.org/qemu-2.10.0.tar.xz...
> 
> which gives the $BAD guys plenty chance to compromise your
> download. Fix this to link to https:// sites exclusively
> and use the preferred qemu.org domani too. All links are
> fixed to use https, not merely download site links.
> 
> Daniel P. Berrange (2):
>   Update all links to prefer qemu.org over qemu-project.org
>   Use https links whereever possible
> 
>  .htaccess                                            |  6 +++---
>  _download/source.html                                | 12 ++++++------
>  _includes/footer.html                                | 18 +++++++++---------
>  _includes/releases.html                              |  8 ++++----
>  _posts/2017-02-04-the-new-qemu-website-is-up.md      | 10 +++++-----
>  _posts/2017-03-19-qemu-in-the-blogs-february-2017.md |  4 ++--
>  _posts/2017-08-10-deprecation.md                     |  2 +-
>  contribute.md                                        |  8 ++++----
>  contribute/report-a-bug.md                           |  6 +++---
>  documentation.md                                     |  8 ++++----
>  index.html                                           |  2 +-
>  11 files changed, 42 insertions(+), 42 deletions(-)
> 

Queued, including changes to the 2.10.0 blog post in patch 2.  Will push
tomorrow.

Paolo
