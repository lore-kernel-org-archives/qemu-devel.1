Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTa9-0001xR-Ls
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTa6-0002Bs-Hd
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:08:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDTa6-0002AE-8Q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:08:42 -0400
References: <20181018145203.11336-1-berrange@redhat.com>
	<c11576e1-9644-66e7-7dc6-b9d0ee4b537f@redhat.com>
	<20181019102528.GG13722@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7cec56c-5871-8a98-42f9-506f9b215569@redhat.com>
Date: Fri, 19 Oct 2018 14:08:37 +0200
MIME-Version: 1.0
In-Reply-To: <20181019102528.GG13722@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [web PATCH 0/4] Add web section reporting
 information about CVEs in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Thomas Huth <thuth@redhat.com>

On 19/10/2018 12:25, Daniel P. Berrang=C3=A9 wrote:
> I really don't want to use an application specific templating system.
> While we're using Jekyll for the website today, I don't think it is
> a good idea to assume that for the longer term.
>=20
> Even today I can't actually run the jekyll website on my laptop because
> the qemu-web content uses templating syntax from an older version of
> Jekyll that has been deleted in the current Jekyll versions. So I have
> to hack the code to remove pieces, in order to do testing.

Note that you can use

   bundle install --path .gems
   bundle exec jekyll serve

in order to use locally-downloaded gems.

That said, we should indeed update Jekyll to a more recent version.

Paolo
