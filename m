Received: from eggs.gnu.org ([2001:4830:134:3::10]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5rEb-0005H6-0i
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5rEX-0001RM-Sn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:14:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5rEX-0001Oy-Od
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:14:41 -0400
Date: Tue, 10 Apr 2018 19:14:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180410111422.GG27604@xz-mi>
References: <20180410054034.20479-1-peterx@redhat.com>
	<20180410084950.GB2785@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410084950.GB2785@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: don't warn SDL abi if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, Apr 10, 2018 at 04:49:50PM +0800, Fam Zheng wrote:

[...]

> We have had
> 
>     function_name()
>     {
>     ...
> 
> and
> 
>     function_name() {
>     ...
> 
> and
> 
>     function_name () {
>     ...
> 
> finally you invent the last in the family:
> 
>     function_name ()
>     {
> 
> :)

I was careful about whether we were using the "function" keyword, but
still that seems to be not enough... :-)

[...]

> Reviewed-by: Fam Zheng <famz@redhat.com>

Thanks!

-- 
Peter Xu
