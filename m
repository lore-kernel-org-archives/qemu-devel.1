Received: from eggs.gnu.org ([2001:4830:134:3::10]:43801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZwJP-0000wx-PV
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZwJO-0002bD-Rt
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZwJO-0002aQ-Lu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:39:30 -0400
Date: Tue, 25 Jul 2017 10:39:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725093921.GK26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.28627297ce9b47260986349ac22bf2de37bb9be6.1500709594.git-series.knut.omang@oracle.com>
	<f65fafa6dbfe151b16cc1b2528ddb7ab7e9fbfcf.1500709594.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f65fafa6dbfe151b16cc1b2528ddb7ab7e9fbfcf.1500709594.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] sockets: factor out a new
 try_bind() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Sat, Jul 22, 2017 at 09:49:32AM +0200, Knut Omang wrote:
> Another refactoring step to prepare for the problem
> exposed by the test-listen test.
> 
> This time simplify and reorganize the IPv6 specific extra
> measures and move it out of the for loop to increase
> code readability. No semantic changes.
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  util/qemu-sockets.c | 69 ++++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
